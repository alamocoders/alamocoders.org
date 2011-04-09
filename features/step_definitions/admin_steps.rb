require 'rack/test'
include Rack::Test::Methods

Given /^I have access to the admin panel$/ do
  test_user = User.new
  test_user = :username=>'foo', :password=>'foo')
  authorize 'foo', 'foo'
end

When /^I add the user from the admin panel$/ do
  @user = "jobob"
  @pass = "pass123"
  post '/users/add', {:username=>@user, :pass=>@pass}
end

Then /^they will show up in the list of directors$/ do
  get '/users'
  @user_obj = Users.where(:username.eq => @user)[0]
  assert_equal "<a href='/users/#{@user_obj.id}'>#{@user}</a>", last_response.body
end

Then /^be able to log in themselves$/ do
  authorize @user, @pass
  get '/users'
  assert_equal 200, last_response.status
end

