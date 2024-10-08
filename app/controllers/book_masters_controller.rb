class BookMastersController < ApplicationController
  include Pagy::Backend
  before_action :set_book_master, only: %i[show edit update destroy]

  # GET /book_masters
  def index
    @book_masters = BookMaster
      .eager_load(:ndc_category)
    @q = @book_masters.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @book_masters = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /book_masters/1
  def show
  end

  # GET /book_masters/new
  def new
    @book_master = BookMaster.new
  end

  # GET /book_masters/1/edit
  def edit
  end

  # POST /book_masters
  def create
    @book_master = BookMaster.new(book_master_params)

    if @book_master.save
      redirect_to @book_master, notice: t("controller.create.success", model: BookMaster.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /book_masters/1
  def update
    if @book_master.update(book_master_params)
      redirect_to @book_master, notice: t("controller.edit.success", model: BookMaster.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /book_masters/1
  def destroy
    @book_master.destroy!
    redirect_to book_masters_url, notice: t("controller.destroy.success", model: BookMaster.model_name.human)
  end

  # POST /book_masters_bulk_insert
  def bulk_insert
    if params[:file].nil?
      redirect_to book_masters_url
      return
    end

    errors = BookMaster.csv_import(
      params[:file],
      parser,
      { "タイトル" => "title", "ISBN" => "isbn", "著者" => "author_ids", "発行日" => "publication_date", "書籍分類" => "ndc_category_id"},
      {},
      {"著者" => { parent: Author, search_column_name: :name, is_many: true}, "書籍分類" => { parent: NdcCategory, search_column_name: :name}}
    )

    if errors.empty?
      flash.notice = t("controller.create.success", model: BookMaster.model_name.human)
    else
      flash.alert = errors
    end

    redirect_to book_masters_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_book_master
      @book_master = BookMaster
        .eager_load(:ndc_category)
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_master_params
      params.require(:book_master).permit(:isbn, :title, :publication_date, :ndc_category_id, { author_ids: [] })
    end

    def parser
      Csv::CsvParser
    end
end
