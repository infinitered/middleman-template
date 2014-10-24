module ViewHelpers
  def image_tag_2x(name_at_1x, options={})
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag(name_at_1x, options.merge("data-at2x" => asset_path(:images, name_at_2x)))
  end

  def inline_svg(path)
    File.open("source/assets/images/#{path}", "rb") do |file|
      file.read
    end
  end
end
