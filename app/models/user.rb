class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :group_properties, :class_name => "Group", :foreign_key => "creator_id"

  def group_creatore? group
    group.creator == self
  end

  def in_group? group
    group.users.pluck(:id).compact.include?(self.id)
  end

end
