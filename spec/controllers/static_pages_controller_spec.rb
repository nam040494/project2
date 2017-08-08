require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "GET #show" do
    render_views
    context "when param is home" do
      before do
        get :show, params: {page: :home}
      end

      it{expect(response).to render_template :home}
      it{expect(response.body).to have_title "Home | Ruby on Rails Tutorial Sample App"}
    end

    context "when param is about" do
      before do
        get :show, params: {page: :about}
      end

      it{expect(response).to render_template :about}
    end

    context "when param is help" do
      before do
        get :show, params: {page: :help}
      end

      it{expect(response).to render_template :help}
    end

    context "when param is contact" do
      before do
        get :show, params: {page: :contact}
      end

      it{expect(response).to render_template :contact}
    end
  end
end
