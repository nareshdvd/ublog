require 'rails_helper'

RSpec.describe AddShardJob, type: :job do
  describe '#perform' do
    let(:shard_name) { 'test_acme1' }
    let!(:organization) { create(:organization, subdomain: shard_name, shard_name: shard_name) }
    subject { AddShardJob }


    it "adds new database for given shard_name" do
      Sidekiq::Testing.inline! do
        expect { subject.perform_async(organization.id) }.to change {
          DynamicShards.db_exists?(shard_name)
        }.from(false).to(true)
      end
    end

    after(:each) do
      ActiveRecord::Base.connection.execute("DROP DATABASE #{shard_name}")
    end
  end
end
