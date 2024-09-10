require "csv"

module CsvImportable
  extend ActiveSupport::Concern

  module ClassMethods
    def csv_import(file, parser, header_config, association_config)
      # CSV から目的のモデルインスタンスを生成
      csv_records = parser.new(Rails.logger, header_config, association_config).call(file)

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
        model = new(mwl.model)
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
