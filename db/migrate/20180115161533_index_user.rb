class IndexUser < ActiveRecord::Migration[5.0]
  def up
    unless User.__elasticsearch__.index_exists?
      User.__elasticsearch__.create_index!
      User.import
    end

    User.all.each do |article|
      article.__elasticsearch__.index_document
    end
  end

  def down
    User.all.each do |article|
      article.__elasticsearch__.delete_document
    end
  end
end
