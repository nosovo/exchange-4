class Platform < ActiveRecord::Base
  acts_as_application

  has_many :tasks, dependent: :destroy, inverse_of: :platform
end
