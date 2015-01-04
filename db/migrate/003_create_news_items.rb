class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.column :title, :string, limit: 64, null: false
      t.column :body, :text, null: false
    end
  end
end
