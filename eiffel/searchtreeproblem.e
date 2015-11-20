note
	description: "Summary description for {SEARCHTREEPROBLEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCHTREEPROBLEM inherit
		PROBLEM[SEARCHTREESOLUTION]
		redefine
			 check_Solvability, divide end
		SOLUTION[SEARCHTREESOLUTION]
		redefine
			solition end


create
	make

feature-- Constructor
	make
		do
			create solution.make
		end


feature--variable
	solution:  SEARCHTREESOLUTION
	find:INTEGER_32
	b:detachable BINARYTREE
	root:detachable NODE


feature --redefine solition
	solition: SEARCHTREESOLUTION -- return solution
		do
			Result:= solution
		end

feature --check_Solvability
	check_Solvability --compares the value with the search value
		do
			if not attached root as rootSafe then

				direcltysolvable:=True
				solution.set_has (False)
			end
			if attached root as rootSafe then
				if rootSafe.getvalue= find then
					direcltySolvable:=True
		 			solution.set_has(True)
				end
			end
		end

feature --redefine divide
	divide -- goes one step down the tree
	do
		if attached root as rootSafe then
			if rootSafe.getvalue > find then
				root:=rootSafe.getleftnode
			else
				root:= rootSafe.getrightnode
			end
		end
	end


feature -- set_tree
	set_tree (numbers:  ARRAY[INTEGER]) --creates the Binarytree first index is the root last index is the search value

		local
			i:INTEGER
		do
			create b.make (numbers[1])
			find:=numbers[numbers.count]

			if attached b as bSafe then

				from
					i:=2

				until
					i >= numbers.count
				loop

					bSafe.insert (numbers[i])
					i:=i+1
				end

				root:= bSafe.getroot
				direcltysolvable.set_item (FALSE)
				compute_Solution
			end
		end




feature -- get_find returns the value find

	get_find:INTEGER
		do
			Result:=find
		end

end
