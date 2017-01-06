require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map.get(key))
    else
      calc!(key)
      eject! if count > @max
    end
    
    @map.get(key).val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    node = @store.append(key, @prc.call(key))
    @map.set(key, node)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    node = @store.append(link.key, link.val)
    @map.set(link.key, node)
    link.remove
  end

  def eject!
    oldest = @store.first
    @map.delete(oldest.key)
    oldest.remove
  end
end
