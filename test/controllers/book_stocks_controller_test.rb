require "test_helper"

class BookStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_stock = book_stocks(:one)
  end

  test "should get index" do
    get book_stocks_url
    assert_response :success
  end

  test "should get index find by id" do
    get book_stocks_url, params: { q: { id_eq: @book_stock.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @book_stock.id.to_s
  end
  test "should get index search book_masters" do
    search_ids = [book_stocks(:one).book_master_id, book_stocks(:two).book_master_id]
    get book_stocks_url, params: { q: { book_master_id_in: search_ids } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: @book_stock.book_master.title # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: @book_stock.book_master.title # two
  end
  test "should get index search book_stock_statuses" do
    search_ids = [book_stocks(:one).book_stock_status_id, book_stocks(:two).book_stock_status_id]
    get book_stocks_url, params: { q: { book_stock_status_id_in: search_ids } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: @book_stock.book_stock_status.name # one
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: @book_stock.book_stock_status.name # two
  end
  test "should get index search memo" do
    search_string = @book_stock.memo
    get book_stocks_url, params: { q: { memo_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: search_string # one
  end

  test "should get index search memo, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get book_stocks_url, params: { q: { memo_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: book_stocks(:one).memo # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: book_stocks(:two).memo # two
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: book_stocks(:destroy_target).memo # destroy_target
  end

  test "should get index search created_at single hit" do
    target_datetime = @book_stock.created_at
    get book_stocks_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = book_stocks(:one).created_at
    target_datetime_to = book_stocks(:two).created_at
    get book_stocks_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @book_stock.updated_at
    get book_stocks_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = book_stocks(:one).updated_at
    target_datetime_to = book_stocks(:two).updated_at
    get book_stocks_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_book_stock_url
    assert_response :success
  end

  test "should create book_stock" do
    assert_difference("BookStock.count") do
      post book_stocks_url, params: { book_stock:
        { book_master_id: @book_stock.book_master_id, book_stock_status_id: @book_stock.book_stock_status_id, memo: @book_stock.memo }
      }
    end

    assert_redirected_to book_stock_url(BookStock.last)
  end

  test "should show book_stock" do
    get book_stock_url(@book_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_stock_url(@book_stock)
    assert_response :success
  end

  test "should update book_stock" do
    patch book_stock_url(@book_stock), params: { book_stock:
      { book_master_id: @book_stock.book_master_id, book_stock_status_id: @book_stock.book_stock_status_id, memo: @book_stock.memo }
    }
    assert_redirected_to book_stock_url(@book_stock)
  end

  test "should destroy book_stock" do
    book_stock = book_stocks(:destroy_target)
    assert_difference("BookStock.count", -1) do
      delete book_stock_url(book_stock)
    end

    assert_redirected_to book_stocks_url
  end
end
