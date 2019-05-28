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
    @user = FactoryBot.build(:user)
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
      @user.email = 'a' * 244 + "@example.com"
      expect(@user).to_not be_valid
    end

    it 'emailが255文字の時有効である' do
      @user.email = 'a' * 243 + "@example.com"
      expect(@user).to be_valid
    end

    it '重複したメールアドレスは無効である' do
      FactoryBot.create(:user, email: "aaron@example.com")
      user = FactoryBot.build(:user, email: "Aaron@example.com")
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'emailが有効である' do
      valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
      valid_addresses.each do |v|
        @user.email = v
        expect(@user).to be_valid
      end
    end

    it 'emailが無効である' do
      valid_addresses = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
      valid_addresses.each do |v|
        @user.email = v
        expect(@user).to_not be_valid
      end
    end

    it 'emailをDBに登録したとき小文字であること' do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
end
