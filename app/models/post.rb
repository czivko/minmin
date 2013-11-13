class Post < ActiveRecord::Base

  after_validation :slugify_title

  protected
  def slugify_title
    self.slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
