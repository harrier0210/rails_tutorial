require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  before do
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  describe "GET users/new" do
    it "ステータスコード200が返る" do
      get :new
      expect(response).to have_http_status(200)
    end

    it 'タイトルが Sign up | Ruby on Rails Tutorial Sample App である' do
      get :new
      assert_select 'title', "Sign up | #{@base_title}"
    end
  end

end
