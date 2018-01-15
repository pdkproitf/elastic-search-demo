class IndexUser < ActiveRecord::Migration[5.0]
  def change
      unless User.__elasticsearch__.index_exists?
        User.__elasticsearch__.create_index!
        User.import
      end
    end
end
