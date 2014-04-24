module LetsFreckle
  class Configuration
    [:username, :account_host, :token].each do |method_name|
      define_method(method_name) do |*value|
        case value.length
        when 0 ; value = nil
        when 1 ; value = value[0]
        else
          raise ArgumentError, "Too many arguments (#{value.length} for 0,1)"
        end

        instance_variable_set("@#{method_name}", value) if value
        instance_variable_get("@#{method_name}")
      end
    end
  end
end
