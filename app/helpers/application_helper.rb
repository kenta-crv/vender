module ApplicationHelper
  def default_meta_tags
    {
      site: "",
      title:"<%= yield(:title) | 自販機ねっと' %>",
      description: "自動販売機の一括比較見積もりなら『自販機ねっと』。条件の良い自販機会社を手軽に見積りできます。",
      charset: "UTF-8",
      reverse: true,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('favicon.ico'),  rel: 'apple-touch-icon' },
      ]
    }
  end

end
