note
	description: "Summary description for {SEARCHTREESOLUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCHTREESOLUTION
create
	make

feature --default constructor
make

	do

	end

feature -- set_has to set the value has
	set_has(h:BOOLEAN )
	do has:=h end

	searchtree_Solution
	do

	end
feature --get_has returns the value has
	get_has: BOOLEAN
		do
			Result:=has;
		end

feature --variable
	has: BOOLEAN

end
