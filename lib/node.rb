class Node
  attr_accessor :prev, :path, :term
  
  # create new node by    node1 = Node.new(node0, "a")
  def initialize(prev, path, term = false)
    @prev = prev
    @path = path
    @term = term
    @children = []
  end
  
  def add_node(path, term = false)
    @children << Node.new(self, path, term)
  end
  
  def each_child
    @children.each do |child|
      child
    end
  end
  
end