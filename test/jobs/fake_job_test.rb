require "test_helper"

class BuggyJob < ActiveJob::Base
  def perform
    puts "performed"
  end
end

class BuggyJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  def test_stuff
    perform_enqueued_jobs do
      previous_value = "og"
      Current.sample = previous_value
      BuggyJob.perform_later
      assert_equal previous_value, Current.sample
    end
  end
end
