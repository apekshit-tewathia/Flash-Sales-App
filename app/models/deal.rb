class Deal < ApplicationRecord
  PUBLISHABLE_DEAL_IMAGE_QUANTITY = 2
  PUBLISHABLE_DEAL_QUANTITY = 10
  DEAL_WITH_SAME_PUBLISH_DATE_QUANTITY = 2
  DATE_DIFFERENCE = 1
  
  has_many_attached :images
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items, dependent: :destroy
  belongs_to :admin, class_name: "User", foreign_key: 'created_by'

  before_update :restrict_updation
  before_destroy :restrict_deletion
  after_destroy { |deal| deal.images.purge }
  after_commit :publishable?, unless: ->{ is_publishable }

  validates :title, :description, :price_in_cents, :discount_price_in_cents, :quantity, :tax_percentage, :published_at, presence: true 
  validates :title, uniqueness: true
  validates :price_in_cents, :discount_price_in_cents, :quantity, :tax_percentage, numericality: true

  scope :number_of_deals_with_publish_date, ->(date) { where(published_at: date).size }
  scope :live_deals, -> { where(status: 'live') }
  scope :new_live_deals, -> { Deal.where(published_at: Date.today) }

  enum status: { live: 'live', unpublished: 'unpublished', published: 'published' }

  def publishable?
    return true if images.size >= PUBLISHABLE_DEAL_IMAGE_QUANTITY && quantity > PUBLISHABLE_DEAL_QUANTITY && Deal.number_of_deals_with_publish_date(published_at) <= DEAL_WITH_SAME_PUBLISH_DATE_QUANTITY

  end

  def less_than_one_day_away_from_publish?
    (published_at - Date.today).to_i <= DATE_DIFFERENCE
  end

  def restrict_deletion
    throw :abort if self.less_than_one_day_away_from_publish?
  end

  def restrict_updation
    throw :abort if self.less_than_one_day_away_from_publish? && published_at_changed?
  end
end
