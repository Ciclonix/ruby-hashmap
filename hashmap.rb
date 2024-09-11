require_relative "linked_lists"

class HashMap
  attr_reader :capacity

  INITIAL_CAPACITY = 3
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    return hash_code
  end

  def hashIndex(key)
    index = hash(key) % length
    raise ArgumentError if index.negative? || index >= length
    return index
  end

  def set(key, value)
    @buckets[hashIndex(key)].append(key, value)
  end

  def get(key)
    return @buckets[hashIndex(key)].find(key, true)
  end

  def has?(key)
    return @buckets[hashIndex(key)].contains?(key)
  end

  def remove(key)
    list = @buckets[hashIndex(key)]
    return nil if list.nil?
    list.remove_at(list.find(key))
    return list
  end

  def length
    return @buckets.length
  end

  def clear
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
  end

  def items(to_get) # 0 = keys, 1 = values, 2 = both
    items = []
    @buckets.each do |list|
      items << list.getItems(to_get).flatten
    end
    return items
  end

  def keys
    return items(0).flatten
  end

  def values
    return items(1).flatten
  end

  def entries
    return items(2)[0...-1]
  end
end
