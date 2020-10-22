FactoryBot.define do
  factory :sns_credential do
    provider { "facebook, google_oauth2" }
    uid      { "1111111" }
  end
end