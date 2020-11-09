class CardsController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:index, :new, :delete, :show]

  def index; end

  def new
    @card = Card.where(user_id: current_user.id).first
    redirect_to card_path(@card) if @card.present?
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if params['payjpToken'].blank?
      redirect_to new_card_url
    else
      customer = Payjp::Customer.create(card: params['payjpToken'])
      @card = Card.new(user_id: current_user.id, card_id: customer.default_card, customer_id: customer.id)
      if @card.save
        redirect_to card_path(@card.id)
      else
        redirect_to new_card_path
      end
    end
  end

  def delete
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to action: :new, notice: "削除しました"
    else
      redirect_to action: :index, alert: "削除できませんでした"
    end
  end

  def show
    if @card.blank?
      redirect_to new_card_url
    else
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
