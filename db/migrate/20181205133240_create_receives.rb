class CreateReceives < ActiveRecord::Migration[5.2]
  def change
    create_table :receives do |t|
      t.string :channel_id
      t.string :text
      t.timestamps
    end
  end
end