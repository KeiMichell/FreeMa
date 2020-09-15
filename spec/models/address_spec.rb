require 'rails_helper'

describe Address do
  describe '#create' do
    # last_name、first_name、last_name_kana、first_name_kana、postcode、prefecture_id、city、blockが存在すれば登録できること
    it "is valid with a last_name, first_name, last_name_kana, first_name_kana, postcode, prefecture_id, city, block " do
      address = build(:address)
      expect(address).to be_valid
    end

    # last_nameが空では登録できないこと
    it "is invalid without a last_name" do
      address = build(:address, last_name: nil)
      address.valid?
      expect(address.errors[:last_name]).to include("を入力してください")
    end

    # first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    # last_name_kanaが空では登録できないこと
    it "is invalid without a last_name_kana" do
      address = build(:address, last_name_kana: nil)
      address.valid?
      expect(address.errors[:last_name_kana]).to include("を入力してください")
    end

    # first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("を入力してください")
    end

    # first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("を入力してください")
    end

    # postcodeが空では登録できないこと
    it "is invalid without a postcode" do
      address = build(:address, postcode: nil)
      address.valid?
      expect(address.errors[:postcode]).to include("を入力してください")
    end

    # prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    # cityが空では登録できないこと
    it "is invalid without a city" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    # blockが空では登録できないこと
    it "is invalid without a block" do
      address = build(:address, block: nil)
      address.valid?
      expect(address.errors[:block]).to include("を入力してください")
    end

    # last_nameが31文字以上であれば登録できないこと
    it "is invalid with a last_name that has more than 31 characters " do
      address = build(:address, last_name: "あああああああああああああああああああああああああああああああ") #31文字
      address.valid?
      expect(address.errors[:last_name]).to include("は30文字以内で入力してください")
    end

    # last_nameが30文字以下では登録できること
    it "is valid with a last_name that has less than  characters " do
      address = build(:address, last_name: "ああああああああああああああああああああああああああああああ") #30文字
      expect(address).to be_valid
    end

    # first_nameが31文字以上であれば登録できないこと
    it "is invalid with a first_name that has more than 31 characters " do
      address = build(:address, first_name: "あああああああああああああああああああああああああああああああ") #31文字
      address.valid?
      expect(address.errors[:first_name]).to include("は30文字以内で入力してください")
    end

    # first_nameが30文字以下では登録できること
    it "is valid with a first_name that has less than  characters " do
      address = build(:address, first_name: "ああああああああああああああああああああああああああああああ") #30文字
      expect(address).to be_valid
    end

    # last_name_kanaが31文字以上であれば登録できないこと
    it "is invalid with a last_name_kana that has more than 31 characters " do
      address = build(:address, last_name_kana: "あああああああああああああああああああああああああああああああ") #31文字
      address.valid?
      expect(address.errors[:last_name_kana]).to include("は30文字以内で入力してください")
    end

    # last_name_kanaが30文字以下では登録できること
    it "is valid with a last_name_kana that has less than  characters " do
      address = build(:address, last_name_kana: "ああああああああああああああああああああああああああああああ") #30文字
      expect(address).to be_valid
    end

    # first_name_kanaが31文字以上であれば登録できないこと
    it "is invalid with a first_name_kana that has more than 31 characters " do
      address = build(:address, first_name_kana: "あああああああああああああああああああああああああああああああ") #31文字
      address.valid?
      expect(address.errors[:first_name_kana]).to include("は30文字以内で入力してください")
    end

    # first_name_kanaが30文字以下では登録できること
    it "is valid with a first_name_kana that has less than  characters " do
      address = build(:address, first_name_kana: "ああああああああああああああああああああああああああああああ") #30文字
      expect(address).to be_valid
    end

    # postcodeが9文字以上であれば登録できないこと
    it "is invalid with a postcode that has more than 9 characters " do
      address = build(:address, postcode: "1111-1111") #9文字
      address.valid?
      expect(address.errors[:postcode]).to include("は8文字以内で入力してください")
    end

    # postcodeが8文字以下では登録できること
    it "is valid with a postcode that has less than 8 characters " do
      address = build(:address, postcode: "111-1111") #8文字
      expect(address).to be_valid
    end

    # last_nameが半角では登録できないこと
    it "is invalid with a last_name that has halfwidth" do
      address = build(:address, last_name: "111aaa")
      address.valid?
      expect(address.errors[:last_name]).to include("全角ひらがな、全角カタカナ、漢字で入力してください")
    end

    # last_nameが全角では登録できること
    it "is valid with a last_name that has fullwidth" do
      address = build(:address, last_name: "阿阿ああ")
      expect(address).to be_valid
    end

    # first_nameが半角では登録できないこと
    it "is invalid with a first_name that has halfwidth" do
      address = build(:address, first_name: "111aaa")
      address.valid?
      expect(address.errors[:first_name]).to include("全角ひらがな、全角カタカナ、漢字で入力してください")
    end

    # first_nameが全角では登録できること
    it "is valid with a first_name that has fullwidth" do
      address = build(:address, first_name: "阿阿ああ")
      expect(address).to be_valid
    end

    # last_name_kanaが全角平仮名以外では登録できないこと
    it "is invalid without a last_name_kana that has hiragana " do
      address = build(:address, last_name_kana: "阿阿ああ")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("全角ひらがなで入力してください")
    end

    # last_name_kanaが全角平仮名では登録できること
    it "is valid with a last_name_kana that has hiragana" do
      address = build(:address, last_name_kana: "ああああ")
      expect(address).to be_valid
    end

    # first_name_kanaが全角平仮名以外では登録できないこと
    it "is invalid without a first_name_kana that has hiragana " do
      address = build(:address, first_name_kana: "阿阿ああ")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("全角ひらがなで入力してください")
    end

    # first_name_kanaが全角平仮名では登録できること
    it "is valid with a first_name_kana that has hiragana" do
      address = build(:address, first_name_kana: "ああああ")
      expect(address).to be_valid
    end

    # postcodeが半角数字とハイフンを含めば登録できること
    it "is valid with a postcode that has integer and -" do
      address = build(:address, postcode: "222-2222")
      expect(address).to be_valid
    end

    # postcodeが半角数字またはハイフンでなければ登録できないこと
    it "is invalid without a postcode that has integer and -" do
      address = build(:address, postcode: "aaaaaaa")
      address.valid?
      expect(address.errors[:postcode]).to include("半角数字と半角ハイフンで入力してください")
    end

    # postcodeがハイフンを含まなければ登録できないこと
    it "is invalid without a postcode that has -" do
      address = build(:address, postcode: "111111")
      address.valid?
      expect(address.errors[:postcode]).to include("半角数字と半角ハイフンで入力してください")
    end
  end
end