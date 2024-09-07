require "application_system_test_case"

class BookStockStatusesTest < ApplicationSystemTestCase
  setup do
    @book_stock_status = book_stock_statuses(:one)
  end

  test "visiting the index" do
    visit book_stock_statuses_url
    assert_selector "h1", text: "Book stock statuses"
  end

  test "should create book stock status" do
    visit book_stock_statuses_url
    click_on "New book stock status"

    fill_in "Name", with: @book_stock_status.name
    click_on "Create Book stock status"

    assert_text "Book stock status was successfully created"
    click_on "Back"
  end

  test "should update Book stock status" do
    visit book_stock_status_url(@book_stock_status)
    click_on "Edit this book stock status", match: :first

    fill_in "Name", with: @book_stock_status.name
    click_on "Update Book stock status"

    assert_text "Book stock status was successfully updated"
    click_on "Back"
  end

  test "should destroy Book stock status" do
    visit book_stock_status_url(@book_stock_status)
    click_on "Destroy this book stock status", match: :first

    assert_text "Book stock status was successfully destroyed"
  end
end
