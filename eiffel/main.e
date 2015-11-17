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
			n:INTEGER

		do
			create a.make_empty
			a.force (3, 1)
			a.force (5, 2)
			a.force (2, 3)
			a.force (7, 4)
			a.force (50, 5)

			create prob.make

			prob.set_tree (a)
			print("FIND: ")
			print(prob.find)
			io.new_line
			print("TREE CONTAINS FIND? ")
			print(prob.solition.get_has)
io.new_line
			create Facultyprob.make
			n:=5
			Print("Test")
io.new_line
			Facultyprob.set_n(n)
			Print("The result of faculty ")
			Print (n)
			Print(" is: ")
			Print (Facultyprob.get_sol.out)


--
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
		prob: SEARCHTREEPROBLEM

		Facultyprob:FACULTYPROBLEM

end

 -- class MAIN

