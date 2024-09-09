require "test_helper"

class NdcCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ndc_category = ndc_categories(:one)
  end

  test "should get index" do
    get ndc_categories_url
    assert_response :success
  end

  test "should get index find by id" do
    get ndc_categories_url, params: { q: { id_eq: @ndc_category.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @ndc_category.id.to_s
  end
  test "should get index search name" do
    search_string = @ndc_category.name
    get ndc_categories_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: search_string # one
  end

  test "should get index search name, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get ndc_categories_url, params: { q: { name_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: ndc_categories(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: ndc_categories(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: ndc_categories(:destroy_target).name # destroy_target
  end
  test "should get index search number" do
    search_string = @ndc_category.number
    get ndc_categories_url, params: { q: { number_eq: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: search_string.to_s # one
  end

  # TODO: number は eq なので根本的にテスト方法が違う
  # test "should get index search number, multi hit" do
  #   search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
  #   get ndc_categories_url, params: { q: { number_cont: search_string } }
  #   assert_response :success

  #   assert_select "table > tbody > tr", count: 3
  #   assert_select "table > tbody > tr > td:nth-of-type(3)", text: ndc_categories(:one).name # one
  #   assert_select "table > tbody > tr > td:nth-of-type(3)", text: ndc_categories(:two).name # two
  #   assert_select "table > tbody > tr > td:nth-of-type(3)", text: ndc_categories(:destroy_target).name # destroy_target
  # end

  test "should get index search created_at single hit" do
    target_datetime = @ndc_category.created_at
    get ndc_categories_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = ndc_categories(:one).created_at
    target_datetime_to = ndc_categories(:two).created_at
    get ndc_categories_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @ndc_category.updated_at
    get ndc_categories_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = ndc_categories(:one).updated_at
    target_datetime_to = ndc_categories(:two).updated_at
    get ndc_categories_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_ndc_category_url
    assert_response :success
  end

  # TODO: ???
  # test "should create ndc_category" do
  #   assert_difference("NdcCategory.count") do
  #     post ndc_categories_url, params: { ndc_category:
  #       { name: @ndc_category.name, number: @ndc_category.number }
  #     }
  #   end

  #   assert_redirected_to ndc_category_url(NdcCategory.last)
  # end

  test "should show ndc_category" do
    get ndc_category_url(@ndc_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_ndc_category_url(@ndc_category)
    assert_response :success
  end

  test "should update ndc_category" do
    patch ndc_category_url(@ndc_category), params: { ndc_category:
      { name: @ndc_category.name, number: @ndc_category.number } }
    assert_redirected_to ndc_category_url(@ndc_category)
  end

  test "should destroy ndc_category" do
    ndc_category = ndc_categories(:destroy_target)
    assert_difference("NdcCategory.count", -1) do
      delete ndc_category_url(ndc_category)
    end

    assert_redirected_to ndc_categories_url
  end
end
