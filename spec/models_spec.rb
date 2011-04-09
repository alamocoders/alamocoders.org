require_relative './spec_helper'

describe User do
  context 'when creating user' do


    before(:each)do
      @user = User.new
      @user.username ="foo"
      @user.password = "wont be able to read me"
      @user.full_name = "foo bar"
      @user.save
      @from_db = User.find(@user.id)
    end

    after(:each) do
        user = User.find(@user.id)
        unless user == nil
          User.destroy(@user.id)
        end
    end

    it 'saves user with username' do
      @from_db.username.should eq("foo")
    end

    it 'saves user with password but hashed' do
      @from_db.password.to_s.should eq BCrypt::Password.new(@user.password_hash).to_s
    end

    it 'saves user with full name' do
      @from_db.full_name = "foo bar"
    end

    context 'when removing user' do
      it 'removes user from db' do
        User.destroy(@from_db.id)
        User.find(@from_db.id).should eq(nil)
      end
    end

    context 'when username is already created' do
      it 'prevents duplicate username' do
        #pending figuring out how to do this in MongoMapper
        #lambda {User.create(:username=>'foo')}.should raise_error
      end
    end
  end

end
