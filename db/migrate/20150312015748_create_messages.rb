class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user
      t.string   :sent_to
      t.datetime :date_sent
      t.string   :subject
      t.datetime :deadline
      t.string   :received_from
      t.string   :attachment
      t.string   :send_to
      t.datetime :time_elapsed
      t.datetime :date_received
      t.string :avatars
      t.timestamps null: false
    end
  end
end
