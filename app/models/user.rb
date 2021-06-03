# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  avatar            :string
#  burritos_count    :integer
#  email             :string
#  name              :string
#  password_digest   :string
#  ratings_count     :integer
#  restaurants_count :integer
#  user_type         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:burritos, { :class_name => "Burrito", :foreign_key => "owner_id", :dependent => :nullify })
  has_many(:ratings, { :class_name => "Rating", :foreign_key => "rater_id", :dependent => :nullify })
  has_many(:restaurants, { :class_name => "Restaurant", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:rated_burritos, { :through => :ratings, :source => :burrito })

  def recommendation
  end
end
