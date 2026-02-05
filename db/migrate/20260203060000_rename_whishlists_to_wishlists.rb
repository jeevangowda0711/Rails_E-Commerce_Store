class RenameWhishlistsToWishlists < ActiveRecord::Migration[8.1]
  def change
    rename_table :whishlists, :wishlists
  end
end
