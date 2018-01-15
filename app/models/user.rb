class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "elasticsearch_demo_#{User.table_name}"

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true'
  end

  after_save    -> { __elasticsearch__.index_document }
  after_destroy -> { __elasticsearch__.delete_document }
end
