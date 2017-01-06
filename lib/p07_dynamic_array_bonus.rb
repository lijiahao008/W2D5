require 'byebug'

class StaticArray
  attr_reader :store
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def inspect
    @store.store
  end

  def [](i)
    return nil if i >= count || i.abs > count
    i = i % count if i < 0
    @store[i]
  end

  def []=(i, val)
    i = i % count if i < 0

    if i >= count
      if i > capacity
        (i - count).times { push(nil) }
      else
        @count = i + 1
      end
    end

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if val == el
    end
    false
  end

  def push(val)
    resize! if count >= capacity
    @count += 1
    self[count - 1] = val
    val
  end

  def unshift(val)
    index = count - 1
    push(self[index])
    while index > 0
      self[index] = self[index - 1]
      index -= 1
    end

    self[0] = val
  end

  def pop
    return nil if count == 0
    val = self[count - 1]
    self[count - 1] = nil
    @count -= 1
    resize!(0.5) if count < capacity / 4
    val
  end

  def shift
    index = 1
    val = self[0]

    while index < count
      self[index - 1] = self[index]
      index += 1
    end
    pop
    val
  end

  def first
    @store[0]
  end

  def last
    @store[count - 1]
  end

  def each(&blk)
    i = 0
    while i < count

      blk.call(self[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
    # !!!!!!!!!!
    # return false unless count == other.count
    each_with_index { |el, i| return false unless el == other[i] }
    # debugger
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!(multiplier = 2)
    new_store = StaticArray.new((capacity * multiplier).round)

    each_with_index do |el, i|
      new_store[i] = el
    end

    @store = new_store
  end
end
