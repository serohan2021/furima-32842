class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new(order_params)
    binding.pry
    if @order_destination.valid?
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:post_code, :region_id, :city, :address, :building_name, :phone_number,
                                              ).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
