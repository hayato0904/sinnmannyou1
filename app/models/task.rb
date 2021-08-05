class Task < ApplicationRecord
        validates :title, presence: true
        validates :content, presence: true
        enum status: {未着手:1, 着手中:2, 完了:3}
end
