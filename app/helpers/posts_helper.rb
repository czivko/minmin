module PostsHelper

  def pretty_tags(post=nil)
    post ||= @post
    post.tags.map { |f| "##{f}" }.join(" ") if post and post.tags
  end

  def post_types_select
    Post.post_types.map { |p| [p.to_s.titleize, p ] }
  end
end
