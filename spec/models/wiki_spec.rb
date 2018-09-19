
require 'rails_helper'
require 'spec_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email: 'test@email.com', password: 'password') }
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", user: user) }

  # describe "attributes" do
  #   it "has title, body, and user attributes" do
  #     expect(wiki).to have_attributes(title: "New Wiki Title", body: "New Wiki Body", user: user)
  #   end 
  # end 

end
