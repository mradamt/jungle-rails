require 'rails_helper'

RSpec.describe User, type: :model do

  valid_user = {first_name: 'first', last_name: 'last', email: 'test@test.com', password: 'password', password_confirmation: 'password'}
  
  describe 'Validations' do

    describe "valid new user" do
      before do
        @user = User.create valid_user
      end
      
      it "saves successfully" do
        expect(User.last).to eq(@user)
      end
    end
    
    describe "invalid new user" do
  
      context "missing field:" do
        
        before do
          @user = User.create
        end

        it "first name raises error 'First name can't be blank'" do
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it "last name raises error 'Last name can't be blank'" do
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end

        it "email raises error 'Email can't be blank'" do
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it "password raises error 'Password can't be blank'" do
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it "password confirmation raises error 'Password confirmation can't be blank'" do
          expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
        end
      end

      context "duplicate email" do
        
        before do
          @user1 = User.create valid_user
          @user2 = User.create email: 'TEST@test.com'
        end
        
        it "raises error 'email already exists in the DB'" do
          expect(@user2.errors.full_messages).to include("email address already exists")
        end
      end

      context "password" do

        context "fields are different" do
          before do
            @user = User.create password: 'one', password_confirmation: 'two'
          end

          it "raises error 'Password confirmation doesn't match Password'" do
            expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
          end
        end
                
        context "length" do
          before do
            @user = User.create password: 'short', password_confirmation: 'short'
          end

          it "raises error 'password must be at least 8 characters'" do
            expect(@user.errors.full_messages).to include("Password must be at least 8 characters")
          end
        end
      end
    end
  end

  describe '.authenticate_with_credentials' do

    before do
      @user = User.create valid_user
    end
    
    context 'valid login' do

      it "successfully authenticates a valid user login request" do
        expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq(@user)
      end

      it "successfully authenticates when email has excess whitespace around it" do
        expect(User.authenticate_with_credentials('   test@test.com   ', 'password')).to eq(@user)
      end

      it "successfully authenticates when email is mixed case" do
        expect(User.authenticate_with_credentials('TEST@test.COM', 'password')).to eq(@user)
      end

    end

    context 'invalid login' do

      it "returns nil if email not found in system" do
        expect(User.authenticate_with_credentials('nonexistant@email.com', 'password')).to eq(nil)
      end

      it "returns nil if password is incorrect" do
        expect(User.authenticate_with_credentials('test@test.com', 'incorrect')).to eq(nil)
      end

      it "returns nil if email not found in system" do
        expect(User.authenticate_with_credentials('nonexistant@email.com', 'password')).to eq(nil)
      end

    end
  end
end
