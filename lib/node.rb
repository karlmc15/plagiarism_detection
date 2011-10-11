class Node
  attr_accessor :term, :children
  
  def initialize(parent, term = false)
    @parent = parent        # Parent node
    @term = term            # Terminal state?
    @children = Hash.new    # Hash of all the children
  end
  
  def add_node(path, term)
    if children.has_key? path
      # if this is the last character of the array, set node as terminal state
      children[path].term = term
    else
      # Create a new node if one doesn't already exisit
      children[path] = Node.new(self, term)    
    end
    
    # Return child node
    return children[path]
  end
  
  def all_children
    children.each_key.to_a
  end
  
  def get_child(c)
    children[c]
  end
  
  def map_children
    children.map { |path, node| [path] + node.map_children }
  end
  
end