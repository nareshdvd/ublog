require 'rails_helper'

RSpec.describe Extensions::CreateOrganizationShardExtension do
  let(:organization) { create(:organization, subdomain: 'acme') }
  subject { Extensions::CreateOrganizationShardExtension.new(organization) }

  context "#execute" do
    it "calls Extensions::CreateOrganizationShardExtension" do
      expect { subject.execute }.to enqueue_sidekiq_job(AddShardJob)
    end
  end
end
