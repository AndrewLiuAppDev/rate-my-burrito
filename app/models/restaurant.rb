# == Schema Information
#
# Table name: restaurants
#
#  id             :integer          not null, primary key
#  burritos_count :integer
#  image          :string
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Restaurant < ApplicationRecord
  belongs_to(:owner, { :required => false, :class_name => "User", :foreign_key => "owner_id", :counter_cache => true })
  has_many(:burritos, { :class_name => "Burrito", :foreign_key => "restaurant_id", :dependent => :destroy })
  has_many(:ratings, { :through => :burritos, :source => :ratings })
end
