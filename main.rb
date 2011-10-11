require File.expand_path('../lib/algorithm', __FILE__)
require File.expand_path('../lib/document', __FILE__)
require File.expand_path('../lib/helpers', __FILE__)
require 'rubygems'
require 'highline/import'

@doc1 = Document.new
@doc2 = Document.new
@trie = Trie.new
continue = true
skip = false

Screen.clear
print "****************************************\n"
print " Welcome to PDA, PlagerismDetectionAtor\n"
print "****************************************\n\n"

#name = ask("Please tell me your name") { |q| q.validate = /.+/ }
#print "\nThank you #{name}, let's begin...\n\n"
#sleep 2
Screen.clear

while continue do
  print "*************************\n*****   Main Menu   *****\n*************************\n\n"
  choose do |menu|
    menu.prompt = "Please choose an option: "

    menu.choice("Input document as text") do
      Screen.clear
      print "Main Menu >> Import document as text\n\n"
      
      choose do |submenu|
        submenu.prompt = "Please choose an option: "
        submenu.choice("Edit document 1") { @doc1.text = ask "Input text for document 1: "; say "Docment 1 updated!"}
        submenu.choice("Edit document 2") { @doc2.text = ask "Input text for document 2: "; say "Docment 2 updated!"}
        submenu.choice("Back to main menu") {skip=true}
      end
    end
    menu.choice("Import document from file") do
      Screen.clear
      print "Main Menu >> Import document from file\n\n"
      
      choose do |submenu|
        submenu.prompt = "Please choose an option: "
        submenu.choice("Import document 1") do 
          filename = ask "Input filepath: "
          @doc1.import(filename)
          say "Docment 1 imported!"
        end
        submenu.choice("Import document 2") do
          filename = ask "Input filepath: "
          @doc2.import(filename)
          say "Docment 2 imported!"
        end
        submenu.choice("Back to main menu") {skip=true}
      end
    end
    menu.choice("View Documents") do
      Screen.clear
      print "**** Document 1: \n\n#{@doc1}"
      print "\n\n\n**** Document 2: \n\n#{@doc2}"
    end
    menu.choice("Run Algorithms") do
      Screen.clear
      print "Main Menu >> Run Algorithms\n\n"
      
      choose do |submenu|
        submenu.prompt = "Please choose an option: "
        submenu.choice("Generic-DP") { print "\n\nCalculating...\n\n"; print "The result is: #{Algorithm.generic_dp(@doc1, @doc2)}"}
        submenu.choice("LCS-Simple") { print "\n\nCalculating...\n\n"; print "The result is: #{Algorithm.lcs_simple(@doc1, @doc2)}"}
        submenu.choice("LCS-Column") { print "\n\nCalculating...\n\n"; print "The result is: #{Algorithm.lcs_column(@doc1, @doc2)}"}
        submenu.choice("Back to main menu") {skip=true}
      end
    end
    menu.choice(:quit) { print "\n\nGoodbye!"; continue=false}
  end
  
  
  if skip
    skip = false
  elsif continue
    print "\n\n"
    ask "Press Enter to return to menu"
  else
    sleep 1
  end
  Screen.clear
end

