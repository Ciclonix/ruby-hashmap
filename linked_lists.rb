# frozen_string_literal: true

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
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

  def append(value)
    if head.nil?
      @head = Node.new(value)
    else
      tail.next_node = Node.new(value)
    end
    @node_num += 1
  end

  def prepend(value)
    @head = Node.new(value, head)
    @node_num += 1
  end

  def size
    return @node_num
  end

  def tail
    return at(size - 1)
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

  def contains?(value)
    node = head
    size.times do
      return true if node.value == value
      node = node.next_node
    end
    return false
  end

  def find(value)
    node = head
    size.times do |idx|
      return idx if node.value == value
      node = node.next_node
    end
    return nil
  end

  def to_s
    string = ""
    node = head
    size.times do
      string += "( #{node.value} ) -> "
      node = node.next_node
    end
    return string += "nil"
  end

  def insert_at(value, index)
    if index.zero?
      prepend(value)
    else
      node_pre = at(index - 1)
      node_pre.next_node = Node.new(value, node_pre.next_node)
      @node_num += 1
    end
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
end
