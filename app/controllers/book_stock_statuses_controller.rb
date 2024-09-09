class BookStockStatusesController < ApplicationController
  include Pagy::Backend
  before_action :set_book_stock_status, only: %i[show edit update destroy]

  # GET /book_stock_statuses
  def index
    @book_stock_statuses = BookStockStatus
      .all
    @q = @book_stock_statuses.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @book_stock_statuses = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /book_stock_statuses/1
  def show
  end

  # GET /book_stock_statuses/new
  def new
    @book_stock_status = BookStockStatus.new
  end

  # GET /book_stock_statuses/1/edit
  def edit
  end

  # POST /book_stock_statuses
  def create
    @book_stock_status = BookStockStatus.new(book_stock_status_params)

    if @book_stock_status.save
      redirect_to @book_stock_status, notice: t("controller.create.success", model: BookStockStatus.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /book_stock_statuses/1
  def update
    if @book_stock_status.update(book_stock_status_params)
      redirect_to @book_stock_status, notice: t("controller.edit.success", model: BookStockStatus.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /book_stock_statuses/1
  def destroy
    @book_stock_status.destroy!
    redirect_to book_stock_statuses_url,
                notice: t("controller.destroy.success", model: BookStockStatus.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_book_stock_status
      @book_stock_status = BookStockStatus
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_stock_status_params
      params.require(:book_stock_status).permit(:name)
    end
end
