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
	find:INTEGER
	b:detachable BINARYTREE
	root:detachable NODE


feature --redefine solition

	solition: SEARCHTREESOLUTION
		do
			Result:= solution
		end

feature --check_Solvability
	check_Solvability
		do

	if not attached root as rootSafe then

				direcltysolvable.set_item (True)
				solution.set_has (False)
		end
	if attached root as rootSafe then
			if
			rootSafe.getvalue= find
			then
			direcltySolvable.set_item (TRUE)
		 	solution.set_has(True)

		end
	end
end

feature --redefine divide
	divide
	do
	if attached root as rootSafe then
		if
			rootSafe.getvalue > find
		then
			root:=rootSafe.getleftnode
		else
			root:= rootSafe.getrightnode
		end
	 end
	end


feature -- set_tree
	set_tree (numbers:  ARRAYED_LIST[INTEGER])

		local
			i:INTEGER
		do
			create b.make (numbers.first)
			find:=numbers.last

			if attached b as bSafe then

			from
				i:=2

			until
				i < numbers.count
			loop

				bSafe.insert (numbers.array_at (i))
			end

				root:= bSafe.getroot
				direcltysolvable.set_item (FALSE)
				compute_Solution
			end
		end




feature -- get_find

	get_find:INTEGER
		do
			Result:=find
		end

end
