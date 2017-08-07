require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    before do
      allow(helper).to receive(:t).with(".base_title") {"Ruby on Rails Tutorial Sample App"}
    end

    context "should base title" do
      subject {helper.full_title}
      it {is_expected.to eq "Ruby on Rails Tutorial Sample App"}
    end

    context "should full title" do
      subject {helper.full_title "Home"}
      it {is_expected.to eq "Home | Ruby on Rails Tutorial Sample App"}
    end
  end
end
