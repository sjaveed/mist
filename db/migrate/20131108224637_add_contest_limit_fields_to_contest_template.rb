class AddContestLimitFieldsToContestTemplate < ActiveRecord::Migration
  def change
    add_column :contest_templates, :minimum_competitors, :integer, default: 1
    add_column :contest_templates, :maximum_competitors, :integer

    add_column :contests, :minimum_competitors, :integer, default: 1
    add_column :contests, :maximum_competitors, :integer
  end
end
