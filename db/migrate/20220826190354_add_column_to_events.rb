# frozen_string_literal: true

class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :movie_title, :string
  end
end
