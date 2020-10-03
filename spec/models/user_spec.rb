require 'rails_helper'

describe User do
  describe '#create' do
    # nickname、email、encrypted_password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できること
    it "is valid with a nickname, email, encrypted_password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birthday" do
      user = build(:user)
      expect(user).to be_valid
    end

    # nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    # emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # encrypted_passwordが空では登録できないこと
    it "is invalid without a encrypted_password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # encrypted_passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # last_nameが空では登録できないこと
    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    # first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    # last_name_kanaが空では登録できないこと
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end

    # first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    # birthdayが空では登録できないこと
    it "is invalid without a birthday" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    # 重複したnicknameが存在する場合登録できないこと
    it "is invalid with a duplicate nickname" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("はすでに存在します")
    end

    # 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # nicknameが21文字以上であれば登録できないこと
    it "is invalid with a nickname that has more than 21 characters " do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaaa") #21文字
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end

    # nicknameが20文字以下では登録できること
    it "is valid with a nickname that has less than 20 characters " do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaa") #20文字
      expect(user).to be_valid
    end

    # encrypted_passwordが7文字以上であれば登録できること
    it "is valid with a encrypted_password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      expect(user).to be_valid
    end

    # encrypted_passwordが6文字以下であれば登録できないこと
    it "is invalid with a encrypted_password that has less than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    # last_nameが31文字以上であれば登録できないこと
    it "is invalid with a last_name that has more than 31 characters " do
      user = build(:user, last_name: "あああああああああああああああああああああああああああああああ") #31文字
      user.valid?
      expect(user.errors[:last_name]).to include("は30文字以内で入力してください")
    end

    # last_nameが30文字以下では登録できること
    it "is valid with a last_name that has less than  characters " do
      user = build(:user, last_name: "ああああああああああああああああああああああああああああああ") #30文字
      expect(user).to be_valid
    end

    # first_nameが31文字以上であれば登録できないこと
    it "is invalid with a first_name that has more than 31 characters " do
      user = build(:user, first_name: "あああああああああああああああああああああああああああああああ") #31文字
      user.valid?
      expect(user.errors[:first_name]).to include("は30文字以内で入力してください")
    end

    # first_nameが30文字以下では登録できること
    it "is valid with a first_name that has less than  characters " do
      user = build(:user, first_name: "ああああああああああああああああああああああああああああああ") #30文字
      expect(user).to be_valid
    end

    # last_name_kanaが31文字以上であれば登録できないこと
    it "is invalid with a last_name_kana that has more than 31 characters " do
      user = build(:user, last_name_kana: "あああああああああああああああああああああああああああああああ") #31文字
      user.valid?
      expect(user.errors[:last_name_kana]).to include("は30文字以内で入力してください")
    end

    # last_name_kanaが30文字以下では登録できること
    it "is valid with a last_name_kana that has less than  characters " do
      user = build(:user, last_name_kana: "ああああああああああああああああああああああああああああああ") #30文字
      expect(user).to be_valid
    end

    # first_name_kanaが31文字以上であれば登録できないこと
    it "is invalid with a first_name_kana that has more than 31 characters " do
      user = build(:user, first_name_kana: "あああああああああああああああああああああああああああああああ") #31文字
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は30文字以内で入力してください")
    end

    # first_name_kanaが30文字以下では登録できること
    it "is valid with a first_name_kana that has less than  characters " do
      user = build(:user, first_name_kana: "ああああああああああああああああああああああああああああああ") #30文字
      expect(user).to be_valid
    end

    # emailが@を含まなければ登録できないこと
    it "is invalid without a email that has @" do
      user = build(:user, email: "aaaaaaaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    # emailがドメインを含まなければ登録できないこと
    it "is invalid without a email that has domain" do
      user = build(:user, email: "@aaa.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    # emailが@とドメイン含んでいれば登録できること
    it "is valid with a email that has @ and domain" do
      user = build(:user, email: "aaa@aaa.com")
      expect(user).to be_valid
    end

    # last_nameが半角では登録できないこと
    it "is invalid with a last_name that has halfwidth" do
      user = build(:user, last_name: "111aaa")
      user.valid?
      expect(user.errors[:last_name]).to include("全角ひらがな、全角カタカナ、漢字で入力してください")
    end

    # last_nameが全角では登録できること
    it "is valid with a last_name that has fullwidth" do
      user = build(:user, last_name: "阿阿ああ")
      expect(user).to be_valid
    end

    # first_nameが半角では登録できないこと
    it "is invalid with a first_name that has halfwidth" do
      user = build(:user, first_name: "111aaa")
      user.valid?
      expect(user.errors[:first_name]).to include("全角ひらがな、全角カタカナ、漢字で入力してください")
    end

    # first_nameが全角では登録できること
    it "is valid with a first_name that has fullwidth" do
      user = build(:user, first_name: "阿阿ああ")
      expect(user).to be_valid
    end

    # last_name_kanaが全角平仮名以外では登録できないこと
    it "is invalid without a last_name_kana that has hiragana " do
      user = build(:user, last_name_kana: "阿阿ああ")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("全角ひらがなで入力してください")
    end

    # last_name_kanaが全角平仮名では登録できること
    it "is valid with a last_name_kana that has hiragana" do
      user = build(:user, last_name_kana: "ああああ")
      expect(user).to be_valid
    end

    # first_name_kanaが全角平仮名以外では登録できないこと
    it "is invalid without a first_name_kana that has hiragana " do
      user = build(:user, first_name_kana: "阿阿ああ")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("全角ひらがなで入力してください")
    end

    # first_name_kanaが全角平仮名では登録できること
    it "is valid with a first_name_kana that has hiragana" do
      user = build(:user, first_name_kana: "ああああ")
      expect(user).to be_valid
    end

  end
end