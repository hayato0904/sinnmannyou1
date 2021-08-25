class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  # before_destroy :final_admin_destroy
  # before_destroy :final_admin_update
  after_destroy :admin_necessary
  after_update :admin_necessary
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks
  
#   def final_admin_destroy
#     if User.where(admin: 'true').count <= 1 && self.admin == true
#       throw :abort
#     end
#   end

#   def final_admin_update
#     if User.where(admin: 'true').count == 1 && self.admin == false
#       throw :abort
#   end
# end

def admin_necessary
  if User.where(admin: 'true').count == 0
    raise ActiveRecord::Rollback
  end
end

end