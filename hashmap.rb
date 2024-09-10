require_relative "linked_lists"

class HashMap
  attr_reader :capacity

  INITIAL_CAPACITY = 3
  LOAD_FACTOR = 0.75

  def initialize
    @capacity = INITIAL_CAPACITY
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    return hash_code
  end

  def hashIndex(key)
    index = hash(key) % capacity
    raise ArgumentError if index.negative? || index >= capacity
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
end
