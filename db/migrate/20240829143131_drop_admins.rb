class DropAdmins < ActiveRecord::Migration[6.1]
  def change
    drop_table :adimins
  end
end
