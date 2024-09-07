json.extract! lending_set, :id, :customer_id, :lending_status_id, :lend_start_date, :return_deadline_date, :return_date, :memo, :created_at, :updated_at
json.url lending_set_url(lending_set, format: :json)
