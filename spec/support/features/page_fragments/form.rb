module PageFragments
  module Form
    class Input
      def initialize(node, input_name)
        @node = node
        @input_name = input_name
      end

      def invalid?
        @node[:class][/is-invalid/] ||
          raise("could not find 'is-invalid' in '#{@node[:class]}'" \
                    "for input '#{@input_name}'")
      end
    end

    def error_message
      browser.find('#error_explanation').find_all('li').map(&:text)
    end

    def input_for(input_name)
      node = browser.find(%(input[name="#{input_name}"]))
      Input.new(node, input_name)
    end

    def submit
      browser.click_on('Sign up')
    end

    def inputs
      label_input_tags(browser)
    end

    private

    def label_input_tags(browser)
      browser.synchronize do
        browser
          .find_all('div[class="form-group"]')
          .map do |element|
          [
            find_field_in_element(element, 'label', :text),
            find_field_in_element(element, 'input', :value)
          ]
        end.to_h
      end
    end

    def find_field_in_element(element, field_name, value)
      element.find(field_name).send(value)
    rescue StandardError
      "NO-#{field_name.upcase}-FOUND"
    end
  end
end
