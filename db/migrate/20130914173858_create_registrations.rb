class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.references :user
      t.references :contest

      t.timestamps
    end
  end
end
