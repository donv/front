class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
      t.column :title, :string, :limit => 64, :null => false
      t.column :body, :text, :null => false
    end
  end

  def self.down
    drop_table :news_items
  end
end
