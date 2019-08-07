module PageFragments
  module Profile
    def values
      browser
          .find_all('p strong')
          .map do |p_element|
        strong_text = p_element.text
        [
            strong_text,
            p_element.find(:xpath, '..').text.sub(strong_text, '').strip
        ]
      end.to_h
    end
  end
end
