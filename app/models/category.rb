class Category < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :posts

  def to_s
    name
  end
end
