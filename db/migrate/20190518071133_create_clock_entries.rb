class CreateClockEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_entries do |t|
      t.references :user, foreign_key: true
      t.string :action_type
      t.datetime :datetime
      t.text :note

      t.timestamps
    end
  end
end
