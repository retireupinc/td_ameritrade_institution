module TDAmeritradeInstitution
  module Requests
    class Base
      include ::TDAmeritradeInstitution::Requester

      class << self
        attr_reader :xml_template_path

        def build(params = {})
          new(params).build_request
        end

        def call(access_token:, params:)
          new(access_token: access_token).call(**params)
        end

        def xml_template(filepath)
          @xml_template_path = filepath
        end
      end

      def config
        TDAmeritradeInstitution.config
      end

      def build_xml
        template_path = self.class.xml_template_path
        raise "No XML template specified" unless template_path
        filepath = File.join(TDAmeritradeInstitution.root_path, template_path)
        erb = ERB.new(File.read(filepath))
        erb.result(binding)
      end

      def xml_response_wrap
        response = yield
        Nokogiri::XML(response.body)
      end
    end
  end
end
