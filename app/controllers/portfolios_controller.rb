# frozen_string_literal: true

class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: %i[show edit update destroy]
  layout 'portfolio'

  def index
    @portfolio_items = Portfolio.all
  end

  def angular
    @angular_portfolio_items = Portfolio.angular
  end

  def show; end

  def new
    @portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_item_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html do
          redirect_to portfolios_url,
                      notice: 'Your portflio is now live'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @portfolio_item.update(portfolio_item_params)
        format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @portfolio_item.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was removed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_portfolio_item
    @portfolio_item = Portfolio.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list 
  # through.
  def portfolio_item_params
    params.require(:portfolio).permit(:title,
                                      :body,
                                      :subtitle,
                                      technologies_attributes: [:name])
  end
end
