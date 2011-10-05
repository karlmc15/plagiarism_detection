class Document
  attr_accessor :text

  def initialize(text)
    @text = text
  end
  
  def compare(text2)
    
    # convert string to array of characters
    text_array = text.chars.to_a
    text2_array = text2.chars.to_a
    
    # eliminate whitespace
    text_array = text_array.chars.to_a.collect{|x| x unless x.strip == ""}.compact
    text2_array = text2_array.chars.to_a.collect{|x| x unless x.strip == ""}.compact
    
    build_graph(text_array, text2_array)
  end

  private
    def build_graph(text1, text2)
      # Define Costs
      sub = 3
      del = 1
      ins = 1
      
      m = text1.length
      n = text2.length
      graph = Array.new(text1.length+1, Array.new(text2.length+1))
      graph[-1][-1] = 0   # ruby refers to the last element of the array when referencing -1
      
      (0..m-1).each do |i|
        graph[i][-1] = graph[i-1][-1] + del
      end
        
      (0..n-1).each do |j|
        graph[-1][j] = graph[-1][j-1] + ins
        (0..m-1).each do |i|
          graph[i][j] = [graph[i-1][j-1]+sub, graph[i-1][j]+del, graph[i][j-1]+ins].min
        end
      end
      graph[m-1][n-1]
    end
end
