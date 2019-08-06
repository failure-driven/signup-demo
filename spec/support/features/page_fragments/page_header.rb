module PageFragments
  module PageHeader
    def title
      browser.find('h4').text
    end
  end
end
