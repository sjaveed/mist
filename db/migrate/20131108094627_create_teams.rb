class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :tournament_id
      t.boolean :registration_open, default: true

      t.timestamps
    end
  end
end
