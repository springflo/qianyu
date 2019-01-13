require 'rails_helper'


RSpec.describe UsersController, type: :controller do

  # # This should return the minimal set of attributes required to create a valid
  # # User. As you add validations to User, be sure to
  # # adjust the attributes here as well.
  # let(:valid_attributes) {
  #   skip("Add a hash of attributes valid for your model")
  # }

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  # # This should return the minimal set of values that should be in the session
  # # in order to pass any filters (e.g. authentication) defined in
  # # UsersController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  describe "GET 'index'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(login_path)
      end
    end
    
    describe "for signed-in-users" do

      before(:each) do
        @user = test_sign_in(create(:user))
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
    end
  end

  describe "GET 'show'" do
    
    before(:each) do
      @user = create(:user)
    end
  
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    describe "when signed in as another user" do
      it "should be successful" do
        test_sign_in(create(:user))
        get :show, :id => @user
        response.should be_success
      end
    end
  end

  describe "GET 'new'" do
  
    it "should be successful" do
      get :new
      response.should be_success
    end
    
  end
  
  describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
        @attr = { :username => "", :email => "", :password => "",
                  :password_confirmation => "" , :activated => false}
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    end

  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      @user = create(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
  

  describe "PUT 'update'" do
      
    before(:each) do
      @user = create(:user)
      test_sign_in(@user)
    end

    describe "failure" do
      
      before(:each) do
        @attr = { :username => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
    end

    describe "success" do
      
      before(:each) do
        @attr = { :username => "New Name", :email => "user@example.org",
                  :password => "barbaz", :password_confirmation => "barbaz",
                  :activated => true}
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.username.should  == @attr[:username]
        @user.email.should == @attr[:email]
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "authentication of edit/update actions" do
    
    before(:each) do
      @user = create(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
    
      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
    end

    describe "for signed-in users" do
      
      before(:each) do
        wrong_user = create(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end
      
      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      
      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @user = create(:user)
    end
    
    describe "as an admin user" do
      
      before(:each) do
        @admin = create(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(@admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end
      
      it "should redirect to the users page" do
        delete :destroy, :id => @user
        flash[:success].should == "删除用户成功！"
        response.should redirect_to(users_path)
      end
      
      it "should not be able to destroy itself" do
        lambda do
          delete :destroy, :id => @admin
        end.should_not change(User, :count)
      end
    end
  end
end
end
