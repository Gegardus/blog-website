# frozen_string_literal: true

class SetDefaultValueToRole < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :role, 'normal'
  end
end
