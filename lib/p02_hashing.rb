class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_number = 0

    each_with_index do |el, i|
      hash_number += el.hash ^ i
    end

    hash_number.hash
  end
end

class String
  def hash
    split("").map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # 0
    result = 0
    sort.each do |key, value|
      result += key.hash ^ value.hash
    end
    result
  end
end
