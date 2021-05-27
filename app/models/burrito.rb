# == Schema Information
#
# Table name: burritos
#
#  id            :integer          not null, primary key
#  image         :string
#  name          :string
#  price         :float
#  ratings_count :integer
#  tortilla      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  owner_id      :integer
#  restaurant_id :integer
#
class Burrito < ApplicationRecord
  belongs_to(:owner, { :required => false, :class_name => "User", :foreign_key => "owner_id", :counter_cache => true })
  has_many(:ratings, { :class_name => "Rating", :foreign_key => "burrito_id", :dependent => :destroy })
  belongs_to(:restaurant, { :required => false, :class_name => "Restaurant", :foreign_key => "restaurant_id", :counter_cache => true })
  has_many(:raters, { :through => :ratings, :source => :rater })
end
