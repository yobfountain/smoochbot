class Article < ActiveRecord::Base
  
  # belongs_to :author
  
  named_scope :reusable_articles, :conditions => { :can_reuse => true }
  named_scope :active_articles, :conditions => { :active => true }
  
  def self.mail_all(options = {})
  
     all_articles = Article.active_articles
  
     Smoochee.emailable.each do |smoochee|
  
       if smoochee.needs_smooching?
         available_articles = all_articles - smoochee.articles
         article = available_articles.sort_by{ rand }.slice(0)
         if article.blank?
           article = Article.active_articles.reusable_articles.sort_by{rand}.slice(0)
         end
  
         Notifications.deliver_article(smoochee, article)

  
       end
     end
  
     # Send an email to admin that the script has ran
     Notifications.deliver_admin
   end
  
  def self.get_random_article
    Article.active_articles.sort_by{rand}.slice(0)
  end
end