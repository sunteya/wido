module SimpleForm
  module Inputs
    class DatepickerInput < Base

      def input
        value = object.send(attribute_name)
        input_html_options[:value] ||= localized(value)
        input_html_options[:"data-format"] ||= "YYYY-MM-DD"

        '<div class="input-group">' + 
          @builder.text_field(attribute_name, input_html_options) +
          '<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>' +
        '</div>'
      end

    protected
      def localized(time)
        time.try(:to_date)
      end
    end
  end
end