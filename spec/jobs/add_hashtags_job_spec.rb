require 'rails_helper'

RSpec.describe AddHashtagsJob, type: :job do
  describe "#perform_later" do
    it "check if job was enqueued" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        AddHashtagsJob.perform_later('tweet_body')
      }.to have_enqueued_job
    end

    it 'is in trendings queue' do
      expect(AddHashtagsJob.new.queue_name).to eq('trendings')
    end
  end
end
