namespace :sitemap do
    desc 'Notify search engine about sitemap'
    task notify: :environment do
      sitemap_uri = "https://xn--new351c2sh.net/sitemap.xml"
      
      require 'net/http'
      require 'uri'
      
      search_engines = {
        google: 'http://www.google.com/ping?sitemap=%s',
        bing: 'http://www.bing.com/ping?sitemap=%s'
      }
      
      search_engines.each do |name, url|
        request_url = sprintf(url, URI.encode(sitemap_uri))
        response = Net::HTTP.get_response(URI.parse(request_url))
        
        if response.is_a?(Net::HTTPSuccess)
          puts "Notified #{name} about sitemap update."
        else
          puts "Failed to notify #{name} about sitemap update."
        end
      end
    end
end


