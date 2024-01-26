namespace :release do
  # 既存データの「他社NG」を「見送りNG」に更新するrakeタスク
  # コマンド：rake release:other_company_ng_label
  task other_company_ng_label: :environment do
    columns = [:asahi, :cocacola, :itoen, :dydo, :yamakyu, :neos, :net]

    Comment.find_each do |comment|
      update_data = {}
        columns.each do |column|
          if comment.send(column) == '他社NG'
            update_data[column] = '見送りNG'
          end
        end
        comment.update_columns(update_data) if update_data.present?
      end
    end
end