class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.references :category, index: true
      t.references :tournament, index: true
      t.string :name

      t.timestamps
    end
  end
end
