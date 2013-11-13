module PostsHelper

  def pretty_tags(post=nil)
    post ||= @post
    post.tags.map { |f| f }.join ', '
  end
end
