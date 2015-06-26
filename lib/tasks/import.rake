namespace :db do

  desc "Import delicious links from delicious-cli"
  task import: :environment do
    links = Path["~/.delicious/delicious.marshal"].parse

    # {
    #   "href"=>"http://www.math-atlas.org/", 
    #   "hash"=>"62c3de9eb43e751f4cc8a90176088855", 
    #   "description"=>"Mathematical Atlas: A gateway to Mathematics", 
    #   "tag"=>"math reference", 
    #   "time"=>Sat, 07 Aug 2004 18:50:04 +0000, 
    #   "extended"=>"", 
    #   "meta"=>"c3fa9c12b52660364d030490cddbdce2", 
    # }

    links.each_with_index do |l,i|
      url = l["href"]
      title = l["description"]
      desc = l["extended"]

      user = User.first

      puts "#{i}. #{title}"
      puts "       #{url}"

      link = user.links.create(url: url, title: title, description: desc, created_at: l["time"])
      
      tags = l["tag"].split
      tags = tags.map { |tag| Tag.find_or_create_by(name: tag) }

      link.tags = tags

      link.save

      puts
    end

  end

  desc "Update tags' counter caches"
  task tagcounts: :environment do

    puts "Updating 'links_count' for #{Tag.count} tags..."

    p ActiveRecord::Base.connection.execute %{
      UPDATE tags SET links_count=counts.total
      FROM (
        SELECT tag_id, count(tag_id) as total
        FROM links_tags
        GROUP BY tag_id
      ) AS counts
      WHERE tags.id = counts.tag_id;
    }

    puts "Done!"

    puts
    puts "Top 10 tags:"
    puts "-----------------------------"
    pp Tag.order("links_count desc").first(10)

    # SELECT * FROM tags LIMIT 10;
  end

end
