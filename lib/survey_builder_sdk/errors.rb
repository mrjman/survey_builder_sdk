module SurveyBuilder
  class InternalServerError < StandardError; end
  class ConnectionFailedError < StandardError; end
  
  class RaiseError < Faraday::Response::Middleware
    def call(env)
      begin
        @app.call(env).on_complete do |environment|
          on_complete(environment)
        end
      rescue Faraday::Error::ClientError => e
        raise SurveyBuilder::InternalServerError
      end
    end

    def on_complete(env)
      case env[:status]
      when 407
        # mimic the behavior that we get with proxy requests with HTTPS
        raise SurveyBuilder::ConnectionFailedError, %{407 "Proxy Authentication Required "}
      when 500
        raise SurveyBuilder::InternalServerError
      end
    end
  end
end
