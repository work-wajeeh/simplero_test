class Group < ApplicationRecord
  enum access: {"public_group"=>'Public Group', "private_group"=>'Private Group'}
  validates :access, :presence => true
  has_many :user_groups
  has_many :users, through: :user_groups
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"

  scope :public_groups, -> { where(:access => 'public_group')}

end
