class MyApp
  def call(env)
    content = "Hello, world\n"
    [200, {"Content-Length" => content.bytesize.to_s}, [content]]
  end
end

run MyApp.new
