class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :input
      t.string :from
      t.string :to
      t.string :output

      t.timestamps
    end
  end
end
