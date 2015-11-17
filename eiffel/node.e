class
	NODE

create
	make

feature

	make (local_value: INTEGER_32; local_parent: detachable NODE)
		do
			value := local_value
			Current.setparent (local_parent)
		end

feature --methods for value

	getvalue: INTEGER_32
		do
			Result := value
		end


feature --methods for parent node

	getparent: detachable NODE
		do
			Result := parent
		end

	setparent (newparent: detachable NODE)
		do
			parent := newparent
		end

feature --methods for left node

	getleftnode: detachable NODE
		do
			Result := left
		end

	setleftnode (localvalue: INTEGER_32)
		local
			newnode: NODE
		do
			create newnode.make (localvalue, Current)
			left := newnode
		end

	setNewLeftNode(newNode: detachable NODE)
		do
			left:=newNode
		end

feature --methods for right node

	getrightnode: detachable NODE
		do
			Result := right
		end

	setrightnode (localvalue: INTEGER_32)
		local
			newnode: NODE
		do
			create newnode.make (localvalue, Current)
			right := newnode
		end

	setNewRightNode(newNode: detachable NODE)
		do
			right:=newNode
		end

feature --attributes

	value: INTEGER_32

	parent: detachable NODE

	left: detachable NODE

	right: detachable NODE

end -- class NODE

