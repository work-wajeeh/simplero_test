class UserGroup < ApplicationRecord
    belongs_to :user
    belongs_to :group
    validates :user_id, :uniqueness => { :scope => :group_id }

    enum status: {"joined"=>'Joined', "pending"=>'Pending', "removed" => "Removed"}
end
