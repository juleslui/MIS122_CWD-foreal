class AddDefaultValueToColumn < ActiveRecord::Migration
  def change
  	change_column :users, :status, :string, :default => 'OK'
  end
end
