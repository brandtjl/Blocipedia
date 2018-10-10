class User < ApplicationRecord
  enum role: [:user, :admin]
  enum account: {free: 0, premium: 1 }
  after_initialize :set_default_role, :if => :new_record?
  before_save {self.account||= :free }

  def set_default_role
    self.role ||= :user
  end 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :wikis, dependent: :destroy
end
