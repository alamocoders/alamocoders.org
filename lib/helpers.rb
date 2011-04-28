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
        is_logged_in = users[0].password == @auth.credentials[1]
        if is_logged_in
          @current_user = users[0]
        end
        return is_logged_in
      end
    end
    false
  end

end

module View

# Render the page once:
# Usage: partial :foo
# 
# foo will be rendered once for each element in the array, passing in a local variable named "foo"
# Usage: partial :foo, :collection => @my_foos    

helpers do
  def partial(template, *args)
    options = args.extract_options!
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << haml(template, options.merge(
                                  :layout => false, 
                                  :locals => {template.to_sym => member}
                                )
                     )
      end.join("\n")
    else
      haml(template, options)
    end
  end
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
