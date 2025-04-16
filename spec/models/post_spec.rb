require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "published scope" do
    let!(:organization) { create(:organization, name: "test1", subdomain: "test1", shard_name: "primary") }
    let(:user) { create(:user)}
    let(:unpublished_posts) { create_list(:post, 3, author: user, published_at: nil) }
    let(:published_posts) { create_list(:post, 3, author: user, published_at: Time.zone.now) }

    it "only returns posts where published_at is set" do
      Current.organization = organization
      expect(Post.published.count).to eq(Post.where.not(published_at: nil).count)
    end
  end
end
