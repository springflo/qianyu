require 'rails_helper'

# RSpec.describe Post, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


# require 'spec_helper'

RSpec.describe Post, type: :model do

  before(:each) do
    @user = create(:user)
    @attr = { :content => "lorem ipsum" }
  end
  
  it "should create a new instance with valid attributes" do
    @user.posts.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @post = @user.posts.create(@attr)
    end
    
    it "should have a user attribute" do
      @post.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @post.user_id.should == @user.id
      @post.user.should == @user
    end
  end
  
  describe "validations" do

    it "should have a user id" do
      Post.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.posts.build(:content => "    ").should_not be_valid
    end
    
    it "should reject long content" do
      @user.posts.build(:content => "a" * 141).should_not be_valid
    end
  end

end
