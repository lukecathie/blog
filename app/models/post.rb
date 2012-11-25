class Post < ActiveRecord::Base
  attr_accessible :title, :body, :category_names
  attr_accessor :category_names
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

  def category_names
    categories.map{|cat| cat.name}.join(',')
  end
end

