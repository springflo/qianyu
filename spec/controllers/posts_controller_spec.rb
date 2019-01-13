require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  render_views

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(login_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(login_path)
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(create(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create a post" do
        lambda do
          post :create, :post => @attr
        end.should_not change(Post, :count)
      end
    
    end

    describe "success" do
      
      before(:each) do
        @attr = { :content => "Lorem ipsum dolor sit amet" }
      end
      
      it "should create a post" do
        lambda do
          post :create, :post => @attr
        end.should change(Post, :count).by(1)
      end
      
      it "should redirect to the root path" do
        post :create, :post => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash success message" do
        post :create, :post => @attr
        flash[:success].should == "发布成功！"
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do
      
      before(:each) do
        @user = create(:user)
        wrong_user = create(:user)
        @post = create(:post, :user => @user)
        test_sign_in(wrong_user)
      end

      it "should deny access" do
        delete :destroy, :id => @post
        response.should redirect_to(root_path)
      end
    end
    
    describe "for an authorized user" do
      
      before(:each) do
        @user = test_sign_in(create(:user))
        @post = create(:post, :user => @user)
      end
      
      it "should destroy the post" do
        lambda do
          delete :destroy, :id => @post
          response.should redirect_to(root_path)
        end.should change(post, :count).by(-1)
      end
    end
  end
end





