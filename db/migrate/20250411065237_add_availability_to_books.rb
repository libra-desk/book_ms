class AddAvailabilityToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :available, :boolean, default: true
  end
end
