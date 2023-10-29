require "capybara/rspec"
require "capybara/rails"
require "capybara-inline-screenshot/rspec"

# Make browser slow down execution to see what's going on
# in the browser (when running non-Headless)
module SlomoBridge
  TIMEOUT = ENV.fetch('SLOMO_MS', '0').to_i / 1000.0

  def execute(*)
    sleep TIMEOUT if TIMEOUT > 0
    super
  end
end

# Don't wait too long in `have_xyz` matchers
Capybara.default_max_wait_time = 2 # the default is 2

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome
  ).tap do |driver|
    # Enable slomo mode
    driver.browser.send(:bridge).singleton_class.prepend(SlomoBridge)
  end
end

Capybara.javascript_driver = :selenium_chrome

Capybara::Screenshot.webkit_options = {
  width: 1024,
  height: 768
}

Capybara::Screenshot.register_driver(:selenium_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
