class AddActiveToContestTemplate < ActiveRecord::Migration
  def change
    add_column :contest_templates, :active, :boolean, default: true
  end
end
