require 'csv'

CSV.generate("\xEF\xBB\xBF") do |csv|
  csv << %w(id タイトル 状態 貸出セットID 貸出状態 貸出先, 貸出先連絡先)
  @book_stocks.each do |bs|
    csv << [
      bs.id,
      bs.book_master.title,
      bs.book_stock_status.name,
      bs.lending_sets.target.first ? bs.lending_sets.target.first.id : "",
      bs.lending_sets.target.first ? bs.lending_sets.target.first.lending_status.name : "",
      bs.lending_sets.target.first ? bs.lending_sets.target.first.customer.name : "",
      bs.lending_sets.target.first ? bs.lending_sets.target.first.customer.email_address : ""
    ]
  end
end
