require 'spec_helper'

describe RelationshipsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in user, no_capybara: true }

  describe "creating a relatinship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, relationship: { followed_id: other_user.id }
      expect(response).to be_success
    end
  end

  describe "destroying a relationsip with Ajax" do

    before { user.follow!(other_user) }
    let(:relationship) { user.relationships.find_by(followed_id: other_user.id) }

    it "should decrement the Relationship count" do
      expect do
        xhr :post, :destroy, id: relationship.id
      end.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :post, :destroy, id: relationship.id
      expect(response).to be_success
    end
  end
end
