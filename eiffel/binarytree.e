note
	description: "Summary description for {BINARYTREE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARYTREE
--	inherit CONTAINER[INTEGER]
--		redefine is_empty, linear_representation end

create
	make

feature --Constructor
--commentar
	make (localvalue: INTEGER_32)
		do
			create root.make (localvalue, Void)

			ensure
				current.getroot/=void
				current.has (localValue)
		end


feature --insert

	insert (localvalue: INTEGER_32)							--create a node with the given parameter as value	
		require
			NOT has(localvalue)								--no duplicated values
		local
			currentnode: detachable NODE
			prevnode: detachable NODE
			issmaller: BOOLEAN
		do
			if root=VOID then								--if there is no root, a node with the wanted value is created and sat as the new root
				create currentNode.make (localvalue, void)
				current.setroot (currentNode)
			else
				prevnode := Current.root
				from
					currentnode := prevnode
				until
					currentnode = Void
				loop
					if (localvalue < currentnode.getvalue) then	--searching the right posiion in the actual tree
						prevnode := currentnode
						currentnode := currentnode.getleftnode
						issmaller := True
					elseif (localvalue > currentnode.getvalue) then
						prevnode := currentnode
						currentnode := currentnode.getrightnode
						issmaller := False
					end
				end


				if (issmaller) then								--is the new node smaller or bigger than its parent
					if attached prevnode as prevnodesafe then
						prevnodesafe.setleftnode (localvalue)
					end

				else
					if attached prevnode as prevnodesafe then
						prevnodesafe.setrightnode (localvalue)
						end
				end --end issmaller-if

			end--end root-if
			ensure
				current.has (localvalue)					--a node with the value of the parameter has to be in the tree
		end--end do

feature --find

	find (localvalue: INTEGER_32): detachable NODE			--search a node with the value of the parameter and returns it if existing or void if not
		local
			localnode: detachable NODE
		do
			Result:=Void
			from										--searching in the left partree if the value of the parameter is smaller than the value of the local node, in the right if bigger
				localnode := root
			until
				localnode = Void or Result /= Void		--searching until the next node is void, which means that there is no node with the searched value or until result is not void, which mean that a node witch the searched node is found
			loop
				if (localvalue = localnode.getvalue) then
					Result := localNode
				elseif (localvalue < localnode.getvalue) then
					localnode := localnode.getleftnode
				elseif (localvalue > localnode.getvalue) then
					localnode := localnode.getrightnode
				end
			end
		end

feature --has
	has(localValue: INTEGER): BOOLEAN					--using the find method to show whether there is a node with the searched value; returns true if there is such a node, false if not
		do
			Result:= current.find (localValue)/=Void
		end

feature --remove									--in the following methods attached-ifs are meant for void safety
	remove(localValue: INTEGER): BOOLEAN			--removes a node with the value of the parameter, returns true if successful
		require
			current.has (localvalue)				--can't remove a node with a value that's not in the tree
		local
			deleteNode: detachable NODE				--node whitch has to be deleted

		do	--attached-ifs ensure void safety
			deletenode:=find(localvalue)			--getting the node which has to be deleted

			if attached deletenode as deleteNodeSafe then
				if(deleteNodeSafe.getleftNode=VOID AND deleteNodeSafe.getRightNode=void) then	--deleting node  has no children
					if(deleteNodeSafe=root) then												--is the deleting node the root or a normal node

							Result:=current.removeRootwithoutChild(deleteNode) 						--call method to remove a root without children

					else

							Result:=current.removeNodeWithoutChild(deleteNode) 						--call method to remove a normal node without children

					end--end root-if

				elseif(deleteNodeSafe.getleftNode/=VOID AND deleteNodeSafe.getRightNode=void)then 	--deleting a node with a left child only
					if(deleteNodeSafe=root) then													--is the deleting node the root or a normal node

							Result:=current.removeRootwithLeftChild(deleteNode)							--call method to remove a root with a left child

					else

							Result:=current.removeNodeWithLeftChild(deleteNode) 							--call method to remove a normal node with a left child

					end

				elseif(deleteNodeSafe.getleftNode=VOID AND deleteNodeSafe.getRightNode/=void)then	--deleting a node with a right child only
					if(deleteNodeSafe=root) then													--is the deleting node the root or a normal node

							Result:=current.removeRootwithRightChild(deleteNode) 						--call method to remove a root with a right child

					else

							Result:=	current.removeNodeWithRightChild(deleteNode) 						--call method to remove a root with a left child

					end

				elseif(deleteNodeSafe.getleftNode/=VOID AND deleteNodeSafe.getRightNode/=void)then	--deleting a node with two children
					if(deleteNodeSafe=root) then													--is the deleting node the root or a normal node

							Result:=current.removeRootwithTwoChild(deleteNode)--call method to remove a root with two children

					else

							Result:=current.removeNodeWithTwoChild(deleteNode)--call method to remove a normal node with two children


					end

				end--end if-elseif-sequence
			end--end deletnodesafe attached-if

		ensure
			NOT current.has (localvalue)			--method shouldn't appear in the tre anymore
		end				--end do


--in the following methods attached-ifs are meant for void safety
feature --specific remove methods		
	removeRootwithoutChild(deleteNode: detachable NODE):BOOLEAN			--method to remove a root without children, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		do
			current.setroot (VOID)										--set the root to void
			Result:=true
		end --end rootwithoutchild

	removeNodeWithoutChild(localDeleteNode: detachable NODE): BOOLEAN	--method to remove a root without children, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		do
			if attached localdeletenode as localdeletenodeSafe then
				if attached localdeletenodeSafe.getParent as parentSafe then
					if localdeletenodeSafe.getValue<parentSafe.getValue then	--was the node a left or a right child of his parent?
						parentSafe.setNewLeftNode(void)							--left child of the parent becomes void
						Result:=true
					elseif localdeletenodeSafe.getValue>parentSafe.getValue then
						parentSafe.setNewRightNode(void)						--right child of the parent becomes void
						Result:=true
					end
				end --end parentSafe attached-if
			end--end localdeletesafe attached-if
		end--end NodewithoutChild

	removeRootwithLeftChild(localDeleteNode: detachable NODE): BOOLEAN	--method to remove a root with a left child, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		local
			replacingNode: detachable NODE										--node which replaces the deleted node in the tree
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)	--get the replacing node
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then			--is the replacing node directly the left child of the node which has to be deleted?
					current.setroot (replacingnode)								--the left child becomes the new root
					Result:=true
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as parentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then	--has the replacing node a left child?
								parentSafe.setNewRightNode(replacingLeftSafe)					--parent of the replacing node gets a new right child(left child of the replacing node)
								replacingLeftSafe.setParent(parentSafe)							--left child of the replacing node gets a new parent(parent of the replacing node)
							else
								parentSafe.setNewRightNode(void)								--parents right child of the replacing node becomes void(no new child)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								current.setroot (replacingNodeSafe)								--set the replacing node as the new root
								replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)			--set the left child of the former root as the left child of the new root
								Result:=true
							end

						end--end parentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do


	removeNodeWithLeftChild(localdeleteNode: detachable NODE): BOOLEAN		--method to remove a normal node with a left child, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		local
			replacingNode: detachable NODE									--node which replaces the node wich has to be deleted
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)	--get the replacing node
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then		--is the replacing node the left child of the node which has to be deleted
					if attached replacingnode as replacingnodeSafe then
						if attached localdeletenodeSafe.getParent as deletedParentSafe then
							if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then	--was the node which has to be deleted a left or a right child of its parent?
								deletedParentSafe.setNewLeftNode(replacingnodeSafe)				--set the replacing node as the left child of the parent of the node which has to be deleted
								replacingnodeSafe.setParent(deletedParentSafe)					--set the parent of the node which has to be deleted as the parent of the replacing node
							elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
								deletedParentSafe.setNewRightNode(replacingnodeSafe)			--set the replacing node as the right child of the parent of the node which has to be deleted
								replacingnodeSafe.setParent(deletedParentSafe)					--set the parent of the node which has to be deleted as the parent of the replacing node
							end
							Result:=true
						end--end ParentSafe attached-if
					end--end replacingNodeSafe attached-if
				else	--replacing node is not the child of the node which has to be deleted
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as replacingParentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then
								replacingParentSafe.setNewRightNode(replacingLeftSafe)		--parent of the replacing node gets a new right child(left child of the replacing node)
								replacingLeftSafe.setParent(replacingParentSafe)			--left child of the replacing node gets a new parent(parent of the replacing node)
							else
								replacingParentSafe.setNewRightNode(void)					--parents right child of the replacing node becomes void(no new child)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)		--set the new left child of the replacing node(left child of the deleted node
								localDeleteLeftSafe.setParent(replacingNodeSafe)			--replacing node becomes the new parent of the former left child of the deleted node
							end--end localDeleteLeftSafe attached-if
							if attached localdeletenodeSafe.getParent as deletedParentSafe then
								if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then	--was the node which has to be deleted a left or a right child of its parent?
									deletedParentSafe.setNewLeftNode(replacingnodeSafe)				--set the replacing node as the left child of the parent of the node which has to be deleted
									replacingnodeSafe.setParent(deletedParentSafe)					--set the parent of the node which has to be deleted as the parent of the replacing node
								elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
									deletedParentSafe.setNewRightNode(replacingnodeSafe)			--set the replacing node as the right child of the parent of the node which has to be deleted
									replacingnodeSafe.setParent(deletedParentSafe)					--set the parent of the node which has to be deleted as the parent of the replacing node
								end
								Result:=true
							end--end ParentSafe attached-if


						end--end replacingParentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do

	removeRootwithRightChild(localDeleteNode: detachable NODE): BOOLEAN						--method to remove a root with a right child only, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		local
			replacingNode: detachable NODE													--node which replaces the node wich has to be deleted
		do
			replacingnode:=current.getsmallestofrightparttree (localdeletenode)				--get the replacing node
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getRightNode) then						--is the replacing node directly the left child of the node which has to be deleted
					current.setroot (replacingnode)											--the left child becomes the new root
					Result:=true
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as replacingParentSafe then
							if attached replacingNodeSafe.getRightNode as replacingRightSafe then	--has the replacing node a left child?
								replacingParentSafe.setNewLeftNode(replacingRightSafe)		--parent of the replacing node gets a new left child(right child of the replacing node)
								replacingRightSafe.setParent(replacingParentSafe)			--right child of the replacing node gets a new parent(parent of the replacing node)
							else
								replacingParentSafe.setNewLeftNode(void)					--parents left child of the replacing node becomes void(no new child)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
								current.setroot (replacingNodeSafe)							--set the replacing node as the new root
								replacingNodeSafe.setNewRightNode(localDeleteRightSafe)		--set the right child of the former root as the right child of the new root
								Result:=true
							end--end localDeleteLeftSafe attached-if

						end--end parentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end--localdeletenodeSafe attached-if
		end --end do


	removeNodeWithRightChild(localDeleteNode: detachable NODE): BOOLEAN			--method to remove a normal node with a right child, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		local
			replacingNode: detachable NODE										--node which replaces the node wich has to be deleted
		do
			replacingnode:=current.getsmallestofrightparttree (localdeletenode)	--get the replacing node
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getRightNode) then							--is the replacing node the right child of the node which has to be deleted
					if attached replacingnode as replacingnodeSafe then
						if attached localdeletenodeSafe.getParent as deletedParentSafe then
							if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then	--was the node which has to be deleted a left or a right child of its parent?				
								deletedParentSafe.setNewLeftNode(replacingnodeSafe)				--set the replacing node as the left child of the parent of the node which has to be deleted
								replacingnodeSafe.setParent(deletedParentSafe)					--set the parent of the node which has to be deleted as the parent of the replacing node
							elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
								deletedParentSafe.setNewRightNode(replacingnodeSafe)			--set the replacing node as the right child of the parent of the node which has to be deleted
								replacingnodeSafe.setParent(deletedParentSafe)					--set the parent of the node which has to be deleted as the parent of the replacing node
							end
							Result:=true
						end--end ParentSafe attached-if
					end--end replacingNodeSafe attached-if
				else	--replacing node is not the child of the node which has to be deleted
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as replacingParentSafe then
							if attached replacingNodeSafe.getRightNode as replacingRightSafe then
								replacingParentSafe.setNewLeftNode(replacingRightSafe)			--parent of the replacing node gets a new left child(right child of the replacing node)
								replacingRightSafe.setParent(replacingParentSafe)				--right child of the replacing node gets a new parent(parent of the replacing node)
							else
								replacingParentSafe.setNewLeftNode(void)						--parents left child of the replacing node becomes void(no new child)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
								replacingNodeSafe.setNewRightNode(localDeleteRightSafe)			--set the new right child of the replacing node(right child of the deleted node
								localDeleteRightSafe.setParent(replacingNodeSafe)				--replacing node becomes the new parent of the former right child of the deleted node
							end--end localDeleteLeftSafe attached-if
							if attached localdeletenodeSafe.getParent as deletedParentSafe then
								if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then--was the node which has to be deleted a left or a right child of its parent?
									deletedParentSafe.setNewLeftNode(replacingnodeSafe)			--set the replacing node as the left child of the parent of the node which has to be deleted
									replacingnodeSafe.setParent(deletedParentSafe)				--set the parent of the node which has to be deleted as the parent of the replacing node
								elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
									deletedParentSafe.setNewRightNode(replacingnodeSafe)		--set the replacing node as the right child of the parent of the node which has to be deleted
									replacingnodeSafe.setParent(deletedParentSafe)				--set the parent of the node which has to be deleted as the parent of the replacing node
								end
								Result:=true
							end--end ParentSafe attached-if


						end--end replacingParentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do



	removeRootwithTwoChild(localdeleteNode: detachable NODE): BOOLEAN							--method to remove a root with two children, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		local
			replacingNode: detachable NODE														--node which replaces the node wich has to be deleted
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)					--get the replacing node
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then							--is the replacing node directly the left child of the node which has to be deleted
					if attached localdeletenodeSafe.getRightNode as localDeleteRight then
						if attached replacingnode as replacingNodeSafe then
							replacingNodeSafe.setNewRightNode(localDeleteRight)					--replacing node gets the right child of the node which has to be deleted as  the new right child
						end
						current.setroot (replacingnode)											--the left child becomes the new root
						Result:=true
					end
				else		--replacing node is not the child of the node which has to be deleted
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as parentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then
								parentSafe.setNewRightNode(replacingLeftSafe)				--parent of the replacing node gets a new right child(left child of the replacing node)
								replacingLeftSafe.setParent(parentSafe)						--left child of the replacing node gets a new parent(parent of the replacing node)
							else
								parentSafe.setNewRightNode(void)							--parents right child of the replacing node becomes void(no new child)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
									current.setroot (replacingNodeSafe)						--replacing node becomes new root
									replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)	--replacing node gets the left child of the node which has to be deleted as  the new left child
									localDeleteLeftSafe.setParent(replacingNodeSafe)		--left child of the deleted node gets the replacing node as new parent
									replacingNodeSafe.setNewRightNode(localDeleteRightSafe)	--replacing node gets the right child of the node which has to be deleted as  the new right child
									localDeleteRightSafe.setParent(replacingNodeSafe)		--right child of the deleted node gets the replacing node as new parent
									Result:=true
								end--end localDeleteRightSafe attached-if
							end--end localDeleteLeftSafe attached-if

						end--end parentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do


	removeNodeWithTwoChild(localDeleteNode: detachable NODE): BOOLEAN					--method to remove a normal node with two children, returns true if successful; gets the reference of the node which has to be deleted as a parameter
		local
			replacingNode: detachable NODE												--node which replaces the node wich has to be deleted
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)			--get the replacing node

			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then					--is the replacing node directly the left child of the node which has to be deleted

					if attached localdeletenodeSafe.getRightNode as localDeleteRight then
						if attached localdeletenodeSafe.getParent as localDeleteParent then
							if attached replacingnode as replacingnodeSafe then
								if(localdeletenodeSafe.getValue<localDeleteParent.getValue)then	--was the node which has to be deleted a left or a right child of its parent?
									replacingnodeSafe.setParent(localDeleteParent)			--set the parent of the node which has to be deleted as the parent of the replacing node
									localDeleteParent.setNewLeftNode(replacingnodeSafe)		--set the replacing node as the left child of the parent of the node which has to be deleted
								else
									replacingnodeSafe.setParent(localDeleteParent)			--set the parent of the node which has to be deleted as the parent of the replacing node
									localDeleteParent.setNewRightNode(replacingnodeSafe)	--set the replacing node as the right child of the parent of the node which has to be deleted
								end
								replacingnodeSafe.setNewRightNode(localDeleteRight)			--former right node of the deleted node becomes the new right child of the replacing node
								Result:=true
							end--end replacingnodeSafe attached-if
						end--end localDeleteParent attached-if

					end--end localDeleteRightattached-if
				else	--replacing node is not the child of the node which has to be deleted
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as parentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then
								parentSafe.setNewRightNode(replacingLeftSafe)					--parent of the replacing node gets a new right child(left child of the replacing node)


								replacingLeftSafe.setParent(parentSafe)							--left child of the replacing node gets a new parent(parent of the replacing node)
							else
								parentSafe.setNewRightNode(void)								--parents right child of the replacing node becomes void(no new child)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
									if attached localdeletenodeSafe.getParent as deletedParentSafe then
										if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then--was the node which has to be deleted a left or a right child of its parent?									
											deletedParentSafe.setNewLeftNode(replacingnodeSafe)		--set the replacing node as the left child of the parent of the node which has to be deleted
											replacingnodeSafe.setParent(deletedParentSafe)				--set the parent of the node which has to be deleted as the parent of the replacing node
										elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
											deletedParentSafe.setNewRightNode(replacingnodeSafe)	--set the replacing node as the right child of the parent of the node which has to be deleted
											replacingnodeSafe.setParent(deletedParentSafe)			--set the parent of the node which has to be deleted as the parent of the replacing node
										end
										replacingNodeSafe.setNewRightNode(localDeleteRightSafe)			--replacing node gets the right child of the node which has to be deleted as  the new right child
										localDeleteRightSafe.setParent(replacingNodeSafe)				--right child of the deleted node gets the replacing node as new parent
										replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)			--replacing node gets the left child of the node which has to be deleted as  the new left child
										localDeleteLeftSafe.setParent(replacingNodeSafe)				--left child of the deleted node gets the replacing node as new parent
										Result:=true
									end--end ParentSafe attached-if
								end--end localDeleteRightSafe attached-if
							end--end localDeleteLeftSafe attached-if

						end--end parentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do

feature --helping features for delete
	getBiggestOfLeftPartTree(actRoot: detachable NODE): detachable NODE		--searches the biggest node in the left part tree according to the node given as the parameter
		local
			tempBiggest: detachable NODE
			bool: BOOLEAN
		do
			if attached actroot as actrootSafe then

				from											--searching for the biggest value in the left part-tree of the deleted node
					tempBiggest:=actrootSafe.getLeftNode					--set the left child of the node which has to be deleted locally						
				until
					bool=true
				loop
					if attached tempBiggest as tempBiggestSafe then		--ensure that the actual templeft isn't void
						if(tempBiggestSafe.getrightnode/=void) then	-- only if the next right child of the actual tmpleft isn't void it gets set; otherwise->endless-loop
							tempBiggest:=tempBiggestSafe.getRightNode
						end
					end
					if attached tempBiggest as tempBiggestSafe then	--ensure void-safety
						if tempBiggestSafe.getRightNode=void then	--there is no bigger value in this part tree->actual templeft is the node with the biggest value
							bool:=true
						end
					end
				end --end loop
			end
			Result:=tempBiggest
		end--end do

	getSmallestOfRightPartTree(actRoot: detachable NODE): detachable NODE --searches the smallest node in the right part tree according to the node given as the parameter
		local
			tempSmallest: detachable NODE			--node which is the smallest in the part tree
			bool: BOOLEAN
		do
			if attached actroot as actrootSafe then
				from											--searching for the node with the smallest value in the right part-tree of the deleted node
					tempSmallest:=actrootSafe.getRightNode
				until
					bool=true
				loop
					if attached tempSmallest as tempSmallestSafe then	--ensure void-safety
						if(tempSmallestsafe.getleftnode/=void) then --only if the next left node of the actual tempright isn't void it gets set; otherwise->endless-loop
							tempSmallest:=tempSmallestSafe.getLeftNode
						end
					end
					if attached tempSmallest as tempSmallestSafe then --ensure void-safety
						if tempSmallestSafe.getLeftNode=void then --there is no node with a smaller value in this part tree->the actual tempright node is the one with the smallest value
							bool:=true
						end
					end
				end --end loop
			end
			Result:=tempSmallest
		end

feature --root-methods

	getroot: detachable NODE	--	returns the root of the tree
		do
			Result := root
		end

	setRoot(newRoot: detachable NODE)	--sets the root of the tree; new root as parameter
		do
			root:=newroot
		end

feature --redefine
	is_empty: BOOLEAN		--returns whether the tree is empty or not
		do
			Result:= Root=Void	--no root no tree
		end

--	linear_representation: LINEAR [INTEGER]
--			do
--				Result:= linear_representation
--			end



feature
	root: detachable NODE				--first node in the tree

end -- class BINARYTREE

