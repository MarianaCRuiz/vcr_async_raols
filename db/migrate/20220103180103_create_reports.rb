class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :address
      t.integer :report_type, null: false, default: 0

      t.timestamps
    end
  end
end
