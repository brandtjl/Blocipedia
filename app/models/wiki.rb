class Wiki < ApplicationRecord
  belongs_to :user
  before_save {self.private ||= false }
  validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true
end
