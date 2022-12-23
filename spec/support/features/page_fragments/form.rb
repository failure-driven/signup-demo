module PageFragments
  module Form
    class Input
      def initialize(node)
        @node = node
      end

      def class
        @node[:class]
      end
    end

    def error_message
      browser.find("#error_explanation").find_all("li").map(&:text)
    end

    def input_for(input_name)
      Input.new(browser.find(%(input[name="#{input_name}"])))
    end

    def submit
      browser.click_on("Sign up")
    end

    def inputs
      label_input_tags(browser)
    end

    private

    def label_input_tags(browser)
      browser.synchronize do
        browser
          .find_all('div[class="form-group"]')
          .to_h do |element|
          [
            find_field_in_element(element, "label", :text),
            find_field_in_element(element, "input", :value)
          ]
        end
      end
    end

    def find_field_in_element(element, field_name, value)
      element.find(field_name).send(value)
    rescue
      "NO-#{field_name.upcase}-FOUND"
    end
  end
end
