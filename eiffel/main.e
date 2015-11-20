note
	description: "BinaryTree application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN

inherit
	ARGUMENTS

create
	make

feature {NONE}
--commentar
	make
		local
			b: BINARYTREE

		do

			FacultyGPS
			TreeGPS


			create b.make (50)
			b.insert (60)
			b.insert (53)
			b.insert (55)
			b.insert (57)
			b.insert (56)

			b.insert (70)

			print(b.has (60))
			print(	b.remove (60))
			print(b.has (60))



	end


feature --Tree General Problem Solver
	TreeGPS
	local
		a: ARRAY[INTEGER]
		treeProb: SEARCHTREEPROBLEM
		i: INTEGER
		root: STRING
		node: STRING
		validNumber: BOOLEAN
	do
		create a.make_empty
		io.new_line
		io.new_line
		print("***CREATE NEW BINARYTREE***")
		io.new_line
		print("ENTER ROOT: ")

		from
			validNumber:=false	-- loop while last_string is no valid number
		until
			validNumber=true
		loop
			io.read_line	-- read user input as string
			root:=io.last_string
			if root.is_integer then
				a.force (root.to_integer, 1) -- set root if valid number
				validNumber:=true
			else
				print("no vaild input! Enter number: ")
			end
		end

		print("ENTER NODES (to finish enter any letter)")
		io.new_line		-- read user input as string
		print("Enter first Node: ")
		from	-- loop while user enter any letter
        	i:=2
        	node:="0"
     	until
     		not node.is_integer
    	loop
       		io.read_line
        	node:=io.last_string
       		if node.is_integer then
       			print("Enter next Node: " )
       			a.force (io.last_string.to_integer, i) -- set nodes
       			i:=i+1
       		end
     	end

		print("ENTER SEARCH ELEMENT: ")
		io.read_integer
		a.force (io.last_integer, i)	-- set searchelement
		create treeProb.make

		treeProb.set_tree (a)	-- set tree to problemsolution
		print("FIND: ")
		print(treeProb.find)
		io.new_line
		print("TREE CONTAINS FIND? ")
		print(treeProb.solition.get_has)	-- print solution
		io.new_line
	end


feature --Faculty General Problem Solver
	FacultyGPS
	local
		facultyProb: FACULTYPROBLEM
		s: STRING
		n: INTEGER
		validNumber: BOOLEAN

	do
		create facultyProb.make
		io.new_line
		io.new_line
		print("ENTER NUMBER FOR FACULTY: ")



		from	-- loop while input is a valid number
			validNumber:=false
		until
			validNumber=true
		loop
			io.read_line
	   		s:=io.last_string
			if s.is_integer then
				n:=s.to_integer -- set faculty n
				validNumber:=true
			else
				print("no vaild input! Enter number: ")
			end
		end

		facultyProb.set_n(n) -- set faculty in problemsolver
		print("The result of faculty ")
		print (n)
		print(" is: ")
		print (facultyProb.get_sol.out) -- get solution

	end


end -- class MAIN
