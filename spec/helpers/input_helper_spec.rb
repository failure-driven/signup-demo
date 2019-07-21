require 'rails_helper'

RSpec.describe InputHelper, type: :helper do
  describe "#model_data" do
    it "writes a data content block" do
      model = double("Model",
        field_name: 'the field',
        to_json: {model: 'as json'}.to_json,
        class: 'Model'
      )
      
      expect(
        helper.model_data(
          model,
          field1: 'the field 1',
          field2: 'the field 2',
        )
      ).to eq(
        '<div ' +
          'data="{&quot;model&quot;:&quot;as json&quot;}" ' +
          'data-field1="&quot;the field 1&quot;" ' +
          'data-field2="&quot;the field 2&quot;">' +
        '</div>'
      )
    end
  end

  describe "#react_input_field_for" do
    it "renders a pack tag wrapped in a data model content block" do
      expect(
        helper.react_input_field_for('model', foo: :bar)
      ).to match(
        '<div ' +
          'data=\"&quot;model&quot;\" ' +
          'data-foo=\"&quot;bar&quot;\">' +
          '<script src=\"/packs-test/js/signup-[0-9a-z]+.js\"></script>' +
        '</div>'
      )
    end
  end
end
