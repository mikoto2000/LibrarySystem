require "application_system_test_case"

class BookMastersTest < ApplicationSystemTestCase
  setup do
    @book_master = book_masters(:one)
  end

  test "visiting the index" do
    visit book_masters_url
    assert_selector "h1", text: "Book masters"
  end

  test "should create book master" do
    visit book_masters_url
    click_on "New book master"

    fill_in "Isbn", with: @book_master.isbn
    fill_in "Ndc category", with: @book_master.ndc_category_id
    fill_in "Publication date", with: @book_master.publication_date
    fill_in "Title", with: @book_master.title
    click_on "Create Book master"

    assert_text "Book master was successfully created"
    click_on "Back"
  end

  test "should update Book master" do
    visit book_master_url(@book_master)
    click_on "Edit this book master", match: :first

    fill_in "Isbn", with: @book_master.isbn
    fill_in "Ndc category", with: @book_master.ndc_category_id
    fill_in "Publication date", with: @book_master.publication_date
    fill_in "Title", with: @book_master.title
    click_on "Update Book master"

    assert_text "Book master was successfully updated"
    click_on "Back"
  end

  test "should destroy Book master" do
    visit book_master_url(@book_master)
    click_on "Destroy this book master", match: :first

    assert_text "Book master was successfully destroyed"
  end
end
