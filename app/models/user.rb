class User < ApplicationRecord
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  enum role: [:user, :admin]
  enum account: {free: 0, premium: 1 }
  after_initialize :set_default_role, :if => :new_record?
  before_save {self.account||= :free }

  delegate :wikis, to: :collaborators

  def set_default_role
    self.role ||= :user
  end 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
         
  # deleted this has_many line since the has_many-through code is above
  # has_many :wikis, dependent: :destroy

  # def collaborators
  #   Collaborator.where(user_id: id)
  # end 

  # def wikis
  #   collaborators.wikis
  # end 

end
