module PostsHelper

  def pretty_tags(post=nil)
    post ||= @post
    post.tags.map { |f| "##{f}" }.join(" ") if post and post.tags
  end
end
