require_relative "linked_lists"

class HashMap
  attr_reader :capacity, :length

  INITIAL_CAPACITY = 16
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
    @length = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    return hash_code
  end

  def hashIndex(key)
    index = hash(key) % @buckets.length
    raise ArgumentError if index.negative? || index >= @buckets.length
    return index
  end

  def set(key, value)
    if has?(key)
      @buckets[hashIndex(key)].find(key).value = value
    else
      @buckets[hashIndex(key)].append(key, value)
      @length += 1
      if length > @buckets.length * LOAD_FACTOR
        all_entries = entries
        @buckets = Array.new(@buckets.length * 2) { LinkedList.new }
        @length = 0
        all_entries.each { |key, value| set(key, value)}
      end
    end
  end

  def get(key)
    return @buckets[hashIndex(key)].find(key).value
  end

  def has?(key)
    return @buckets[hashIndex(key)].contains?(key)
  end

  def remove(key)
    list = @buckets[hashIndex(key)]
    return nil if list.nil?
    list.remove_at(list.find(key, false))
    @length -= 1
    return list
  end

  def clear
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
    @length = 0
  end

  def items(to_get) # 0 = keys, 1 = values, 2 = both
    items = []
    @buckets.each do |list|
      item = list.getItems(to_get).flatten
      items << item unless item == []
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
    return items(2)
  end
end
