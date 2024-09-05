require "test_helper"

class BookMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_master = book_masters(:one)
  end

  test "should get index" do
    get book_masters_url
    assert_response :success
  end

  test "should get index find by id" do
    get book_masters_url, params: { q: { id_eq: @book_master.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @book_master.id.to_s
  end
  test "should get index search isbn" do
    search_string = @book_master.isbn
    get book_masters_url, params: { q: { isbn_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: search_string # one
  end

  test "should get index search isbn, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get book_masters_url, params: { q: { isbn_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: book_masters(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: book_masters(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: book_masters(:destroy_target).name # destroy_target
  end
  test "should get index search title" do
    search_string = @book_master.title
    get book_masters_url, params: { q: { title_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: search_string # one
  end

  test "should get index search title, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get book_masters_url, params: { q: { title_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: book_masters(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: book_masters(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: book_masters(:destroy_target).name # destroy_target
  end
  test "should get index search publication_date" do
    target_date = @book_master.publication_date
    get book_masters_url, params: { q: {
      publication_date_gteq: target_date,
      publication_date_lteq_end_of_day: target_date
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_date) # one
  end

  test "should get index search publication_date, multi hit" do
    target_datetime_from = book_masters(:one).publication_date
    target_datetime_to = book_masters(:two).publication_date
    get book_masters_url, params: { q: {
      publication_date_gteq: target_datetime_from,
      publication_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search publication_date, no hit" do
    target_datetime_from = Time.at(0, in: "UTC")
    target_datetime_to = Time.at(0, in: "UTC")
    get book_masters_url, params: { q: {
      publication_date_gteq: target_datetime_from,
      publication_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 0
  end
  test "should get index search ndc_categorys" do
    search_ids = [book_masters(:one).role_id, book_masters(:two).role_id]
    get book_masters_url, params: { q: { ndc_category_id_in: search_ids } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: @book_master.ndc_category.name # one
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: @book_master.ndc_category.name # two
  end

  test "should get index search created_at single hit" do
    target_datetime = @book_master.created_at
    get book_masters_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = book_masters(:one).created_at
    target_datetime_to = book_masters(:two).created_at
    get book_masters_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @book_master.updated_at
    get book_masters_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(7)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = book_masters(:one).updated_at
    target_datetime_to = book_masters(:two).updated_at
    get book_masters_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(7)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(7)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_book_master_url
    assert_response :success
  end

  test "should create book_master" do
    assert_difference("BookMaster.count") do
      post book_masters_url, params: { book_master: {
        { isbn: @book_master.isbn, ndc_category_id: @book_master.ndc_category_id, publication_date: @book_master.publication_date, title: @book_master.title }
      } }
    end

    assert_redirected_to book_master_url(BookMaster.last)
  end

  test "should show book_master" do
    get book_master_url(@book_master)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_master_url(@book_master)
    assert_response :success
  end

  test "should update book_master" do
    patch book_master_url(@book_master), params: { book_master: {
      { isbn: @book_master.isbn, ndc_category_id: @book_master.ndc_category_id, publication_date: @book_master.publication_date, title: @book_master.title }
    } }
    assert_redirected_to book_master_url(@book_master)
  end

  test "should destroy book_master" do
    book_master = book_masters(:destroy_target)
    assert_difference("BookMaster.count", -1) do
      delete book_master_url(book_master)
    end

    assert_redirected_to book_masters_url
  end
end
