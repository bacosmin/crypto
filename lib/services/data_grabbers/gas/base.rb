module Services
  module DataGrabbers
    module Gas
      class Base < Services::DataGrabbers::Base

        def price
          result['FastGasPrice']
        end

        private

        def result
          result = parsed_response['result']

          raise "Grab Error: #{parsed_response['result']}" unless result.is_a?(Hash)

          result
        end
      end
    end
  end
end