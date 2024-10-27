require "test_helper"

class BookMasterTest < ActiveSupport::TestCase
  test "valid ISBN-10" do
    book = BookMaster.new(isbn: "0306406152", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert book.valid?
  end

  test "invalid ISBN-10" do
    book = BookMaster.new(isbn: "0306406153", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "valid ISBN-13" do
    book = BookMaster.new(isbn: "9780306406157", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert book.valid?
  end

  test "invalid ISBN-13" do
    book = BookMaster.new(isbn: "9780306406158", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "ISBN-10 with X as checksum" do
    book = BookMaster.new(isbn: "048665088X", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert book.valid?
  end

  test "ISBN-10 with invalid characters" do
    book = BookMaster.new(isbn: "03064O6152", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "ISBN-13 with invalid characters" do
    book = BookMaster.new(isbn: "978O306406157", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "ISBN-10 with incorrect length" do
    book = BookMaster.new(isbn: "030640615", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "ISBN-13 with incorrect length" do
    book = BookMaster.new(isbn: "978030640615", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "valid hyphenated ISBN-10" do
    book = BookMaster.new(isbn: "0-306-40615-2", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert book.valid?
  end

  test "invalid hyphenated ISBN-10" do
    book = BookMaster.new(isbn: "0-306-40615-3", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "valid hyphenated ISBN-13" do
    book = BookMaster.new(isbn: "978-0-306-40615-7", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert book.valid?
  end

  test "invalid hyphenated ISBN-13" do
    book = BookMaster.new(isbn: "978-0-306-40615-8", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    assert_not book.valid?
  end

  test "normalize ISBN before save" do
    book = BookMaster.new(isbn: "978-0-306-40615-7", title: "Test Book", publication_date: Date.today, ndc_category: ndc_categories(:one))
    book.save
    assert_equal "9780306406157", book.isbn
  end
end
