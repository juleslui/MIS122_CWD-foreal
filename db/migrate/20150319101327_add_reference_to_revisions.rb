class AddReferenceToRevisions < ActiveRecord::Migration
  def change
    add_reference :revisions, :mailboxer_conversation, index: true
  end
end
