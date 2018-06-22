class ChangeColumnNameOfUrlTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :urls, :generated_code, :generated_url
  end
end
