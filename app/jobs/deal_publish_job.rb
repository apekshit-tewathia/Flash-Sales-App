class DealPublishJob < ApplicationJob
  queue_as :default

  def perform
    rake deal:publish_and_unpublish
  end
end
