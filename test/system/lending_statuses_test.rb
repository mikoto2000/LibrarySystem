require "application_system_test_case"

class LendingStatusesTest < ApplicationSystemTestCase
  setup do
    @lending_status = lending_statuses(:one)
  end

  test "visiting the index" do
    visit lending_statuses_url
    assert_selector "h1", text: "Lending statuses"
  end

  test "should create lending status" do
    visit lending_statuses_url
    click_on "New lending status"

    fill_in "Name", with: @lending_status.name
    click_on "Create Lending status"

    assert_text "Lending status was successfully created"
    click_on "Back"
  end

  test "should update Lending status" do
    visit lending_status_url(@lending_status)
    click_on "Edit this lending status", match: :first

    fill_in "Name", with: @lending_status.name
    click_on "Update Lending status"

    assert_text "Lending status was successfully updated"
    click_on "Back"
  end

  test "should destroy Lending status" do
    visit lending_status_url(@lending_status)
    click_on "Destroy this lending status", match: :first

    assert_text "Lending status was successfully destroyed"
  end
end
