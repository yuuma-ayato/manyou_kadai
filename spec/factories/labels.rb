FactoryBot.define do
  factory :label do
    name { "Factoryで作ったラベル１" }
  end
  factory :second_label, class: Label do
    name { "Factoryでラベル２" }
  end
  factory :third_label, class: Label do
    name { "Factoryで作ったラベル３" }
  end
end
