class AddContestTemplateIdToContest < ActiveRecord::Migration
  def change
    add_column :contests, :contest_template_id, :integer
  end
end
