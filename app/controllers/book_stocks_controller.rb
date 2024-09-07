class BookStocksController < ApplicationController
  include Pagy::Backend
  before_action :set_book_stock, only: %i[show edit update destroy]

  # GET /book_stocks
  def index
    @book_stocks = BookStock
      .eager_load(:book_master)
      .eager_load(:book_stock_status)
    @q = @book_stocks.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @book_stocks = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /book_stocks/1
  def show
  end

  # GET /book_stocks/new
  def new
    @book_stock = BookStock.new
  end

  # GET /book_stocks/1/edit
  def edit
  end

  # POST /book_stocks
  def create
    @book_stock = BookStock.new(book_stock_params)

    if @book_stock.save
      redirect_to @book_stock, notice: t("controller.create.success", model: BookStock.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /book_stocks/1
  def update
    if @book_stock.update(book_stock_params)
      redirect_to @book_stock, notice: t("controller.edit.success", model: BookStock.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /book_stocks/1
  def destroy
    @book_stock.destroy!
    redirect_to book_stocks_url, notice: t("controller.destroy.success", model: BookStock.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_book_stock
      @book_stock = BookStock
        .eager_load(:book_master)
        .eager_load(:book_stock_status)
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_stock_params
      params.require(:book_stock).permit(:book_master_id, :book_stock_status_id, :memo)
    end
end
