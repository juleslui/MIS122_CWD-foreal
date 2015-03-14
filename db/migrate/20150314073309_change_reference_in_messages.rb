class ChangeReferenceInMessages < ActiveRecord::Migration
  def change
  	remove_column :messages, :user_id
  	add_column :messages, :office_id, :int
  end
end
