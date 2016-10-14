class Article < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true, length: {maximum: 20, minimum: 3}
  validates :description, presence: true, length: {maximum: 250, minimum: 3}
end
