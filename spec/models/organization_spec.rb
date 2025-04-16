require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "#create" do
    let!(:existing_organization) { create(:organization, name: "test1", subdomain: "test1", shard_name: "test1") }
    let(:name) { 'test_acme123' }
    let(:subdomain) { name }
    let(:shard_name) { name }

    shared_examples_for "raises validation error" do
      it "raises validation error" do
        expect { Organization.create!(name: name, subdomain: subdomain, shard_name: shard_name) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "Organization exists with same name" do
      let(:name) { 'test1' }
      it_behaves_like 'raises validation error'
    end

    context "Organization exists with same subdomain" do
      let(:subdomain) { 'test1' }
      it_behaves_like 'raises validation error'
    end

    context "Organization exists with same shard_name" do
      let(:shard_name) { 'test1' }
      it_behaves_like 'raises validation error'
    end
  end
end
