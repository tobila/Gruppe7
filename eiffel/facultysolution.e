note
	description: "Summary description for {FACULTYSOLUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FACULTYSOLUTION

create
	make

feature-- dafault Constructor		
	make
		do
		end

feature--set the value faculty
	set_faculty(fac:INTEGER)
		do
			faculty:=fac
		end


feature--var
	faculty: INTEGER

end
