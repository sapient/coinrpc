require 'http'
require 'oj'
require 'coinrpc/version'

module CoinRPC
  class Client
    def initialize(url)

      urinfo = URI.parse(url)

      @client = HTTP.persistent("http://#{urinfo.host}:#{urinfo.port}").timeout(60).basic_auth({:user => urinfo.user, :pass => urinfo.password})
      @id = rand(1000000)

    end

    def method_missing(method, *args)

      @id += 1

      fixed_method = method.to_s.gsub(/\_/,"").freeze

      post_data = nil
      
      if args.first.is_a?(Array) and args.first.size > 0 then
        # batch request

        post_data = []

        args.each do |arg|
          @id += 1
          post_data << ({:jsonrpc => "2.0", :method => fixed_method, :params => arg, :id => @id})
        end

      else

        post_data = ({
                       :method => fixed_method,
                       :params => args,
                       :jsonrpc => "1.1",
                       :id => @id
                     })
        
      end
      
      return api_call(post_data)
      
    end

    private
    def api_call(params)

      response = @client.post("/", :body => Oj.dump(params, mode: :compat)).to_s

      result = Oj.strict_load(response, :decimal_class => BigDecimal)
      
      raise result['error']['message'] if !result.is_a?(Array) and result['error']

      return result['result'] if result.is_a?(Hash)

      # batch call
      return result.map{|r| r['result'] || r['error']}

    end
    
  end

end
