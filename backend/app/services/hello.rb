class Hello
  # include Core::Service

  def call(name)
    Success("Hello, #{name}!")
  end
end
