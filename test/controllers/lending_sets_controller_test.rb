require "test_helper"

class LendingSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lending_set = lending_sets(:one)
  end

  test "should get index" do
    get lending_sets_url
    assert_response :success
  end

  test "should get index find by id" do
    get lending_sets_url, params: { q: { id_eq: @lending_set.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @lending_set.id.to_s
  end
  test "should get index search customers" do
    search_ids = [lending_sets(:one).role_id, lending_sets(:two).role_id]
    get lending_sets_url, params: { q: { customer_id_in: search_ids } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: @lending_set.customer.name # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: @lending_set.customer.name # two
  end
  test "should get index search lending_statuss" do
    search_ids = [lending_sets(:one).role_id, lending_sets(:two).role_id]
    get lending_sets_url, params: { q: { lending_status_id_in: search_ids } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: @lending_set.lending_status.name # one
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: @lending_set.lending_status.name # two
  end
  test "should get index search lend_start_date" do
    target_date = @lending_set.lend_start_date
    get lending_sets_url, params: { q: {
      lend_start_date_gteq: target_date,
      lend_start_date_lteq_end_of_day: target_date
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_date) # one
  end

  test "should get index search lend_start_date, multi hit" do
    target_datetime_from = lending_sets(:one).lend_start_date
    target_datetime_to = lending_sets(:two).lend_start_date
    get lending_sets_url, params: { q: {
      lend_start_date_gteq: target_datetime_from,
      lend_start_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search lend_start_date, no hit" do
    target_datetime_from = Time.at(0, in: "UTC")
    target_datetime_to = Time.at(0, in: "UTC")
    get lending_sets_url, params: { q: {
      lend_start_date_gteq: target_datetime_from,
      lend_start_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 0
  end
  test "should get index search return_deadline_date" do
    target_date = @lending_set.return_deadline_date
    get lending_sets_url, params: { q: {
      return_deadline_date_gteq: target_date,
      return_deadline_date_lteq_end_of_day: target_date
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_date) # one
  end

  test "should get index search return_deadline_date, multi hit" do
    target_datetime_from = lending_sets(:one).return_deadline_date
    target_datetime_to = lending_sets(:two).return_deadline_date
    get lending_sets_url, params: { q: {
      return_deadline_date_gteq: target_datetime_from,
      return_deadline_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search return_deadline_date, no hit" do
    target_datetime_from = Time.at(0, in: "UTC")
    target_datetime_to = Time.at(0, in: "UTC")
    get lending_sets_url, params: { q: {
      return_deadline_date_gteq: target_datetime_from,
      return_deadline_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 0
  end
  test "should get index search return_date" do
    target_date = @lending_set.return_date
    get lending_sets_url, params: { q: {
      return_date_gteq: target_date,
      return_date_lteq_end_of_day: target_date
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_date) # one
  end

  test "should get index search return_date, multi hit" do
    target_datetime_from = lending_sets(:one).return_date
    target_datetime_to = lending_sets(:two).return_date
    get lending_sets_url, params: { q: {
      return_date_gteq: target_datetime_from,
      return_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search return_date, no hit" do
    target_datetime_from = Time.at(0, in: "UTC")
    target_datetime_to = Time.at(0, in: "UTC")
    get lending_sets_url, params: { q: {
      return_date_gteq: target_datetime_from,
      return_date_lteq_end_of_day: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 0
  end
  test "should get index search memo" do
    search_string = @lending_set.memo
    get lending_sets_url, params: { q: { memo_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(7)", text: search_string # one
  end

  test "should get index search memo, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get lending_sets_url, params: { q: { memo_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(7)", text: lending_sets(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(7)", text: lending_sets(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(7)", text: lending_sets(:destroy_target).name # destroy_target
  end

  test "should get index search created_at single hit" do
    target_datetime = @lending_set.created_at
    get lending_sets_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(8)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = lending_sets(:one).created_at
    target_datetime_to = lending_sets(:two).created_at
    get lending_sets_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(8)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(8)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @lending_set.updated_at
    get lending_sets_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(9)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = lending_sets(:one).updated_at
    target_datetime_to = lending_sets(:two).updated_at
    get lending_sets_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(9)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(9)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_lending_set_url
    assert_response :success
  end

  test "should create lending_set" do
    assert_difference("LendingSet.count") do
      post lending_sets_url, params: { lending_set: {
        { customer_id: @lending_set.customer_id, lend_start_date: @lending_set.lend_start_date, lending_status_id: @lending_set.lending_status_id, memo: @lending_set.memo, return_date: @lending_set.return_date, return_deadline_date: @lending_set.return_deadline_date }
      } }
    end

    assert_redirected_to lending_set_url(LendingSet.last)
  end

  test "should show lending_set" do
    get lending_set_url(@lending_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_lending_set_url(@lending_set)
    assert_response :success
  end

  test "should update lending_set" do
    patch lending_set_url(@lending_set), params: { lending_set: {
      { customer_id: @lending_set.customer_id, lend_start_date: @lending_set.lend_start_date, lending_status_id: @lending_set.lending_status_id, memo: @lending_set.memo, return_date: @lending_set.return_date, return_deadline_date: @lending_set.return_deadline_date }
    } }
    assert_redirected_to lending_set_url(@lending_set)
  end

  test "should destroy lending_set" do
    lending_set = lending_sets(:destroy_target)
    assert_difference("LendingSet.count", -1) do
      delete lending_set_url(lending_set)
    end

    assert_redirected_to lending_sets_url
  end
end
