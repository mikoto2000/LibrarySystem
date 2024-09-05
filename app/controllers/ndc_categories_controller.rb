class NdcCategoriesController < ApplicationController
  include Pagy::Backend
  before_action :set_ndc_category, only: %i[show edit update destroy]

  # GET /ndc_categories
  def index
    @ndc_categories = NdcCategory
      .all
    @q = @ndc_categories.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @ndc_categories = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /ndc_categories/1
  def show
  end

  # GET /ndc_categories/new
  def new
    @ndc_category = NdcCategory.new
  end

  # GET /ndc_categories/1/edit
  def edit
  end

  # POST /ndc_categories
  def create
    @ndc_category = NdcCategory.new(ndc_category_params)

    if @ndc_category.save
      redirect_to @ndc_category, notice: t("controller.create.success", model: NdcCategory.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ndc_categories/1
  def update
    if @ndc_category.update(ndc_category_params)
      redirect_to @ndc_category, notice: t("controller.edit.success", model: NdcCategory.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /ndc_categories/1
  def destroy
    @ndc_category.destroy!
    redirect_to ndc_categories_url, notice: t("controller.destroy.success", model: NdcCategory.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_ndc_category
      @ndc_category = NdcCategory
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ndc_category_params
      params.require(:ndc_category).permit(:name, :number)
    end
end
