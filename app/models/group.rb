class Group < ApplicationRecord
  enum access: {"open_group"=>'Open Group', "private_group"=>'Private Group'}
  validates :access, :presence => true
  has_many :user_groups
  has_many :users, through: :user_groups
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"


  def creator? user
    self.creator == user
  end

  def add_user user
    self.users << user
    self.user_groups.find_by(user_id: user.id)&.joined!
  end

end
