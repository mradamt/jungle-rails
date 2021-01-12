require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    valid_user = {first_name: 'first', last_name: 'last', email: 'test@test.com', password: 'password', password_confirmation: 'password'}

    describe "valid new user" do
      before do
        @user = User.new(valid_user)
        @user.save
      end
      
      it "saves successfully" do
        expect(User.last).to eq(@user)
      end
    end
    
    describe "invalid new user" do
  
      context "missing field:" do
        
        before do
          @user = User.new
          @user.save
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
          @user1 = User.new(valid_user)
          @user1.save
          @user2 = User.new(email: 'TEST@test.com')
          @user2.save
        end
        
        it "raises error 'email already exists in the DB'" do
          expect(@user2.errors.full_messages).to include("email address already exists")
        end
      end

      context "password" do

        context "fields are different" do
          before do
            @user = User.new(password: 'one', password_confirmation: 'two')
            @user.save
          end

          it "raises error 'Password confirmation doesn't match Password'" do
            expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
          end
        end
                
        context "length" do
          before do
            @user = User.new(password: 'short', password_confirmation: 'short')
            @user.save
          end

          it "raises error 'password must be at least 8 characters'" do
            expect(@user.errors.full_messages).to include("Password must be at least 8 characters")
          end
        end
      end
    end
  end
end
