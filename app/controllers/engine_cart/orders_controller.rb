require_dependency "engine_cart/application_controller"

module EngineCart
  class OrdersController < ApplicationController
    include Rectify::ControllerHelpers
    helper OrdersHelper

    before_action :authenticate_user!, only: [:index, :show]

    def index
      @all_sort_params = OrdersHelper::SORTING
      @params = sort_params
      @orders = SorteredOrders.new(current_user.orders, params)
    end

    def show
      @order = Order.find_by_id(params[:id]).decorate
      present FullOrderPresenter.new(object: @order)
    end

    private

    def sort_params
      params.permit(:sort)
    end
  end
end
