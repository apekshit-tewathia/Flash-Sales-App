class Admin::DealsController < Admin::BaseController
  before_action :requested_deal, only: [:show, :edit, :destroy, :update]
  
  def index
    @deals = Deal.where(status: params[:status])
    @status = params[:status]
  end

  def new
    @deal = Deal.new
  end

  def create
    deal = Deal.new(deal_permitted_params)
    deal.admin = logged_in_user

    if deal.save
      redirect_to admin_deals_url(status: 'unpublished')
    else
      redirect_to new_admin_deal_url, notice: t(:default_error_message)
    end
  end

  def show
    render template: 'admin/deals/show'
  end

  def edit
  end

  def update
    if @deal.update(deal_permitted_params)
      redirect_to admin_deal_url(@deal), notice: t(:successfull, resource_name: 'updated deal')
    else
      redirect_to admin_deals_url(status: 'unpublished'), notice: t(:default_error_message)
    end
  end

  def destroy
    if @deal.destroy
      redirect_to admin_deals_url(status: 'unpublished'), notice: t(:successfull, resource_name: 'destroyed deal')
    else
      redirect_to admin_deal_url(@deal), notice: t(:default_error_message)
    end
  end

  private
    def deal_permitted_params
      params.require(:deal).permit(:title, :description, :price_in_cents, :discount_price_in_cents, :quantity, :tax_percentage, :published_at, images: [])
    end

    def requested_deal
      @deal = Deal.find(params[:id])
    end
end
