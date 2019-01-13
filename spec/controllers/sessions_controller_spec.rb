require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :email => "", :password => "" }
      end
      
      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
    
    end
    
    describe "success" do
      
      before(:each) do
        @user = create(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.logged_in?.should == true
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    it "should sign a user out" do
      @user = test_sign_in(create(:user))
      delete :destroy
      controller.logged_in?.should_not == true
      response.should redirect_to(root_path)
    end
  end
end
