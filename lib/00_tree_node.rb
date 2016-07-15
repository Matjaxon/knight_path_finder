require "byebug"

class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def inspect
    @value.inspect
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent= self
  end

  def remove_child(child)
    @children.include?(child) ? @children.delete(child) : raise("fail")
    child.parent= nil
  end

  def dfs(target_value)
    return self if target_value == value
    children.each do | child |
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      first_el = queue.shift
      return first_el if first_el.value == target_value
      first_el.children.each do | child |
        queue << child
      end
    end
    nil
  end

end
