class CreateKeywordmappings < ActiveRecord::Migration[5.2]
  def change
    create_table :keywordmappings do |t|
      t.string :keyword
      t.string :message

      t.timestamps
    end
  end
end
