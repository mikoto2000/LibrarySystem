class LendingStatusesController < ApplicationController
  include Pagy::Backend
  before_action :set_lending_status, only: %i[show edit update destroy]

  # GET /lending_statuses
  def index
    @lending_statuses = LendingStatus
      .all
    @q = @lending_statuses.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @lending_statuses = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /lending_statuses/1
  def show
  end

  # GET /lending_statuses/new
  def new
    @lending_status = LendingStatus.new
  end

  # GET /lending_statuses/1/edit
  def edit
  end

  # POST /lending_statuses
  def create
    @lending_status = LendingStatus.new(lending_status_params)

    if @lending_status.save
      redirect_to @lending_status, notice: t("controller.create.success", model: LendingStatus.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lending_statuses/1
  def update
    if @lending_status.update(lending_status_params)
      redirect_to @lending_status, notice: t("controller.edit.success", model: LendingStatus.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /lending_statuses/1
  def destroy
    @lending_status.destroy!
    redirect_to lending_statuses_url, notice: t("controller.destroy.success", model: LendingStatus.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_lending_status
      @lending_status = LendingStatus
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lending_status_params
      params.require(:lending_status).permit(:name)
    end
end
