class CreateTwitterUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :twitter_users do |t|
      t.string :handle


      t.timestamps
    end

    create_table :tweets do |t|
      t.string :twitter_user_id
      t.string :body
      t.datetime :posted_at

      t.timestamps
    end
  end
end
