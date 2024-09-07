require "application_system_test_case"

class LendingSetsTest < ApplicationSystemTestCase
  setup do
    @lending_set = lending_sets(:one)
  end

  test "visiting the index" do
    visit lending_sets_url
    assert_selector "h1", text: "Lending sets"
  end

  test "should create lending set" do
    visit lending_sets_url
    click_on "New lending set"

    fill_in "Customer", with: @lending_set.customer_id
    fill_in "Lend start date", with: @lending_set.lend_start_date
    fill_in "Lending status", with: @lending_set.lending_status_id
    fill_in "Memo", with: @lending_set.memo
    fill_in "Return date", with: @lending_set.return_date
    fill_in "Return deadline date", with: @lending_set.return_deadline_date
    click_on "Create Lending set"

    assert_text "Lending set was successfully created"
    click_on "Back"
  end

  test "should update Lending set" do
    visit lending_set_url(@lending_set)
    click_on "Edit this lending set", match: :first

    fill_in "Customer", with: @lending_set.customer_id
    fill_in "Lend start date", with: @lending_set.lend_start_date
    fill_in "Lending status", with: @lending_set.lending_status_id
    fill_in "Memo", with: @lending_set.memo
    fill_in "Return date", with: @lending_set.return_date
    fill_in "Return deadline date", with: @lending_set.return_deadline_date
    click_on "Update Lending set"

    assert_text "Lending set was successfully updated"
    click_on "Back"
  end

  test "should destroy Lending set" do
    visit lending_set_url(@lending_set)
    click_on "Destroy this lending set", match: :first

    assert_text "Lending set was successfully destroyed"
  end
end
