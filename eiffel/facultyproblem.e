note
	description: "Summary description for {FACULTYPROBLEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FACULTYPROBLEM  inherit
		PROBLEM[FACULTYSOLUTION]
		redefine
			 check_Solvability, divide end
		SOLUTION[FACULTYSOLUTION]
		redefine
			solition end

create
	make

feature--Constructor
	make
		do
			create solution.make
		end

feature--variable
	solution: FACULTYSOLUTION
	n, sol:INTEGER_32

feature --redefine solition

	solition: FACULTYSOLUTION -- return the solution
		do
			Result:= solution
		end


feature --check_Solvability

	check_Solvability --
	do
		if n=0 OR n=1 then	-- when the value is 0 or 1 the solution is found
			direcltysolvable:=True
			solution.set_faculty (1)
		end
	end
feature --redefine divide
	divide --create the solution
		do
			sol:=n*sol
			n:=n-1
		end

feature --get_sol
	get_sol: INTEGER
		do
			Result:= sol
		end


feature --get_n
	get_n: INTEGER
		do
			Result:=n
		end

feature --set_n
	set_n(i:INTEGER)-- set the value n
		do
			n:=i-1
			sol:=i
			direcltysolvable:=False
			compute_Solution

		end

end
