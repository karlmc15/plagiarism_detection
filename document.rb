class Document
  attr_accessor :text

  def initialize(text = "")
    @text = text
  end
  
  def import(filename)
    if File.new(filename)
      @text = ""
      File.new(filename, "r").each do |line|
        @text += line
      end
      @text
    else
      false
    end
  end
  
  def compress
    # convert string to array of characters and eliminate whitespace
    text.chars.to_a.collect{|x| x unless x.strip == ""}.compact
  end
  
  def compare(doc2)
    build_graph(self.compress, doc2.compress)
  end

  private
    def build_graph(text1, text2)
      # Define Costs
      del = 1
      ins = 1
      
      m = text1.length
      n = text2.length
      
      #graph = Array.new(text1.length+1, Array.new(text2.length+1))
      graph = Array.new(text1.length+1)
      (0..graph.length-1).each do |i|
        graph[i] = Array.new(text2.length+1)
      end
      
      graph[-1][-1] = 0   # ruby refers to the last element of the array when referencing -1
      
      (0..m-1).each do |i|
        graph[i][-1] = graph[i-1][-1] + del
      end
        
      (0..n-1).each do |j|
        graph[-1][j] = graph[-1][j-1] + ins
        (0..m-1).each do |i|
          graph[i][j] = [graph[i-1][j-1]+sub(text1[i], text2[j]), graph[i-1][j]+del, graph[i][j-1]+ins].min
        end
      end
      return graph[m-1][n-1]
    end
    
    def sub(a, b)
      a == b ? 0 : 3
    end
end
