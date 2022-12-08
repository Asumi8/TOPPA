class Users::InvitationsController < Devise::InvitationsController
  def create
    if params[:user][:email].empty?
      redirect_to new_user_invitation_path, alert: 'メールアドレスが空白です。入力してください'
    elsif params[:user][:email] !~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i || (params[:user][:email]).size > 255
      redirect_to new_user_invitation_path, alert: 'メールアドレスを正しく入力してください'
    elsif User.find_by(email: params[:user][:email].downcase).present?
      exist_email = params[:user][:email]
      team_id = params[:user][:team_id]
      user_id = User.where(email: exist_email).pluck(:id)
      user_assigned_teams = Assign.where(id: user_id).pluck(:team_id)
      new_team_assign = []
      new_team_assign << user_assigned_teams
      new_team_assign << team_id.to_i
      new_team_assign = new_team_assign.flatten
      user = User.find(user_id[0])
      user.invite!(current_user)
      user.update(team_member_ids: new_team_assign)
      redirect_to teams_path(current_user), notice: "招待メールが#{exist_email}に送信されました。"
    else
      new_email = params[:user][:email]
      team_id = params[:user][:team_id]
      User.invite!(email: new_email, team_member_ids: team_id)
      redirect_to teams_path(current_user), notice: "招待メールが#{new_email}に送信されました。"
    end
    #super
  end

  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        sign_in(resource_name, resource)
        respond_with resource, location: teams_path
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource) { render :edit, status: :unprocessable_entity }
    end
  end
end