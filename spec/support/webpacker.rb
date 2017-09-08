RSpec.configure do |config|
  config.before(:suite) do
    Webpacker.compile
  end
end
