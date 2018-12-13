class Post < ActiveRecord::Base
    belongs_to :user
    validates :title, length:{maximum:40}, presence: true
    validates :body, length:{maximum:10000}, presence: true
end
