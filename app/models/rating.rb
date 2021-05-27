# == Schema Information
#
# Table name: ratings
#
#  id           :integer          not null, primary key
#  rating_value :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  burrito_id   :integer
#  rater_id     :integer
#
class Rating < ApplicationRecord
  belongs_to(:rater, { :required => false, :class_name => "User", :foreign_key => "rater_id", :counter_cache => true })
  belongs_to(:burrito, { :required => false, :class_name => "Burrito", :foreign_key => "burrito_id", :counter_cache => true })
  has_one(:restaurant, { :through => :burrito, :source => :restaurant })
end
