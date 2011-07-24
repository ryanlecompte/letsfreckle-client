module LetsFreckle
  class Configuration

    [:account, :token].each do |method_name|
      define_method(method_name) do |value=nil|
        instance_variable_set("@#{method_name}", value) if value
        instance_variable_get("@#{method_name}")
      end
    end

    def to_s
      "account = #{account}, authentication token = #{token}"
    end
  end
end
