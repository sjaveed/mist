class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.integer :region_id
      t.integer :season_id

      t.timestamps
    end
  end
end
