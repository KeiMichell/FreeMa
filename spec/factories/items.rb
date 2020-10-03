FactoryBot.define do
  factory :item do
    name              { "tomato"}
    detail            {"aaa"}
    price             {300}
    category_id       {1}
    condition_id      {1}
    delivery_fee_id   {1}
    prefecture_id     {1}
    delivery_day_id   {1}
    association :seller, factory: :user
    after(:build) do |item|
      item.images << build(:image)
      parent = create(:category, name: "親", parent_id: nil)
      child = create(:category, name: "子", parent_id: parent.id)
      grand_child = create(:category, name: "孫", parent_id: child.id)
      item.category_id = grand_child.id
    end
  end
end
