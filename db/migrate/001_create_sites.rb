class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.column :title, :string, limit: 64, null: false
      t.column :welcome_text, :string, null: false
    end
  end
end
