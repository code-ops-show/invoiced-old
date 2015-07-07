class AddLogoImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logo_image_id, :string
  end
end
