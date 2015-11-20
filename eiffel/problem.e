note
	description: "Summary description for {PROBLEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class PROBLEM [P]

feature -- variable directlySolvable

	 direcltySolvable: BOOLEAN



feature --check_Solvability, divide ,compute_Solution
	check_Solvability
	do
	end

	divide
	do
	end

	set_direcltySolvable(b:BOOLEAN)-- returns the value directlySolvable
	do
		direcltySolvable:=b
	end


	compute_Solution -- breaks when directlySolvable is true -> Solution is found, is solution not jet found method check_solvability and divide is called
		local break:BOOLEAN
			do

				from
					break:= False
				until
					break=True
				loop

					check_Solvability
				if
					direcltySolvable= True
				then
					break:=True
				end
				divide
			end
		end
	end
