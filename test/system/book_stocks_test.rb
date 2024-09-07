require "application_system_test_case"

class BookStocksTest < ApplicationSystemTestCase
  setup do
    @book_stock = book_stocks(:one)
  end

  test "visiting the index" do
    visit book_stocks_url
    assert_selector "h1", text: "Book stocks"
  end

  test "should create book stock" do
    visit book_stocks_url
    click_on "New book stock"

    fill_in "Book master", with: @book_stock.book_master_id
    fill_in "Book stock status", with: @book_stock.book_stock_status_id
    fill_in "Memo", with: @book_stock.memo
    click_on "Create Book stock"

    assert_text "Book stock was successfully created"
    click_on "Back"
  end

  test "should update Book stock" do
    visit book_stock_url(@book_stock)
    click_on "Edit this book stock", match: :first

    fill_in "Book master", with: @book_stock.book_master_id
    fill_in "Book stock status", with: @book_stock.book_stock_status_id
    fill_in "Memo", with: @book_stock.memo
    click_on "Update Book stock"

    assert_text "Book stock was successfully updated"
    click_on "Back"
  end

  test "should destroy Book stock" do
    visit book_stock_url(@book_stock)
    click_on "Destroy this book stock", match: :first

    assert_text "Book stock was successfully destroyed"
  end
end
