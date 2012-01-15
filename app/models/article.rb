class Article < ActiveRecord::Base
  
  # belongs_to :author
  
  named_scope :reusable_articles, :conditions => { :can_reuse => true }
  named_scope :active_articles, :conditions => { :active => true }
  
  def self.mail_all(options = {})
  
     all_articles = Article.active_articles
     smoochees = Smoochee.emailable
     
     smoochees.each do |smoochee|
  
       if smoochee.needs_smooching? || options[:beta] #beta = ignore last email date
         available_articles = all_articles - smoochee.articles
         article = available_articles.sort_by{ rand }.slice(0)
         if article.nil?
           article = Article.active_articles.reusable_articles.sort_by{rand}.slice(0)
         end
  
         Notifications.article(smoochee, article).deliver
  
       end
     end
  
     # Send an email to admin that the script has ran
     Notifications.admin(smoochees).deliver
   end
   
   # Special mail_all that over rides wait times
   def self.mail_beta(options = {})
     self.mail_all(options.merge(:beta => true))
   end
  
  def self.get_random_article
    Article.active_articles.sort_by{rand}.slice(0)
  end
end