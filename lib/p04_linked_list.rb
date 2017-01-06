class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = @next
    self.next.prev = @prev
    self.next = nil
    self.prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    node = Link.new(key, val)
    last.next = node
    node.prev = last
    @tail.prev = node
    node.next = @tail
    node
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return
      end
    end

  end

  def each(&blk)
    current = first

    until current == @tail
      blk.call(current)
      current = current.next
    end

    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
