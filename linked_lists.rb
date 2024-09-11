# frozen_string_literal: true

class Node
  attr_accessor :key, :value, :next_node

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end


class LinkedList
  attr_reader :head

  def initialize
    @head = nil
    @node_num = 0
  end

  def append(key, value)
    if head.nil?
      @head = Node.new(key, value)
    else
      at(size - 1).next_node = Node.new(key, value)
    end
    @node_num += 1
  end

  def prepend(key, value)
    @head = Node.new(key, value, head)
    @node_num += 1
  end

  def size
    return @node_num
  end

  def at(index)
    node = head
    index.times do
      break if node.nil?

      node = node.next_node
    end
    return node
  end

  def pop
    at(size - 2).next_node = nil
    @node_num -= 1
  end

  def contains?(key)
    node = head
    size.times do
      return true if node.key == key

      node = node.next_node
    end
    return false
  end

  def find(key, return_node = true)
    node = head
    size.times do |idx|
      if node.key == key
        return return_node ? node : idx
      end

      node = node.next_node
    end
    return nil
  end

  def remove_at(index)
    case index
    when size - 1
      pop
    when 0
      @head = head.next_node
      @node_num -= 1
    when 0..(size - 1)
      node_pre = at(index - 1)
      node_pre.next_node = node_pre.next_node.next_node
      @node_num -= 1
    end
  end

  def getItems(to_get) # 0 = keys, 1 = values, 2 = both
    items = []
    node = head
    loop do
      return items if node.nil?

      items <<  case to_get
                when 0
                  node.key
                when 1
                  node.value
                when 2
                  [node.key, node.value]
                end
      node = node.next_node
    end
  end
end
