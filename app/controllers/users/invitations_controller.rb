class Users::InvitationsController < Devise::InvitationsController
  def create
      super
      @assign = Assign.new
      #Groupテーブルに招待したいユーザーのidを入れる。
      @assign.user_id = User.find_by(email: params[:user][:email]).id
      #paramsの構造として、ユーザーの中にfamily_idがあるので、このような形でかく。
      @assign.team_id = params[:user][:team_id]
      @assign.save
  end
end