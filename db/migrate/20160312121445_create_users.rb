class CreateUsers < Framework::Migration
  use_database :default

  def up
    create_table :users do |t|
      t.string :email
      t.integer :cost
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
