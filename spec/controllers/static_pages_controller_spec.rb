require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views

  before do
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  describe 'GET root' do
    it 'ステータスコード200が返る' do
      get :home
      expect(response).to have_http_status(200)
      assert_select 'title', "Home | #{@base_title}"
    end

    it 'タイトルが Home | Ruby on Rails Tutorial Sample App である' do
      get :home
      assert_select 'title', "Home | #{@base_title}"
    end
  end

  describe 'GET #help' do
    it 'ステータスコード200が返る' do
      get :help
      expect(response).to have_http_status(200)
    end

    it 'タイトルが Help | Ruby on Rails Tutorial Sample App である' do
      get :help
      assert_select 'title', "Help | #{@base_title}"
    end
  end

  describe 'GET #about' do
    it 'ステータスコード200が返る' do
      get :about
      expect(response).to have_http_status(200)
    end

    it 'タイトルが About | Ruby on Rails Tutorial Sample App である' do
      get :about
      assert_select 'title', "About | #{@base_title}"
    end
  end

  describe 'GET #contact' do
    it 'ステータスコード200が返る' do
      get :contact
      expect(response).to have_http_status(200)
    end

    it 'タイトルが Contact | Ruby on Rails Tutorial Sample App である' do
      get :contact
      assert_select 'title', "Contact | #{@base_title}"
    end
  end
end
