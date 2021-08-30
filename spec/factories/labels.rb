FactoryBot.define do
  factory :label do
    name { "Ruby" }
  end

  factory :label2, class: Label do
    name { 'Ruby on Rails4' }
  end

end
