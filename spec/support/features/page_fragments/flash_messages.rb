module PageFragments
  module FlashMessages
    def text
      browser.find("#flash_messages").text
    end
  end
end
