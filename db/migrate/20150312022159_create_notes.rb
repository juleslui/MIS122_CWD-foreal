class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user
      t.references :message
      t.string :content
      t.datetime :datetime_sent
      t.timestamps null: false
    end
  end
end
