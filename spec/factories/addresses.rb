FactoryBot.define do

  factory :address do
    last_name             {"阿部"}
    first_name            {"一郎"}
    last_name_kana        {"あべ"}
    first_name_kana       {"いちろう"}
    postcode              {"111-1111"}
    prefecture_id         {"1"}
    city                  {"あああ市"}
    block                 {"１丁目１番地"}
    building              {""}
    phone_number          {""}
  end

end