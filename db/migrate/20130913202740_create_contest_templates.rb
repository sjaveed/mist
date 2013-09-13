class CreateContestTemplates < ActiveRecord::Migration
  def change
    create_table :contest_templates do |t|
      t.references :category, index: true
      t.string :name

      t.timestamps
    end
  end
end
