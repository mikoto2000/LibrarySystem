class AuthorsController < ApplicationController
  include Pagy::Backend
  before_action :set_author, only: %i[show edit update destroy]

  # GET /authors
  def index
    @authors = Author
      .all
    @q = @authors.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @authors = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /authors/1
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to @author, notice: t("controller.create.success", model: Author.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      redirect_to @author, notice: t("controller.edit.success", model: Author.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /authors/1
  def destroy
    @author.destroy!
    redirect_to authors_url, notice: t("controller.destroy.success", model: Author.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name)
    end
end
