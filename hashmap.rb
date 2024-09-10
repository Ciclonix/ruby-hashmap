class HashMap
  :attr_reader :capacity

  def initialize
    INITIAL_CAPACITY = @capacity = 16
    LOAD_FACTOR = 0.75
    @buckets = Array.new(INITIAL_CAPACITY)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    return hash_code
  end

  def hash_index(key)
    index = hash(key) % capacity
    raise ArgumentError if index.negative? || index >= capacity
    return index
  end
end
