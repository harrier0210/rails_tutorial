# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "test user", email: 'test@example.com')
  end

  describe User do
    it 'ユーザーが有効である' do
      expect(@user).to be_valid
    end

    it 'nameが空の時無効である' do
      @user.name = ''
      expect(@user).to_not be_valid
    end

    it 'emailが空の時無効である' do
      @user.email = ''
      expect(@user).to_not be_valid
    end

    it 'nameが51文字以上の時無効である' do
      @user.name = 'a' * 51
      expect(@user).to_not be_valid
    end

    it 'nameが50文字の時有効である' do
      @user.name = 'a' * 50
      expect(@user).to be_valid
    end

    it 'emailが256文字以上の時無効である' do
      @user.email = 'a' * 256
      expect(@user).to_not be_valid
    end

    it 'emailが255文字の時有効である' do
      @user.email = 'a' * 255
      expect(@user).to be_valid
    end
  end
end
