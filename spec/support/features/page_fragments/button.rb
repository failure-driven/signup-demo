module PageFragments
  module Button
    def text
      browser.find("a.btn").text
    end
  end
end
