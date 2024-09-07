json.extract! book_stock, :id, :book_master_id, :book_stock_status_id, :memo, :created_at, :updated_at
json.url book_stock_url(book_stock, format: :json)
