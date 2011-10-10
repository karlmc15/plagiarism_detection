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
  
  def to_s
    @text
  end
end
