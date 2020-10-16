# Ruby code file - All your code should be located between the comments provided.

# Main class module
module DOND_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	GOES = 5

	class Game
		attr_reader :sequence, :selectedboxes, :openedboxes, :chosenbox, :selectedbox, :turn, :input, :output, :winner, :played, :wins, :losses, :guess, :values, :amounts
		attr_writer :sequence, :selectedboxes, :openedboxes, :chosenbox, :selectedbox, :turn, :input, :output, :winner, :played, :wins, :losses, :guess, :values, :amounts

		def initialize(input, output)
			@input = input
			@output = output
		end
		
		def getinput
			@input.gets.chomp.upcase
		end
		
		def storeguess(guess)
			if guess != ""
				@selectedboxes = @selectedboxes.to_a.push "#{guess}"
			end
		end
		
		# Any code/methods aimed at passing the RSpect tests should be added below.
		def begining
			@output.puts "-----------------------------------------------------------------------"
			@output.puts "Enter 1. runs game in command-line window or 2. runs it in web browser."
			@output.puts "-----------------------------------------------------------------------"
			flag = 0
			while flag == 0
				game = @input.gets.chomp
				if game == "1"
					@output.puts "\nCommand line game.\n"
					return game
				elsif game == "2"
					@output.puts "\nWeb-based game.\n"
					return game
				else
					@output.puts "\nInvalid input! Enter again.\n"
					next
				end
			end
		end

	    def start
			@output.puts("Welcome to Deal or No Deal!")
			@output.puts("Designed by: #{created_by}")
			@output.puts("StudentID: #{student_id}")
			@output.puts("Starting game...")
		end
		
		def created_by
			studentname = "Mou Danping"
			return studentname
		end
		
		def student_id
			studentid = "51989963"
			return studentid
		end
		
		def displaymenu
			@output.puts("Menu: (1) Play | (2) New | (3) Analysis | (9) Exit")
		end
		
		def resetgame
			@output.puts("New game...")
			@sequence = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
			@selectedboxes = []
			@openedboxes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
			@chosenbox = 0
			@selectedbox = 0
			@turn = 0
			@winner = 0
			@played = 0
			@wins = 0
			@losses = 0
			@guess = ""
			@values = [0.01,0.10,0.50,1.00,5.00,10.00,50.00,100.00,250.00,500.00,750.00,1000.00,3000.00,5000.00,10000.00,15000.00,20000.00,35000.00,50000.00,75000.00,100000.00,250000.00]
			@amounts = @values
		end

	
		
		def assignvaluestoboxes
			@sequence = @values.shuffle
		end
		

		def showboxes
			for i in (0..21) do
					s = "_"
					g = "_"
					b = i + 1
					if @openedboxes[i] == 0
						s = "Closed"
						g = "[#{b}]"
					if  b == @chosenbox
						g = "*#{b}*"
						end		
					else
						s = "Opened"
						g = "|#{b}|"
					end
					@output.print("#{g} ")					
			end
		end

		def showboxes_better
			for i in (0..21) do
					s = "_"
					g = "_"
					b = i + 1
					if @openedboxes[i] == 0
						s = "Closed"
						g = "[#{s}]"
					if  b == @chosenbox
						g = "*#{b}*\t"
						end		
					else
						s = "Opened"
						g = "|#{s}|"
					end
					if i%5 == 0
						@output.print("\n")
					end
					@output.print("Box#{i+1}:\t#{g}\t")					
			end
			@output.print("\n")
		end
		
		
		def showamounts
		col1 = 0
		col2 = 11
			for i in (0..10)
				c1 = @amounts[col1 + i]
				c2 = @amounts[col2 + i]
				@output.puts("#{c1}   #{c2}")
			end
		end

		def showamounts_better
			@output.puts("------------------")
			col1 = 0
			col2 = 11
			for i in (0..10)
				c1 = @amounts[col1 + i].to_s
				c2 = @amounts[col2 + i].to_s
				@output.puts("#{c1}\t|#{c2}")
			end
			@output.puts("------------------")
		end		

		
		def removeamount(value)
			index = @amounts.find_index(value)
			@amounts[index] = "    "
		end
		
		def setchosenbox(b)
			@chosenbox = b
		end

		def getselectedbox
			@selectedbox
		end
		
		def getchosenbox
			@chosenbox
		end

		def getchosenvalue
			@sequence[@chosenbox-1]
		end		

		
		def getfinalvalue
			temp = 0
			index = @openedboxes.find_index(temp)
			@output.puts "====#{index}===="
			@sequence[index]           
		end	

		def displaychosenbox
			@output.puts("Chosen box: [#{getchosenbox}]")
		end
		
		def displaychosenboxvalue
			@output.puts("Chosen box: [#{getchosenbox}] contains: #{@sequence[@chosenbox-1]}")
		end
		
		def displaychosenboxprompt
			@output.puts("Enter the number of the box you wish to keep.")
			temp = gets.chomp.to_i	
			if temp>=1 && temp<=22  && temp != @chosenbox
				@chosenbox = temp
			else
				displaychosenboxerror
			end
		end

		def displaychosenboxprompt_better
			@output.puts("---------------------------------------------")
			@output.puts("Enter the number of the box you wish to keep.")
			@output.puts("---------------------------------------------")
			flag = 0
			while flag == 0
				temp = gets.chomp.to_i	
				if temp>=1 && temp<=22 
					@chosenbox = temp
					flag = 1
				else
					@output.puts("Invalid boxNo. Enter again.")
					next
				end
			end
		end
		
		def displaychosenboxerror
			@output.puts("Error: Box number must be 1 to 22.")
		end
		
		def displayanalysis
			@output.puts("Game analysis...")
				for i in (0..21) do
					s = "_"
					g = "_"
					b = i + 1
					if @openedboxes[i] == 0
						s = "Closed"
						g = "[#{b}]"
					else
						s = "Opened"
						g = "|#{b}|"
					end
				@output.puts("#{g} Status: #{s}")
				end
		end
		
		def boxvalid(i)
			guess = i.to_i
			if guess > 0 && guess <= 22
				valid = 0
			else
				valid = 1
			end
			return valid
		end
		
		def boxvalid_better(boxNo)
			temp = boxNo.to_i
			if temp > 0 && temp <= 22
				if temp == @chosenbox || @selectedboxes.index(temp)
					valid = 0
				else 
					valid = 1
				end
			else
				valid = 0
			end
			return valid
		end

		def showboxesselected
			@output.puts("Log: #{selectedboxes.inspect}")
		end
		

		def displayselectboxprompt_better
			@output.puts "---------------------------------------------"
			@output.puts("Enter the number of the box you wish to open:")	
			@output.puts "---------------------------------------------"
			flag = 0
			while flag == 0
				temp = gets.chomp.to_i	
				checkvalid = boxvalid_better(temp)
				if checkvalid == 1
					@selectedbox = temp
					flag = 1
				else
					@output.puts("Invalid box selected! Enter again!")
					next
				end
			end
		end


		
		def openbox(boxNo)
			temp = boxNo.to_i
			@openedboxes[temp-1] = 1   
			@selectedboxes.push(temp)
			revealed = @sequence[temp-1]
			return revealed.to_f.round(2)
		end

		def leftboxes
			allboxNo = [] 
			selectedboxes = @selectedboxes
			leftboxes = []
			for i in (0..21)
				allboxNo[i] = i+1
			end
			selectedboxes.push(@chosenbox)
			leftboxes = allboxNo - selectedboxes
			@output.puts
			@output.print(leftboxes)
			@output.puts
			@output.puts
		end

		def bankerphoneswithvalue(offer)
			@output.puts("Banker offers you for your chosen box: #{offer}")
		end
		

		def bankercalcsvalue_better
			temp = []
			calculate = []
			count = @selectedboxes.length
			for i in (0...count) do
				temp[i] = @sequence[@selectedboxes[i]-1]
			end
			calculate = @sequence - temp
			average = calculate.sum/calculate.length
			average *= 1.1
			average.round(0)
		end
		
		def numberofboxesclosed
			num = "Placeholder"
			num = @openedboxes.count(0).to_i
		end
		
		def incrementturn
			@turn += 1
		end
		
		def getturnsleft
			turnsleft = "Placeholder"
			turnsleft = GOES - @turn
		end
		
		def finish
			@output.puts("... game finished.")
		end
		
		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end


