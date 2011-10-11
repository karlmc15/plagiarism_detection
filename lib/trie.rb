class Trie
  require File.expand_path('../node', __FILE__)
  require File.expand_path('../document', __FILE__)
  
  def initialize
    @root = Node.new(nil)
  end
  
  # Inserts a string into the current trie
  def insert(doc)
    current = @root
    array = doc.compress      # convert document text into array and strip whitespace
    term = array.length - 1   # position of terminal state
    i = 0
    
    array.each do |c|
      current = current.add_node(c, i==term) # pass true as terminal state when i == term
      i += 1
    end
  end
  
  # Searches through the current trie for a given string
  def search(doc)
    current = @root
    array = doc.compress      # convert document text into array and strip whitespace
    last = array.length - 1   # last position of array
    i = 0
    
    array.each do |c|
      current = current.get_child(c)
      return false if current.nil?                  # return false if you reach the end of the trie
      return true if (current.term && i==last)      # return true if you have reached a terminal state and the end of the string
      i += 1
    end
    
    return false    # return false because the string wasn't found in the trie'
  end
end