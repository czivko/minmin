require 'open-uri'
require 'fileutils'
require 'nokogiri'
require 'date'
require 'json'
require 'uri'

class TumblrImport
    def self.process(url=nil, grab_images = false,
                     add_highlights = false, rewrite_urls = true)
      @grab_images = grab_images
      url ||= "http://chaziv.tumblr.com"
      url += "/api/read/json/"
      per_page = 50
      posts = []
      # Two passes are required so that we can rewrite URLs.
      # First pass builds up an array of each post as a hash.
      begin
        current_page = (current_page || -1) + 1
        feed = open(url + "?num=#{per_page}&start=#{current_page * per_page}")
        json = feed.readlines.join("\n")[21...-2]  # Strip Tumblr's JSONP chars.
        blog = JSON.parse(json)
        puts "Page: #{current_page + 1} - Posts: #{blog["posts"].size}"
        posts += blog["posts"].map { |post| post_to_hash(post) }
      end until blog["posts"].size < per_page
      # Rewrite URLs and create redirects.
      #posts = rewrite_urls_and_redirects posts if rewrite_urls
      # Second pass for writing post files.
      posts.each do |post|
        p post[:body]
        new_post = Post.new
        new_post.published_at = post[:published_at]
        new_post.title = post[:title]
        new_post.tags = post["tags"] 
        new_post.body = post[:body]
        new_post.tumblr_url = post["url"]
        #new_post.tumblr_url = post["url-with-slug"],
        new_post.post_type = post[:post_type]
        new_post.save!
      end
    end
    

    private

    # Converts each type of Tumblr post to a hash with all required
    # data for Jekyll.
    def self.post_to_hash(post)
      case post['type']
        when "regular"
          title = post["regular-title"]
          content = post["regular-body"]
        when "link"
          title = post["link-text"] || post["link-url"]
          content = "<a href=\"#{post["link-url"]}\">#{title}</a>"
          unless post["link-description"].nil?
            content << "<br/>" + post["link-description"]
          end
        when "photo"
          title = post["photo-caption"]
          max_size = post.keys.map{ |k| k.gsub("photo-url-", "").to_i }.max
          url = post["photo-url"] || post["photo-url-#{max_size}"]
          ext = "." + post[post.keys.select { |k|
            k =~ /^photo-url-/ && post[k].split("/").last =~ /\./
          }.first].split(".").last
          content = "<img src=\"#{save_file(url, ext)}\"/>"
          unless post["photo-link-url"].nil?
            content = "<a href=\"#{post["photo-link-url"]}\">#{content}</a>"
          end
        when "audio"
          if !post["id3-title"].nil?
            title = post["id3-title"]
            content = post.at["audio-player"] + "<br/>" + post["audio-caption"]
          else
            title = post["audio-caption"]
            content = post.at["audio-player"]
          end
        when "quote"
          title = post["quote-text"]
          content = "<blockquote>#{post["quote-text"]}</blockquote>"
          unless post["quote-source"].nil?
            content << "&#8212;" + post["quote-source"]
          end
        when "conversation"
          title = post["conversation-title"]
          content = "<section><dialog>"
          post["conversation"].each do |line|
            content << "<dt>#{line['label']}</dt><dd>#{line['phrase']}</dd>"
          end
          content << "</section></dialog>"
        when "video"
          title = post["video-title"]
          content = post["video-player"]
          unless post["video-caption"].nil?
            content << "<br/>" + post["video-caption"]
          end
      end
      date = Date.parse(post['date']).to_s
      title = Nokogiri::HTML(title).text
      #slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      #slug = slug.slice(0..200) if slug.length > 200
      {
        published_at: date,
        title: title,
        tags: post["tags"], 
        body: content,
        tumblr_url: post["url"],
        slug: post["url-with-slug"],
        post_type: post["type"]

      }
    end

    def self.save_file(url, ext)
      if @grab_images
        path = "tumblr_files/#{url.split('/').last}"
        path += ext unless path =~ /#{ext}$/
        FileUtils.mkdir_p "tumblr_files"
        File.open(path, "w") { |f| f.write(open(url).read) }
        url = "/" + path
      end
      url
    end
end