require "csv"

module CsvImportable
  extend ActiveSupport::Concern

  module ClassMethods

    # CSV ファイルのパースを行い、モデル作成・バリデーション・DB登録を行う。
    #
    # ==== Args:
    # file(File):: CSV ファイル
    # parser(CsvParser):: CSV ファイルパーサー
    # header_config:: key が CSV ヘッダーに記載された値、value がモデルのプロパティとなる Hash
    # type_convert_config:: 「key が CSV ヘッダーに記載された値 CSV から取得した文字列を型変換するための無名関数」となる Hash
    # association_config:: 関連に関する情報を格納した Hash(ex: { <CSVヘッダーに記載された値> => { parent: <検索に使用するエンティティのクラスオブジェクト>, search_column_name: <検索に使用するカラム名>, [is_many: <対多関連の場合 true を設定>] })
    #
    # ==== Return:
    # インポートエラーとなった行のエラー情報配列
    #
    # ==== Example:
    #
    #     errors = BookMaster.csv_import(
    #       params[:file],
    #       parser,
    #       { "タイトル" => "title", "ISBN" => "isbn", "著者" => "author_ids", "発行日" => "publication_date", "書籍分類" => "ndc_category_id"},
    #       {"ISBN" => lambda{|v| v.to_i }},
    #       {"著者" => { parent: Author, search_column_name: :name, is_many: true}, "書籍分類" => { parent: NdcCategory, search_column_name: :name}}
    #     )

    def csv_import(file, parser, header_config, type_convert_config, association_config)
      # CSV から目的のモデルインスタンスを生成
      csv_records = parser.new(Rails.logger, header_config, type_convert_config, association_config).call(file)

      # バリデーションを実行
      errors = collect_validate_errors(csv_records)

      # エラーが無ければ bulk insert 実行
      # rubocop:disable Rails/SkipsModelValidations
      # `collect_validate_errors` にてバリデーション済みなので警告を抑制
      insert_all(csv_records.map(&:model)) if errors.empty?
      # rubocop:enable Rails/SkipsModelValidations

      errors
    end

    def collect_validate_errors(model_with_lineno)
      # 返却用配列
      errors = []

      # バリデーションを実行し、エラーがあればエラーメッセージを返却用配列へ格納
      model_with_lineno.each do |mwl|
        pp mwl
        model = create(mwl.model)
        is_valid = model.validate

        messages = model.errors.full_messages.map do |message|
          "lineno: #{mwl.lineno}, name: #{mwl.model['name']}, message: #{message}"
        end

        errors.concat(messages) unless is_valid
      end

      errors
    end
  end
end
