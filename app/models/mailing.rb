class Mailing < ActiveRecord::Base
  belongs_to :smoochee
  belongs_to :article, :class_name => "Article", :foreign_key => "article_id"
end