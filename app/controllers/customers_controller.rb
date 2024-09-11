class CustomersController < ApplicationController
  include Pagy::Backend
  before_action :set_customer, only: %i[show edit update destroy]

  # GET /customers
  def index
    @customers = Customer
      .all
    @q = @customers.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @customers = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /customers/1
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: t("controller.create.success", model: Customer.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: t("controller.edit.success", model: Customer.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy!
    redirect_to customers_url, notice: t("controller.destroy.success", model: Customer.model_name.human)
  end

  # POST /customer_bulk_insert
  def bulk_insert
    if params[:file].nil?
      redirect_to customers_url
      return
    end

    errors = Customer.csv_import(
      params[:file],
      parser,
      {
        "名前" => "name",
        "メールアドレス" => "email_address"
      },
      {},
      {})

    if errors.empty?
      flash.notice = t("controller.create.success", model: Customer.model_name.human)
    else
      flash.alert = errors
    end

    redirect_to customers_url
  end
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:name, :email_address)
    end

    def parser
      Csv::CsvParser
    end
end
