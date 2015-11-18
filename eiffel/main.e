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
			--b: BINARYTREE

		do

			FacultyGPS
			TreeGPS


--			create b.make (50)
--			b.insert (40)
--			b.insert (30)
--			b.insert (60)
--		print(	b.remove (50))

--			if attached b.getroot as x then
--				if attached x.getrightnode as x2 then
--					print(x2.getvalue)
--				end
--			end
--			b.insert (60)
--			b.insert (55)
--			b.insert (53)
--			b.insert (54)

--			if attached b.getroot as x then
--				if attached x.getrightnode as x2 then
--					print(x2.value)
--				end

--			end

--			print("Ist vorhanden: ")

--			print(b.has (50))
--			print("%N")


--			print("Wurde geloescht: ")
--			print(b.remove (50))
--			print("%N")
--			print("Ist vorhanden: ")
--			print(b.has (50))
--			if attached b.getroot as x then
--				if attached x.getrightnode as x2 then
--					if attached x2.getleftnode as x3 then
--						if attached x3.getleftnode as x4 then
--							print(x4.value)
--						end
--					end
--				end
--			end


	end

	feature
		a: ARRAY[INTEGER]
		treeProb: SEARCHTREEPROBLEM
		facultyProb: FACULTYPROBLEM


	feature --Tree General Problem Solver
		TreeGPS
		local
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
				validNumber:=false
			until
				validNumber=true
			loop
				io.read_line
				root:=io.last_string
				if root.is_integer then
					a.force (root.to_integer, 1) -- set root
					validNumber:=true
				else
					print("no vaild input! Enter number: ")
				end
			end

			print("ENTER NODES (to finish enter any letter)")
			io.new_line
			print("Enter first Node: ")
			from
	        	i:=2
	        	node:="0"
	     	until
	     		not node.is_integer
	    	loop
	       		io.read_line
	        	node:=io.last_string
	       		if node.is_integer then
	       			print("Enter next Node: " )
	       			a.force (io.last_string.to_integer, i)
	       			i:=i+1
	       		end
	     	end

			print("ENTER SEARCH ELEMENT: ")
			io.read_integer
			a.force (io.last_integer, i)
			create treeProb.make

			treeProb.set_tree (a)
			print("FIND: ")
			print(treeProb.find)
			io.new_line
			print("TREE CONTAINS FIND? ")
			print(treeProb.solition.get_has)
		end


		feature --Faculty General Problem Solver
			FacultyGPS
			local
				s: STRING
				n: INTEGER
				validNumber: BOOLEAN

			do
				create facultyProb.make
				io.new_line
				io.new_line
				print("ENTER NUMBER FOR FACULTY: ")



				from
					validNumber:=false
				until
					validNumber=true
				loop
					io.read_line
			   		s:=io.last_string
					if s.is_integer then
						n:=s.to_integer
						validNumber:=true
					else
						print("no vaild input! Enter number: ")
					end
				end

				facultyProb.set_n(n)
				print("The result of faculty ")
				print (n)
				print(" is: ")
				print (facultyProb.get_sol.out)

			end


end -- class MAIN
