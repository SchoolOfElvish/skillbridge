# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name, null: false # rubocop:disable Rails/NotNullColumn
      t.string :last_name, null: false # rubocop:disable Rails/NotNullColumn
      t.date :birthdate
      t.text :about
    end
  end
end
