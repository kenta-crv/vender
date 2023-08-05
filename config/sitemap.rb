# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://xn--new351c2sh.net/"

SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
add "/" , changefreq: 'daily', priority: 1.0
add "/lp" , changefreq: 'daily', priority: 0.8
add "/asahi" , changefreq: 'daily', priority: 0.8
add "/suntory" , changefreq: 'daily', priority: 0.8
add "/cocacola" , changefreq: 'daily', priority: 0.8
add "/dydo" , changefreq: 'daily', priority: 0.8
add "/itoen" , changefreq: 'daily', priority: 0.8
add "/kirin" , changefreq: 'daily', priority: 0.8
add "/otsuka" , changefreq: 'daily', priority: 0.8

  add columns_path, :priority => 1.0, :changefreq => 'daily'
  Column.find_each do |column|
    add column_path(column), :lastmod => column.updated_at
  end
end
