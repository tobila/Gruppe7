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
	make (value: STRING)
		do
		 set_tree(value)
		end


feature--variable
	solution:  SEARCHTREESOLUTION
	find:INTEGER
	b:detachable BINARYTREE
	root:detachable NODE
	tree:detachable ARRAYED_LIST[INTEGER]

feature --redefine solition

	solition: SEARCHTREESOLUTION
		do
			Result:= solution
		end

feature --check_Solvability
	check_Solvability
		do

	if not attached root as rootSafe then

				direcltysolvable.set_item (TRUE)
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
	set_tree (numbers: STRING)
		local
			l:LIST[STRING]
			i:INTEGER

			do
				create solution.make
				create tree.make (0)
				if attached tree as treeSafe then
		from

			treeSafe.start

		until

			treeSafe.after

		loop

			l:=	numbers.split (' ')
			treeSafe.put (i.to_integer)


		end
		if attached b as bSafe then
		bSafe.insert (treeSafe.array_item (1))

		from
			i:=2
		until
			i<treeSafe.count -1
		loop
			bSafe.insert(treeSafe.at (i))
			i:=i+1
		end
	root:= bSafe.getroot
	find:= treeSafe.last
	direcltysolvable.set_item (FALSE)
	compute_Solution
	end
end
end


feature -- get_find

	get_find:INTEGER
		do
			Result:=find
		end

end

