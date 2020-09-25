class DeliveryDay < ActiveHash::Base
  self.data = [
      { id: 1, name: '１〜2日で配送' }, { id: 2, name: '2〜3日で配送' }, { id: 3, name: '4〜7 日で配送' }
  ]
end