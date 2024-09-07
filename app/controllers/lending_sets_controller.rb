class LendingSetsController < ApplicationController
  include Pagy::Backend
  before_action :set_lending_set, only: %i[show edit update destroy]

  # GET /lending_sets
  def index
    @lending_sets = LendingSet
      .eager_load(:customer)
      .eager_load(:lending_status)
    @q = @lending_sets.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @lending_sets = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /lending_sets/1
  def show
  end

  # GET /lending_sets/new
  def new
    @lending_set = LendingSet.new
  end

  # GET /lending_sets/1/edit
  def edit
  end

  # POST /lending_sets
  def create
    @lending_set = LendingSet.new(lending_set_params)

    if @lending_set.save
      redirect_to @lending_set, notice: t("controller.create.success", model: LendingSet.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lending_sets/1
  def update
    if @lending_set.update(lending_set_params)
      redirect_to @lending_set, notice: t("controller.edit.success", model: LendingSet.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /lending_sets/1
  def destroy
    @lending_set.destroy!
    redirect_to lending_sets_url, notice: t("controller.destroy.success", model: LendingSet.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_lending_set
      @lending_set = LendingSet
        .eager_load(:customer)
        .eager_load(:lending_status)
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lending_set_params
      params.require(:lending_set).permit(:customer_id, :lending_status_id, :lend_start_date, :return_deadline_date, :return_date, :memo)
    end
end
