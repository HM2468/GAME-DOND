# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
#require 'sinatra'		

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/dond_gen"

# Main program
module DOND_Game
	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	playing = true
	input = ""
	menu = ""
	guess = ""
	box = 0
	turn = 0
	win = 0
	deal = 0		
	if g.begining == "1"			
		# Any code added to command line game should be added below.
		openboxes = Proc.new{
			g.displayselectboxprompt_better            #输入要选择打开的盒子序号，储存在@selectedbox
			selectedbox = g.getselectedbox			   #读取@selectedbox
			selectboxamount = g.openbox(selectedbox)   #打开这个盒子并得到其中的数值
			g.removeamount(selectboxamount)            #将该数值从大屏幕上去掉
			@output.puts "Amounts left:"
			g.showamounts_better
			@output.puts 
			@output.puts "Box Status:"
			g.showboxes_better 	
			@output.puts 
			@output.puts "Boxes left:"
			g.leftboxes
		}

		dealornot = Proc.new{
			bankeroffer = g.bankercalcsvalue_better			
			@output.puts "The banker offered you ￡#{bankeroffer}"
			@output.puts "Deal or No deal?"
			@output.puts "---------------------------"
			@output.puts "Enter 1.DEAL or 2.NO DEAL."
			@output.puts "---------------------------"
			while 1
				decision = @input.gets.chomp
				if decision == "1"
					@output.puts "You won ￡#{bankeroffer}."
					g.finish
					exit
				elsif decision == "2"
					break
				else
					@output.puts "Invalid input! Enter again."
					next
				end
			end
		}
		g.start				
		g.created_by
		g.student_id
		g.resetgame
		g.assignvaluestoboxes 	             #随机排列value array
		g.displaychosenboxprompt_better      #键入自己保留的盒子
		g.displaychosenbox                   #显示自己保留的盒子号码	 

		TurnArray = [5,3,3,3,3,3]
		TurnArray.each{|x| 
			@output.puts
			@output.puts "====================================="
			@output.puts "Now select #{x} boxes in this turn."
			@output.puts "====================================="
			@output.puts
			i = 1
			while(i<=x) do 
				i += 1
				openboxes.call
			end
			dealornot.call
		}
			
			@output.puts "Do you want a swap?"
			@output.puts "---------------------"
			@output.puts "Enter 1.YES or 2.NO "
			@output.puts "---------------------"

			swapornot = @input.gets.chomp
			while 1
				if swapornot == "1"
					finalboxvalue = g.getfinalvalue
					@output.puts "You won ￡#{finalboxvalue}."
					g.finish
					exit
				elsif swapornot == "2"
					chosenvalue = g.getchosenvalue
					@output.puts "You won ￡#{chosenvalue}."
					g.finish
					exit
				else
					@output.puts "Invalid input! Enter again."
					next
				end
			end		
		# Any code added to command line game should be added above.
	
		exit	# Does not allow command-line game to run code below relating to web-based version
	end
end
# End modules

# Sinatra routes

	# Any code added to web-based game should be added below.



	# Any code added to web-based game should be added above.

# End program