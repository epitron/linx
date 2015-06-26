class Tag < ActiveRecord::Base
  has_and_belongs_to_many :links, counter_cache: true

  def inspect
    "<#{name} (#{links_count})>"
  end
end
