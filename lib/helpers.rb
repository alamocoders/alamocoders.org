module Auth

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Alamocoders login") and throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    if @auth.provided? && @auth.basic? && @auth.credentials
      users = User.all(:username=>@auth.credentials[0])
      if(users.count > 0)
        return users[0].password == @auth.credentials[1]
      end
    end
    false
  end

end

module Database
  
  def self.connect
    if ENV['MONGOHQ_HOST']
      puts "Running on MongoHQ" 
      MongoMapper.connection = Mongo::Connection.new(ENV['MONGOHQ_HOST'], ENV['MONGOHQ_PORT'])
      MongoMapper.database = ENV['MONGOHQ_DATABASE']
      MongoMapper.database.authenticate(ENV['MONGOHQ_USER'],ENV['MONGOHQ_PASSWORD'])
    else
      puts "Using local database" 
      MongoMapper.database = 'alamocoders'
    end
  end

end
