module TDAmeritradeInstitution
  module Models
    class Base
      class AttributeError < StandardError; end
      class ModelError < StandardError; end
      class << self
        def attribute(name, &blk)
          define_method("#{name}=") do |val|
            instance_variable_set("@#{name}", val)
          end

          define_method("#{name}") do
            if instance_variable_defined?("@#{name}")
              instance_variable_get("@#{name}")
            else
              blk && blk.call
            end
          end
        end

        def model(name, required:, modeled_by:, &blk)
          model_store[name] = {
            required: required,
            modeled_by: modeled_by,
            blk: blk
          }
          define_method("#{name}=") do |val|
            unless Array(modeled_by).any? { |klass| val.is_a?(klass) }
              raise ModelError.new("#{name} must be one of #{modeled_by}")
            end
            instance_variable_set("@#{name}", val)
          end

          define_method("#{name}") do
            if instance_variable_defined?("@#{name}")
              instance_variable_get("@#{name}")
            else
              blk && blk.call
            end
          end
        end

        def model_store
          @model_store ||= {}
        end
      end

      def initialize(**params)
        params.each do |k, v|
          self.send("#{k}=", v)
        end
        self.class.model_store.each do |k, v|
          if v.fetch(:required, false) && !instance_variable_defined?("@#{k}")
            raise ModelError.new("#{k} is required")
          end
        end
      end
    end
  end
end
