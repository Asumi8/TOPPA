class Users::InvitationsController < Devise::InvitationsController
  before_action :prohibit_access_by_other_teams, only: %i[new]

  def create
    @user = User.new
    if User.find_by(email: params[:user][:email].downcase).present?
      exist_email = params[:user][:email]
      team_id = params[:user][:team_id]
      user_id = User.where(email: exist_email).pluck(:id)
      user = User.find(user_id[0])
      if user.valid?
        user.invite!(current_user)
        user.invited_by_team_id = team_id
        user.save
        redirect_to teams_path(current_user), notice: "招待メールが#{exist_email}に送信されました。"
      # else
      #   flash[:notice] = 'メールアドレスを正しく入力してください。'
      #   render :new
      end
    else
      new_email = params[:user][:email]
      @team_id = params[:user][:team_id]
      if User.invite!(email: new_email, invited_by_team_id: @team_id).valid?
        session['team_id'] = nil if session['team_id']
        redirect_to teams_path(current_user), notice: "招待メールが#{new_email}に送信されました。"
      else
        flash[:notice] = 'メールアドレスを正しく入力してください。'
        render 'new', locals: { team: @team_id }
      end
    end
  end

  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource

    user_id = self.resource.id
    user = User.find(user_id)
    user_assigned_teams = Assign.where(user_id: user_id).pluck(:team_id)
    new_team_assign = []
    new_team_assign << user_assigned_teams
    new_team_assign << user.invited_by_team_id
    new_team_assign = new_team_assign.flatten
    user.update(team_member_ids: new_team_assign)

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

  private

  def prohibit_access_by_other_teams
    unless current_user.assigns.pluck(:team_id).any?(params[:team].to_i)
      flash[:notice] = "アクセス権限がありません。"
      redirect_to teams_path
    end
  end
end