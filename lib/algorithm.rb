module Algorithm
  require File.expand_path('../document', __FILE__)

  def self.generic_dp(x, y)
    del = 1
    ins = 1
    subsame = 0
    subdiff = 3
    
    x = checkformat x
    y = checkformat y
    
    m = x.length
    n = y.length
    
    graph = init_graph(m, n)
    
    graph[-1][-1] = 0   # ruby refers to the last element of the array when referencing -1
    
    (0..m-1).each do |i|
      graph[i][-1] = graph[i-1][-1] + del
    end
      
    (0..n-1).each do |j|
      graph[-1][j] = graph[-1][j-1] + ins
      (0..m-1).each do |i|
        graph[i][j] = [graph[i-1][j-1]+(x[i] == y[j] ? subsame : subdiff), graph[i-1][j]+del, graph[i][j-1]+ins].min
      end
    end
    dsubs graph
  end
  
  def self.lcs_simple(x, y)
    x = checkformat x
    y = checkformat y
    m = x.length
    n = y.length
    
    graph = init_graph(m, n)
    
    (-1..m-1).each do |i|
      graph[i][-1] = 0
    end
      
    (0..n-1).each do |j|
      graph[-1][j] = 0
      (0..m-1).each do |i|
        graph[i][j] = (x[i] == y[j]) ? graph[i-1][j-1]+1 : [graph[i-1][j], graph[i][j-1]].max
      end
    end
    dsubs graph

     (0..n-1).each do |j|
      (0..m-1).each do |i|
        print "\t", graph[i][j]
      end
	print "\n"
    end
  end
  
  def self.lcs_noSub(x, y)
    x = checkformat x
    y = checkformat y
    m = x.length+1
    n = y.length+1
    
    graph = init_graph(m, n)
    
    (0..m-1).each do |i|
      graph[i][-1] = 0
    end
      
    (0..n-1).each do |j|
      graph[0][j] = j
    end
    (0..m-1).each do |i|
      graph[i][0] = i
    end

    (1..n-1).each do |j|
      (1..m-1).each do |i|
       graph[i][j] = (x[i-1] == y[j-1]) ? graph[i-1][j-1] : [graph[i-1][j]+1, graph[i][j-1]+1].min
      end
    end
    dsubs graph

    print "\t\t"
    (0..n-2).each do |j|
      print x[j], "\t"
    end
    print "\n"
    (0..n-1).each do |j|
      (0..m-1).each do |i|
        if (i==0 && j==0)
          print "\t"
        end
	if (i==0 && j>0) 
	  print y[j-1], "\t"
        end
          print graph[i][j], "\t"
      end
	print "\n"
    end
    print "\n"
    return graph[x.length-1][y.length-1]
  end

  def self.lcs_column(x, y)
    x = checkformat x
    y = checkformat y
    m = x.length
    n = y.length
    
    c1 = Array.new(m)
    c2 = Array.new(n)
    
    (-1..m-1).each do |i|
      c1[i] = 0
    end
    
    (0..n-1).each do |j|
      c2[-1] = 0
      (0..m-1).each do |i|
        if x[i] = y[j]
          c2[i] = c1[i-1]+1
        else
          c2[i] = [c1[i], c2[i-1]].max
        end
      end
      c1 = c2
    end
    return c1
  end
    
  private
  
    def self.init_graph(m, n)
      graph = Array.new(m+1)
      (0..m).each do |i| # has to be graph.length-1 so m is correct
        graph[i] = Array.new(n+1)
      end
      return graph
    end
    
    def self.dsubs(graph)
      graph[graph.length-2][graph.first.length-2]
    end
    
    def self.checkformat(text)
      if text.class == Document
        return text.compress
      elsif text.class == String
        text = Document.new(text)
        return text.compress
      elsif text.class == Array
        return text
      end
    end

  

end
