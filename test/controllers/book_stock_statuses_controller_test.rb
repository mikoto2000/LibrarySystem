require "test_helper"

class BookStockStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_stock_status = book_stock_statuses(:one)
  end

  test "should get index" do
    get book_stock_statuses_url
    assert_response :success
  end

  test "should get index find by id" do
    get book_stock_statuses_url, params: { q: { id_eq: @book_stock_status.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @book_stock_status.id.to_s
  end
  test "should get index search name" do
    search_string = @book_stock_status.name
    get book_stock_statuses_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: search_string # one
  end

  test "should get index search name, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get book_stock_statuses_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: book_stock_statuses(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: book_stock_statuses(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: book_stock_statuses(:destroy_target).name # destroy_target
  end

  test "should get index search created_at single hit" do
    target_datetime = @book_stock_status.created_at
    get book_stock_statuses_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = book_stock_statuses(:one).created_at
    target_datetime_to = book_stock_statuses(:two).created_at
    get book_stock_statuses_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @book_stock_status.updated_at
    get book_stock_statuses_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = book_stock_statuses(:one).updated_at
    target_datetime_to = book_stock_statuses(:two).updated_at
    get book_stock_statuses_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_book_stock_status_url
    assert_response :success
  end

  # TODO: ???
  # test "should create book_stock_status" do
  #   assert_difference("BookStockStatus.count") do
  #     post book_stock_statuses_url, params: { book_stock_status:
  #       { name: @book_stock_status.name }
  #     }
  #   end

  #   assert_redirected_to book_stock_status_url(BookStockStatus.last)
  # end

  test "should show book_stock_status" do
    get book_stock_status_url(@book_stock_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_stock_status_url(@book_stock_status)
    assert_response :success
  end

  test "should update book_stock_status" do
    patch book_stock_status_url(@book_stock_status), params: { book_stock_status:
      { name: @book_stock_status.name }
    }
    assert_redirected_to book_stock_status_url(@book_stock_status)
  end

  test "should destroy book_stock_status" do
    book_stock_status = book_stock_statuses(:destroy_target)
    assert_difference("BookStockStatus.count", -1) do
      delete book_stock_status_url(book_stock_status)
    end

    assert_redirected_to book_stock_statuses_url
  end
end
