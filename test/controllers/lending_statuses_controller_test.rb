require "test_helper"

class LendingStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lending_status = lending_statuses(:one)
  end

  test "should get index" do
    get lending_statuses_url
    assert_response :success
  end

  test "should get index find by id" do
    get lending_statuses_url, params: { q: { id_eq: @lending_status.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @lending_status.id.to_s
  end
  test "should get index search name" do
    search_string = @lending_status.name
    get lending_statuses_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: search_string # one
  end

  test "should get index search name, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get lending_statuses_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: lending_statuses(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: lending_statuses(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: lending_statuses(:destroy_target).name # destroy_target
  end

  test "should get index search created_at single hit" do
    target_datetime = @lending_status.created_at
    get lending_statuses_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = lending_statuses(:one).created_at
    target_datetime_to = lending_statuses(:two).created_at
    get lending_statuses_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @lending_status.updated_at
    get lending_statuses_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = lending_statuses(:one).updated_at
    target_datetime_to = lending_statuses(:two).updated_at
    get lending_statuses_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_lending_status_url
    assert_response :success
  end

  test "should create lending_status" do
    assert_difference("LendingStatus.count") do
      post lending_statuses_url, params: { lending_status: {
        { name: @lending_status.name }
      } }
    end

    assert_redirected_to lending_status_url(LendingStatus.last)
  end

  test "should show lending_status" do
    get lending_status_url(@lending_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_lending_status_url(@lending_status)
    assert_response :success
  end

  test "should update lending_status" do
    patch lending_status_url(@lending_status), params: { lending_status: {
      { name: @lending_status.name }
    } }
    assert_redirected_to lending_status_url(@lending_status)
  end

  test "should destroy lending_status" do
    lending_status = lending_statuses(:destroy_target)
    assert_difference("LendingStatus.count", -1) do
      delete lending_status_url(lending_status)
    end

    assert_redirected_to lending_statuses_url
  end
end
