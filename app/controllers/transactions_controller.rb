class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transactions, only: %i[show edit update destroy]
  def index
    @transactions = Transaction.all
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction= Transaction.new(transaction_params)
    @transaction.user_id = current_user.id
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    respond_to do |format|
      if @transaction.update_attributes(transaction_params)
        format.html { redirect_to transactions_path, notice: "updated successfully" }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, notice: "Something went wrong"}
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_transactions
    @transaction = Transaction.find_by_id(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:user_id, :trans_type, :trans_amount)
  end
end
