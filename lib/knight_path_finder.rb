require_relative "00_tree_node"

class KnightPathFinder

  MOVE_DIRECTIONS = [[2, -1], [2, 1], [-2, -1], [-2, 1], [1, 2], [-1, 2], [1, -2], [-1, -2]]

  attr_reader :visited_positions

  def initialize(starting_pos=[0,0])
    @starting_pos = starting_pos
    @root_node = PolyTreeNode.new(starting_pos)
    @visited_positions = [starting_pos]
  end

  def valid_pos?(pos)
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def valid_move?(pos)
    return false unless valid_pos?(pos)
    !@visited_positions.include?(pos)
  end

  def new_move_positions(pos)
    new_positions = []
    MOVE_DIRECTIONS.each do |move_adjustment|
      x, y = pos
      x += move_adjustment.first
      y += move_adjustment.last
      potential_new_pos = [x, y]
      new_positions << potential_new_pos if valid_move?(potential_new_pos)
      @visited_positions << potential_new_pos if valid_move?(potential_new_pos)
    end
    new_positions
  end

  def build_move_tree
    node_queue = [@root_node]
    until node_queue.empty?
      parent_node = node_queue.shift
      new_positions = new_move_positions(parent_node.value)
      new_positions.each do | new_pos |
        new_node = PolyTreeNode.new(new_pos)
        new_node.parent=(parent_node)
        node_queue << new_node
      end
    end
    nil
  end

  def find_path(end_pos)
    # return @root_node if @root_node.value == end_pos
    build_move_tree
    trace_back_path(@root_node.dfs(end_pos))
  end

  def trace_back_path(node)
    node_path = [node]
    until node_path.first == @root_node
      next_node = node_path.first.parent
      node_path.unshift(next_node)
    end
    node_path.map { | node | node.value }
  end
end
