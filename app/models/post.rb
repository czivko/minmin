class Post < ActiveRecord::Base
  POST_TYPES = [ :text, :photo, :quote, :link, :video ]
  validates_inclusion_of :post_type, in: POST_TYPES
  
  before_validation :symbolize_usertype
  after_validation :slugify_title
   
  def self.post_types
    POST_TYPES
  end

  protected
  def slugify_title
    self.slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def symbolize_usertype
    self.post_type = self.post_type.to_sym if post_type
  end
end
