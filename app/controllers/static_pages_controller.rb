class StaticPagesController < ApplicationController

  def show
    if valid_page?
      render template: "static_pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def home
    return unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate page: params[:page],
      per_page: Settings.users.home.per_page
  end
  private

  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/static_pages/#{params[:page]}.html.erb"))
  end
end
