class MoveAttachmentToNotes < ActiveRecord::Migration
  def change
  	remove_column :messages, :attachment
  	remove_column :messages, :avatars
  end
end
