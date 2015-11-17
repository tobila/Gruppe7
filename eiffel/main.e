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

			TreeGPS
			FacultyGPS

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
		do
			create a.make_empty
			print("***CREATE NEW BINARYTREE***")
			io.new_line
			print("ENTER ROOT: ")
			io.read_integer
			a.force (io.last_integer, 1) --root
			print("ENTER NODES (to finish enter 'X'): ")
			from
	        	io.read_line
	        	i:=2
	     	until
	     		--io.last_string.as_upper = 'X'
	     		i>=5
	    	loop
	       		io.read_line
	       		a.force (io.last_string.to_integer, i)
	       		i:=i+1
	     	end -- user has typed the character 'x' or 'X'

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
				n: INTEGER
			do
				create facultyProb.make
				io.new_line
				io.new_line
				print("ENTER NUMBER FOR FACULTY: ")
				io.read_integer
				n:=io.last_integer
				facultyProb.set_n(n)
				print("The result of faculty ")
				print (n)
				print(" is: ")
				print (facultyProb.get_sol.out)
			end


end -- class MAIN
