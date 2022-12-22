module InputHelper
  def model_data(model, args)
    data_attributes = { data: model.to_json }
    args.each do |key, value|
      data_attributes[[:data, key].join('-')] = value.to_json
    end
    content_tag(
      :div,
      data_attributes
    ) do
      yield if block_given?
    end
  end

  def react_input_with_errors_for(model, args)
    model_data model, args do
      javascript_include_tag 'input_with_errors'
    end
  end
end
