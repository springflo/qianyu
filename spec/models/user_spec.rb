require 'rails_helper'

RSpec.describe User, type: :model do
    
#   pending "add some examples to (or delete) #{__FILE__}"

    describe "validations" do
        
        it "requires a username" do
            user = build(:user, username: nil)
            expect(user).not_to be_valid
        end
        
    end
    
end
