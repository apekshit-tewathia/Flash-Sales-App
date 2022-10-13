namespace :deal do
  desc 'Publishing new deals scheduled to be published on current day and unpublishing old deals which were live'
  task :publish_and_unpublish => [:environment] do
    old_live_deals = Deal.live_deals
    old_live_deals.update(status: 'published') if old_live_deals.present?
    new_live_deals = Deal.new_live_deals
    new_live_deals.update(status: 'live') if new_live_deals.present? && new_live_deals.count <=2
    if new_live_deals.present? && new_live_deals.count <=2
      new_live_deals.each do |deal|
        if deal.publishable?
          puts "#{deal} published successfully" if deal.update(status: 'live').present?
        else
          puts "Unable to publish #{deal}"
        end
      end
    else
      puts "Deal cannot be published"
    end
  end
end
