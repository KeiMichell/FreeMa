class CardsController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:index, :new, :delete, :show]

  def index
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.retrieve(customer.default_card)
      @card_brand = @card_info.brand
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 
    end
  end


  def new
    @card = Card.where(user_id: current_user.id).first
    redirect_to card_path(@card) if @card.present?
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      redirect_to new_card_url
    else
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjpToken'],
        metadata:{user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, card_id: customer.default_card, customer_id: customer.id)
      if @card.save
        redirect_to card_path(@card.id)
      else
        redirect_to new_card_path
      end
    end
  end

  def delete  
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to cards_path
    end
  end

  def buy
    @item = Item.find(params[:item_id])
    if @item.buyer.present? 
      redirect_back(fallback_location: root_path) 
    elsif @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy',
      )
      if @item.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: 'items', action: 'show', id: @item.id
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: 'items', action: 'show', id: @item.id
      end
    end
  end

  def show
    if @card.blank?
      redirect_to new_card_url 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private
  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
