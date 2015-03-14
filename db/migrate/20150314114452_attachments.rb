class Attachments < ActiveRecord::Migration
  def change
  	create_table :attachments do |t|
      t.references :note
      t.string :file
    end
  end
end
