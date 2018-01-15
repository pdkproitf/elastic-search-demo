class Article < ApplicationRecord
  include Searchable

  index_name "elasticsearch_demo_#{Article.table_name}"

  belongs_to :user
end
