module ApplicationHelper
  def default_meta_tags
    {
      :site => 'エンジニアチェッカー',
      :title => 'エンジニアチェッカー',
      :reverse => true,
      :charset => 'utf-8',
      :description => 'エンジニアの正体を暴くTwitterアカウント分析ツール',
      :keywords => 'エンジニア,プログラミング,Twitter',
      :canonical => 'https://engineer-checker.com/',
      :separator => '|',
      :icon => [
        { :href => image_url('icon_circle.png') }
      ],
      :og => {
        :site_name => :site,
        :title => :title,
        :description => :description,
        :type => 'website',
        :url => :canonical,
        :image => image_url('ogp.png'),
        :local => 'ja-JP',
      },
      :twitter => {
        :card => 'summary_large_image',
        :site => '@shigoto_yamero'
      }
    }
  end
end
