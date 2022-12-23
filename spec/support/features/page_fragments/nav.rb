module PageFragments
  module Nav
    def go(location)
      browser.find("nav").click_on(location)
    end
  end
end
