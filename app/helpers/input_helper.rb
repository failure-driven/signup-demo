module InputHelper
  def model_data(model, args, &block)
    data_attributes = { data: model.to_json }
    args.each{|key,value| data_attributes[[:data, key].join('-')] = value.to_json } 
    content_tag(
      :div,
     data_attributes
    ){
      yield if block_given?
    }
  end

  def react_input_field_for(model, args)
    model_data model, args do
      javascript_pack_tag 'signup'
    end
  end
end
