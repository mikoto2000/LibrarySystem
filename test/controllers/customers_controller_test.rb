require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get index find by id" do
    get customers_url, params: { q: { id_eq: @customer.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @customer.id.to_s
  end
  test "should get index search name" do
    search_string = @customer.name
    get customers_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: search_string # one
  end

  test "should get index search name, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get customers_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: customers(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: customers(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: customers(:destroy_target).name # destroy_target
  end
  test "should get index search email_address" do
    search_string = @customer.email_address
    get customers_url, params: { q: { email_address_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: search_string # one
  end

  test "should get index search email_address, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get customers_url, params: { q: { email_address_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: customers(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: customers(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: customers(:destroy_target).name # destroy_target
  end

  test "should get index search created_at single hit" do
    target_datetime = @customer.created_at
    get customers_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = customers(:one).created_at
    target_datetime_to = customers(:two).created_at
    get customers_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @customer.updated_at
    get customers_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = customers(:one).updated_at
    target_datetime_to = customers(:two).updated_at
    get customers_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end

  test "should create customer" do
    assert_difference("Customer.count") do
      post customers_url, params: { customer:
        { email_address: @customer.email_address, name: @customer.name }
      }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    get customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer:
      { email_address: @customer.email_address, name: @customer.name }
    }
    assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    customer = customers(:destroy_target)
    assert_difference("Customer.count", -1) do
      delete customer_url(customer)
    end

    assert_redirected_to customers_url
  end
end
