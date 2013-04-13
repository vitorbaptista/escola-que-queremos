class CreateSchoolQuests < ActiveRecord::Migration
  def change
    create_table :school_quests do |t|

      t.timestamps
    end
  end
end
