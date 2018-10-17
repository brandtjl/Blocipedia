class Wiki < ApplicationRecord
  has_many :collaborators
  has_many :users, through: :collaborators

  belongs_to :user
  before_save {self.private ||= false }
  validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true

   delegate :users, to: :collaborators

  #  def collaborators
  #   Collaborator.where(wiki_id: id)
  #  end 

  #  def users
  #   collaborators.users
  #  end 

  end
