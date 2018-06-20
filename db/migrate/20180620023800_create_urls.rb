class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :original
      t.string :generated_code

      t.timestamps
    end
  end
end
