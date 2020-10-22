require 'rails_helper'

describe SnsCredential do
  describe '#create' do
    # provider, uidが存在すればSNS認証が行われる
    it "is valid with a provider and uid " do
      sns_credential = build(:sns_credential)
      expect(sns_credential).to be_valid
    end

    # providerが空ではSNS認証ができないこと
    it "is invalid without a provider" do
      sns_credential = build(:sns_credential, provider: nil)
      sns_credential.valid?
      expect(sns_credential.errors[:provider])
    end

    # uidが空ではSNS認証できないこと
    it "is invalid without a uid" do
      sns_credential = build(:sns_credential, uid: nil)
      sns_credential.valid?
      expect(sns_credential.errors[:uid])
    end
  end
end
