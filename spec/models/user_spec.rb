require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Validations' do
    it 'should be an error if password and password confirmation fields do not match' do
      user = User.new(first_name: "abc", last_name: "efg", email: 'test@test.com', password: '123456', password_confirmation: '123456789')
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should be an error if password is empty' do
      user = User.new(first_name: "abc", last_name: "efg", email: 'test@test.com', password: nil, password_confirmation: '123456')
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should be an error if password confirmation is empty' do
      user = User.new(first_name: "abc", last_name: "efg", email: 'test@test.com', password: '123456', password_confirmation: nil)
      user.save
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should be an error if email is not unique, not case sensitive' do
      user1 = User.new(first_name: "abc", last_name: "efg", email: 'test@test.com', password: '123456', password_confirmation: '123456')
      user1.save
      user2 = User.new(first_name: "abc", last_name: "efg", email: 'TEST@TEST.com', password: '123456', password_confirmation: '123456')
      user2.save
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should be an error if email is empty' do
      user = User.new(first_name: "abc", last_name: "efg", email: nil, password: '123456', password_confirmation: '123456')
      user.save
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should be an error if first name is empty' do
      user = User.new(first_name: nil, last_name: "efg", email: 'test@test.com', password: '123456', password_confirmation: '123456')
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should be an error if last name is empty' do
      user = User.new(first_name: 'abc', last_name: nil, email: 'test@test.com', password: '123456', password_confirmation: '123456')
      user.save
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should be an error if password length less than 6' do
      user = User.new(first_name: 'abc', last_name: nil, email: 'test1@test.com', password: '123', password_confirmation: '123')
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    before do
      user = User.new(first_name: 'abc', last_name: 'efg', email: 'test1@test.com', password: '123456', password_confirmation: '123456')
      user.save
    end

    it 'should return nil if not successfully authenticated' do
      expect(User.authenticate_with_credentials('test1@test.com', '123')).to eql(nil)
    end

    it 'should not return nil if successfully authenticated' do
      expect(User.authenticate_with_credentials('test1@test.com', '123456')).not_to eql(nil)
    end

    it 'should be authenticated successfully if a visitor types in a few spaces before and/or after their email address' do
      expect(User.authenticate_with_credentials('  test1@test.com  ', '123456')).not_to eql(nil)
    end

    it 'should be authenticated successfully if a visitor types in the wrong case for their email' do
      expect(User.authenticate_with_credentials('test1@test.COM', '123456')).not_to eql(nil)
    end

  end
end
