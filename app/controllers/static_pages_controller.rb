class StaticPagesController < ApplicationController
  def show
    if valid_page?
      if params[:page_type] == "home" && logged_in?
        @micropost = current_user.microposts.build
        @feed_items = Micropost.feed(current_user.id)
          .paginate page: params[:page],
          per_page: Settings.users.index.per_page
          @comment= Comment.new
      end

      render "#{params[:page_type]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page?
    File.exist? Pathname.new Rails.root +
      "app/views/static_pages/#{params[:page_type]}.html.erb"
  end
end
