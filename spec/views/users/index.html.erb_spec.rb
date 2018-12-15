require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :email => "Email@gmail.com",
        :username => "Username",
        :password => "Password"
      )
    ])
  end

  it "renders a list of users" do
    render
    # assert_select "tr>td", :text => "Email@gmail.com".to_s, :count => 1
    assert_select "tr>td", :text => "Username".to_s, :count => 1
  end
end
