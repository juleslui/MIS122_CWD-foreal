class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.references :message
      t.string :received_from
      t.datetime :time_sent
      t.datetime :time_elapsed
      t.string :sent_to
      t.string :attachment
      t.timestamps null: false
    end
  end
end
