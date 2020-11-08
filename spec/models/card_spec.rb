require 'rails_helper'

describe Card do
  describe '#create' do
    # user_id,customer_idが存在していたらcardを登録できる
    it 'is valid with a customer_id and card_id' do
      user = create(:user)
      card = build(:card, user_id: user.id)
      card.valid?
      expect(card).to be_valid
    end
    # customer_idがない場合cardを登録できない
    it 'is valid without customer_id' do
      user = create(:user)
      card = build(:card, user_id: user.id, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
    # card_idがない場合cardを登録できない
    it 'is invalid without card_id' do
      user = create(:user)
      card = build(:card, user_id: user.id, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
  end
end
