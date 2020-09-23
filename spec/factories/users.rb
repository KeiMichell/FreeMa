FactoryBot.define do

  factory :user do
    nickname              { "abe" }
    email                 { "kkk@gmail.com" }
    password              { "00000000" }
    password_confirmation { "00000000" }
    last_name             { "阿部" }
    first_name            { "一郎" }
    last_name_kana        { "あべ" }
    first_name_kana       { "いちろう" }
    birthday              { "2000-01-01" }
    profile               { "" }
    image                 { "" }
  end

end