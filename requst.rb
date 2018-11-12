load 'tamagochi.rb'
require 'erb'

class Requst
  attr_accessor :method, :path, :tamagochi
  def call(env)
    self.method = env['REQUEST_METHOD'].downcase
    self.path = env['REQUEST_PATH']
    self.tamagochi ||= Tamagochi.new

    public_send(processed_methods_name)

    Rack::Response.new(render('index.html.erb'))
  rescue NoMethodError
    Rack::Response.new('Not Found', 404)
  end

  def processed_methods_name
    @a = "#{method}#{path}".gsub('/', '_')
  end

  def get_
    @a.gsub(/_$*/, '/')
    tamagochi
  end

  def get_feed
    @a.gsub(/_$*/, '/')
    tamagochi.feed
  end

  def get_clean
    @a.gsub(/_$*/, '/')
    tamagochi.clean
  end

  def get_sleep
    @a.gsub(/_$*/, '/')
    tamagochi.sleep
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__ )
    ERB.new(File.read(path)).result(binding)
  end
end
