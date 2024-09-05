require "application_system_test_case"

class NdcCategoriesTest < ApplicationSystemTestCase
  setup do
    @ndc_category = ndc_categories(:one)
  end

  test "visiting the index" do
    visit ndc_categories_url
    assert_selector "h1", text: "Ndc categories"
  end

  test "should create ndc category" do
    visit ndc_categories_url
    click_on "New ndc category"

    fill_in "Name", with: @ndc_category.name
    fill_in "Number", with: @ndc_category.number
    click_on "Create Ndc category"

    assert_text "Ndc category was successfully created"
    click_on "Back"
  end

  test "should update Ndc category" do
    visit ndc_category_url(@ndc_category)
    click_on "Edit this ndc category", match: :first

    fill_in "Name", with: @ndc_category.name
    fill_in "Number", with: @ndc_category.number
    click_on "Update Ndc category"

    assert_text "Ndc category was successfully updated"
    click_on "Back"
  end

  test "should destroy Ndc category" do
    visit ndc_category_url(@ndc_category)
    click_on "Destroy this ndc category", match: :first

    assert_text "Ndc category was successfully destroyed"
  end
end
