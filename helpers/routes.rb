module Routes
  def self.get(name, path)
    define_method "#{name}_path" do
      path
    end
    define_method "#{name}_url" do
      path
    end
  end

  # Define your routes here
  get :home, "/"

end
