class CreateWeathers < ActiveRecord::Migration[6.0]
  def change
    create_table :weathers do |t|
      t.date :date
      t.decimal :lat
      t.decimal :lon
      t.string :city
      t.string :state
      t.string :temperatures

      t.timestamps
    end
  end
end
