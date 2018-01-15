class IndexArticle < ActiveRecord::Migration[5.0]
  def up
    unless Article.__elasticsearch__.index_exists?
      Article.__elasticsearch__.create_index!
      Article.import
    end

    Article.all.each do |article|
      article.__elasticsearch__.index_document
    end
  end

  def down
    Article.all.each do |article|
      article.__elasticsearch__.delete_document
    end
  end
end
