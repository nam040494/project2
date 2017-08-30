class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by id: params[:id]

    return if user
    flash[:danger] = t ".not_found"
    redirect_to root_url

    current_user.follow user
    redirect_to user
  end

  def destroy
    user = Relationship.find_by params[:id].followed

    return if user
    flash[:danger] = t ".not_found"
    redirect_to root_url

    current_user.unfollow user
    redirect_to user
  end
end
