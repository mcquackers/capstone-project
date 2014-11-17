class ChangeAreaIdDefault < ActiveRecord::Migration
  def up
    change_column_null :users, :area_id, true
    change_column_default :users, :area_id, nil
  end

  def down
    change_column_default :users, :area_id, 1
    change_column_null :users, :area_id, false
  end
end
