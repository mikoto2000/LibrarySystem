json.extract! book_master, :id, :isbn, :title, :publication_date, :ndc_category_id, :created_at, :updated_at
json.url book_master_url(book_master, format: :json)
