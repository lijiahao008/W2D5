require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! unless num_buckets > @count
    return false if include?(key)
    self[key.hash] << key.hash
    @count += 1
    true
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    self[key.hash].delete(key.hash)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    result = Array.new(num_buckets * 2) { Array.new }
    @store.each do |el|
      el.each do |num|
        result[num % (result.length)] << num
      end
    end
    @store = result
  end
end
