require 'jekyll'

module ExternalPosts
  class ExternalPostsGenerator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      # --- Disable on GitHub Pages / Production builds ---
      if ENV['JEKYLL_ENV'] == 'production'
        Jekyll.logger.warn "ExternalPosts:", "Skipping external posts (production build)."
        return
      end

      # --- Disable if not configured ---
      sources = site.config['external_sources']
      return unless sources && sources.any?

      begin
        require 'feedjira'
        require 'httparty'
      rescue LoadError
        Jekyll.logger.warn "ExternalPosts:", "Required gems not available. Skipping."
        return
      end

      sources.each do |src|
        Jekyll.logger.info "ExternalPosts:", "Fetching external posts from #{src['name']}"

        begin
          xml = HTTParty.get(src['rss_url']).body
          feed = Feedjira.parse(xml)
        rescue => e
          Jekyll.logger.warn "ExternalPosts:", "Failed to fetch or parse feed: #{e}"
          next
        end

        feed.entries.each do |e|
          slug = e.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
          path = site.in_source_dir("_posts/#{slug}.md")

          doc = Jekyll::Document.new(
            path,
            { site: site, collection: site.collections['posts'] }
          )

          doc.data['external_source'] = src['name']
          doc.data['feed_content'] = e.content
          doc.data['title'] = e.title
          doc.data['description'] = e.summary
          doc.data['date'] = e.published
          doc.data['redirect'] = e.url

          site.collections['posts'].docs << doc
        end
      end
    end
  end
end
