class AddStatusToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :status, :string, default: "OPEN"
  end
end
