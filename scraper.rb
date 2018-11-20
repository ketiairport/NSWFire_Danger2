# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
#
agent = Mechanize.new
#
# # Read in a page
page = agent.get("http://www.rfs.nsw.gov.au/fire-information/fdr-and-tobans")
#
# # Find somehing on the page using css selectors
table = page.at('table.danger-ratings-table')
table.search('tbody tr').each do |table_row|
	fire_area = {
	  area_name: table_row.search('td')[0].text,
	  fire_danger_today: table_row.search('td')[1].text,
	  councils_effected: table_row.search('td')[-1].text
	}
	puts fire_area
	ScraperWiki.save_sqlite([:area_name], fire_area)
end


#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
