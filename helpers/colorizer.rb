# From https://github.com/vishaltelangre/term-colorizer/blob/master/lib/term-colorizer/colorizer.rb
module Term
  module Colorizer
    # Standard ANSI color-codes configuration.
    TC_CONFIG = {
      :colors    => {
        :black  => 30, :red   => 31, :green   => 32,
        :yellow => 33, :blue  => 34, :magenta => 35,
        :cyan   => 36, :white => 37
      },
      :bg_colors => {}
    }

    TC_CONFIG[:colors].map do |key, value|
      TC_CONFIG[:bg_colors][key] = value + 10
    end

    module InstanceMethods
      # Returns list of normal color methods.
      def color_methods
        TC_CONFIG[:colors].keys
      end

      # Returns list of bright (bold) color methods.
      def bright_color_methods
        color_methods.collect do |color|
          "bright_#{color}".to_sym
        end
      end

      # Returns list of background color methods.
      def bg_color_methods
        color_methods.collect do |color|
          "bg_#{color}".to_sym
        end
      end

      # Returns list of all public methods provided by term-colorizer gem.
      def term_colorizer_methods
        methods  = []
        methods += color_methods
        methods += bright_color_methods
        methods += bg_color_methods
        methods += [
                    :underline, :strikethrough, :term_colorizer_methods,
                    :fancy_color_methods, :no_underline, :no_strikethrough,
                    :no_color, :no_bg_color, :plain_text, :reset_fancyness
                  ]
      end

      # Alias of `term_colorizer_methods` method.
      def fancy_color_methods
        self.term_colorizer_methods
      end

      # Overrides `method_missing` method's default behaviour to define the
      # term colorizer methods on the fly when called.
      def method_missing(method, *args, &block)
        super unless term_colorizer_methods.include? method
        self.class.send(:define_method, method) do
          str = self
          str = add_normal_color(str, method) if color_methods.include? method
          str = add_bright_color(str, method) if bright_color_methods.include? method
          str = add_bg_color(str, method)     if bg_color_methods.include? method
          str = add_underline(str)            if "underline".eql? method.to_s
          str = add_strikethrough_effect(str) if "strikethrough".eql? method.to_s
          str = str + "\e[0m" unless str.end_with? "\e[0m"
          str
        end and self.send(method, *args)
      end

      # Overrides `respond_to?` method so as to it will return true when asked
      # for any of term colorizer methods.
      def respond_to_missing?(method, include_private = false)
        term_colorizer_methods.include? method || super
      end

      # Returns original plain text string by cleaning all the fancyness added
      # to it by term colorizer methods.
      def plain_text
        self.gsub(/\e\[[0-9]m|\e\[[34][0-7]m/, '')
      end

      # Alias of `plain_text` method.
      def reset_fancyness
        self.plain_text
      end

      # Returns string by cleaning off colors added to it by term colorizer
      # methods.
      def no_color
        reset_prev_formatting self, :color
      end

      # Returns string by cleaning off background colors added to it by term
      # colorizer methods.
      def no_bg_color
        reset_prev_formatting self, :bg_color
      end

      # Returns string by removing underlines in it.
      def no_underline
        reset_prev_formatting self, :underline
      end

      # Returns string by removing strikethrough effect(s) added to it.
      def no_strikethrough
        reset_prev_formatting self, :strikethrough
      end

      private

      # Private method returns string by adding normal color effect
      def add_normal_color(str, color)
        str = reset_prev_formatting str, :color
        "\e[#{TC_CONFIG[:colors][color].to_s}m#{str}"
      end

      # Private method returns string by adding bright (bold) color effect
      def add_bright_color(str, color)
        color = color.to_s.sub("bright_", "").to_sym
        str   = reset_prev_formatting str, :color
        "\e[1m\e[#{TC_CONFIG[:colors][color].to_s}m#{str}"
      end

      # Private method returns string by adding background color effect
      def add_bg_color(str, color)
        color = color.to_s.sub("bg_", "").to_sym
        str   = reset_prev_formatting str, :bg_color
        "\e[#{TC_CONFIG[:bg_colors][color].to_s}m#{str}"
      end

      def add_underline(str)
        "\e[4m#{str}"
      end

      def add_strikethrough_effect(str)
        "\e[9m#{str}"
      end

      # Cleans off string formatting for colors or background colors added by
      # term colorizer methods previously
      def reset_prev_formatting(str, type)
        case type
        when :color
          str = str.gsub("\e[1m", '').gsub(/\e\[[3][0-7]m/, '')
        when :bg_color
          str = str.gsub(/\e\[[4][0-7]m/, '')
        when :underline
          str = str.gsub("\e[4m", '')
        when :strikethrough
          str = str.gsub("\e[9m", '')
        end

        # Remove ANSI termination characters from `str`.
        str = str.gsub("\e[0m", '')

        # Hack! Add ANSI termination character at the end of `str` if `str`
        # contains any fancy stuff added by term colorizer methods before.
        if str.scan(/\e\[[1-9]/).any?
          str = str + "\e[0m" unless str.end_with? "\e[0m"
        end

        return str
      end
    end

    def self.included(base)
      base.send :include, InstanceMethods
    end
  end
end

class String
  include Term::Colorizer
end