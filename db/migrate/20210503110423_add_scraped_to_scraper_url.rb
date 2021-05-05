class AddScrapedToScraperUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :scraper_urls, :scraped, :boolean, default: false
  end
end
