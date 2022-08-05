include ActionView::Helpers::UrlHelper
module GroupsHelper
  def access_types
    Group.accesses.map {|k, v| [k.titleize, v]}
  end

  def group_relation_status group, user
    return "<a rel='nofollow' data-method='post' href='#{edit_group_path(group)}'>Edit Group</a>".html_safe if group.creator?(user)
    membership = group.user_groups.find_by(user_id: user.id)
    if membership.present?
      membership_message = {"joined"=>'Already Joined', "pending"=>'Requested to Join', "removed" => "Removed"}
      (membership_message[membership.status]).to_s
    else
      "<a rel='nofollow' data-method='post' href='#{join_group_path(group)}'>Join Group</a>".html_safe
    end
  end
end
