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


--do
--create list.make
--create prob.make

--list.put_i_th (4, 1)
--list.put_i_th (3, 2)
--list.put_i_th (8, 3)
--list.put_i_th (2, 4)
--list.put_i_th (1, 5)



--prob.set_tree (list)
--		print (list.first.out)
--		print (list.last.out)

	--	print (prob.solition.get_has.out)
	end


feature-- var

	--	prob:  SEARCHTREEPROBLEM
		list:  ARRAYED_LIST[INTEGER]




	--	local
	--		b: BINARYTREE

	--	do
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

 -- class MAIN

