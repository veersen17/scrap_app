class CreateScraps < ActiveRecord::Migration[6.0]
  def change
    create_table :scraps do |t|
      t.string :title, null: false
      t.text :data, null: false
      t.timestamps
    end
  end
end
