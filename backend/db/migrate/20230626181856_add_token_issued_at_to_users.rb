# frozen_string_literal: true

class AddTokenIssuedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :token_issued_at, :datetime
  end
end
