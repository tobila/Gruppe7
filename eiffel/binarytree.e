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
		end

feature --insert

	insert (localvalue: INTEGER_32)
		local
			currentnode: detachable NODE
			prevnode: detachable NODE
			issmaller: BOOLEAN
		do
			if root=VOID then
				create currentNode.make (localvalue, void)
				current.setroot (currentNode)
			else
				if NOT has(localvalue) then
					prevnode := Current.root
					from
						currentnode := prevnode
					until
						currentnode = Void
					loop
						if (localvalue < currentnode.getvalue) then
							prevnode := currentnode
							currentnode := currentnode.getleftnode
							issmaller := True
						elseif (localvalue > currentnode.getvalue) then
							prevnode := currentnode
							currentnode := currentnode.getrightnode
							issmaller := False
						end
					end


					if (issmaller) then
						if attached prevnode as prevnodesafe then
							prevnodesafe.setleftnode (localvalue)
						end

					else
						if attached prevnode as prevnodesafe then
							prevnodesafe.setrightnode (localvalue)
							end
					end --end issmaller-if
				end--end find-if
			end--end root-if
		end--end do

feature --find

	find (localvalue: INTEGER_32): detachable NODE
		local
			localnode: detachable NODE
		do
			Result:=Void
			from
				localnode := root
			until
				localnode = Void or Result /= Void
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
	has(localValue: INTEGER): BOOLEAN
		do
			Result:= current.find (localValue)/=Void
		end

feature --remove
	remove(localValue: INTEGER): BOOLEAN
		local
			deleteNode: detachable NODE

		do
			deletenode:=find(localvalue)

			if attached deletenode as deleteNodeSafe then
				if(deleteNodeSafe.getleftNode=VOID AND deleteNodeSafe.getRightNode=void) then
					if(deleteNodeSafe=root) then
						if current.removeRootwithoutChild(deleteNode) then
							Result:=true
						end--end remove-if
					else
						if current.removeNodeWithoutChild(deleteNode) then
							Result:=true
						end
					end--end root-if

				elseif(deleteNodeSafe.getleftNode/=VOID AND deleteNodeSafe.getRightNode=void)then
					if(deleteNodeSafe=root) then
						if current.removeRootwithLeftChild(deleteNode)then
							Result:=true
						end
					else
						if current.removeNodeWithLeftChild(deleteNode) then
							Result:=true
						end
					end

				elseif(deleteNodeSafe.getleftNode=VOID AND deleteNodeSafe.getRightNode/=void)then
					if(deleteNodeSafe=root) then
						if current.removeRootwithRightChild(deleteNode) then
							Result:=true
						end
					else
						if current.removeNodeWithRightChild(deleteNode) then
							Result:=true
						end
					end

				elseif(deleteNodeSafe.getleftNode/=VOID AND deleteNodeSafe.getRightNode/=void)then
					if(deleteNodeSafe=root) then

						if current.removeRootwithTwoChild(deleteNode) then
							Result:=true
						end
					else

						if current.removeNodeWithTwoChild(deleteNode) then
							Result:=true
						end
					end

				end--end if-elseif-sequence
			end--end deletnodesafe attached-if


		end				--end do



feature --specific remove methods
	removeRootwithoutChild(deleteNode: detachable NODE):BOOLEAN
		do
			current.setroot (VOID)
			Result:=true
		end --end rootwithoutchild

	removeNodeWithoutChild(localDeleteNode: detachable NODE): BOOLEAN
		do
			if attached localdeletenode as localdeletenodeSafe then
				if attached localdeletenodeSafe.getParent as parentSafe then
					if localdeletenodeSafe.getValue<parentSafe.getValue then
						parentSafe.setNewLeftNode(void)
						Result:=true
					elseif localdeletenodeSafe.getValue>parentSafe.getValue then
						parentSafe.setNewRightNode(void)
						Result:=true
					end
				end --end parentSafe attached-if
			end--end localdeletesafe attached-if
		end--end NodewithoutChild

	removeRootwithLeftChild(localDeleteNode: detachable NODE): BOOLEAN
		local
			replacingNode: detachable NODE
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then
					current.setroot (replacingnode)
					Result:=true
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as parentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then
								parentSafe.setNewRightNode(replacingLeftSafe)
								replacingLeftSafe.setParent(parentSafe)
							else
								parentSafe.setNewRightNode(void)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								current.setroot (replacingNodeSafe)
								replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)
								Result:=true
							end

						end--end parentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do


	removeNodeWithLeftChild(localdeleteNode: detachable NODE): BOOLEAN
		local
			replacingNode: detachable NODE
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then
					if attached replacingnode as replacingnodeSafe then
						if attached localdeletenodeSafe.getParent as deletedParentSafe then
							if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then
								deletedParentSafe.setNewLeftNode(replacingnodeSafe)
								replacingnodeSafe.setParent(deletedParentSafe)
							elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
								deletedParentSafe.setNewRightNode(replacingnodeSafe)
								replacingnodeSafe.setParent(deletedParentSafe)
							end
							Result:=true
						end--end ParentSafe attached-if
					end--end replacingNodeSafe attached-if
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as replacingParentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then
								replacingParentSafe.setNewRightNode(replacingLeftSafe)
								replacingLeftSafe.setParent(replacingParentSafe)
							else
								replacingParentSafe.setNewRightNode(void)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)
								localDeleteLeftSafe.setParent(replacingNodeSafe)
							end--end localDeleteLeftSafe attached-if
							if attached localdeletenodeSafe.getParent as deletedParentSafe then
								if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then
									deletedParentSafe.setNewLeftNode(replacingnodeSafe)
									replacingnodeSafe.setParent(deletedParentSafe)
								elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
									deletedParentSafe.setNewRightNode(replacingnodeSafe)
									replacingnodeSafe.setParent(deletedParentSafe)
								end
								Result:=true
							end--end ParentSafe attached-if


						end--end replacingParentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do

	removeRootwithRightChild(localDeleteNode: detachable NODE): BOOLEAN
		local
			replacingNode: detachable NODE
		do
			replacingnode:=current.getsmallestofrightparttree (localdeletenode)
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getRightNode) then
					current.setroot (replacingnode)
					Result:=true
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as replacingParentSafe then
							if attached replacingNodeSafe.getRightNode as replacingRightSafe then
								replacingParentSafe.setNewLeftNode(replacingRightSafe)
								replacingRightSafe.setParent(replacingParentSafe)
							else
								replacingParentSafe.setNewLeftNode(void)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
								current.setroot (replacingNodeSafe)
								replacingNodeSafe.setNewRightNode(localDeleteRightSafe)
								Result:=true
							end--end localDeleteLeftSafe attached-if

						end--end parentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end--localdeletenodeSafe attached-if
		end --end do


	removeNodeWithRightChild(localDeleteNode: detachable NODE): BOOLEAN
		local
			replacingNode: detachable NODE
		do
			replacingnode:=current.getsmallestofrightparttree (localdeletenode)
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getRightNode) then
					if attached replacingnode as replacingnodeSafe then
						if attached localdeletenodeSafe.getParent as deletedParentSafe then
							if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then
								deletedParentSafe.setNewLeftNode(replacingnodeSafe)
								replacingnodeSafe.setParent(deletedParentSafe)
							elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
								deletedParentSafe.setNewRightNode(replacingnodeSafe)
								replacingnodeSafe.setParent(deletedParentSafe)
							end
							Result:=true
						end--end ParentSafe attached-if
					end--end replacingNodeSafe attached-if
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as replacingParentSafe then
							if attached replacingNodeSafe.getRightNode as replacingRightSafe then
								replacingParentSafe.setNewLeftNode(replacingRightSafe)
								replacingRightSafe.setParent(replacingParentSafe)
							else
								replacingParentSafe.setNewLeftNode(void)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
								replacingNodeSafe.setNewRightNode(localDeleteRightSafe)
								localDeleteRightSafe.setParent(replacingNodeSafe)
							end--end localDeleteLeftSafe attached-if
							if attached localdeletenodeSafe.getParent as deletedParentSafe then
								if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then
									deletedParentSafe.setNewLeftNode(replacingnodeSafe)
									replacingnodeSafe.setParent(deletedParentSafe)
								elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
									deletedParentSafe.setNewRightNode(replacingnodeSafe)
									replacingnodeSafe.setParent(deletedParentSafe)
								end
								Result:=true
							end--end ParentSafe attached-if


						end--end replacingParentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do



	removeRootwithTwoChild(localdeleteNode: detachable NODE): BOOLEAN
		local
			replacingNode: detachable NODE
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)
			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then
					if attached localdeletenodeSafe.getRightNode as localDeleteRight then
						if attached replacingnode as replacingNodeSafe then
							replacingNodeSafe.setNewRightNode(localDeleteRight)
						end

						current.setroot (replacingnode)
						Result:=true
					end
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as parentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then
								parentSafe.setNewRightNode(replacingLeftSafe)
								replacingLeftSafe.setParent(parentSafe)
							else
								parentSafe.setNewRightNode(void)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
									current.setroot (replacingNodeSafe)
									replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)
									localDeleteLeftSafe.setParent(replacingNodeSafe)
									replacingNodeSafe.setNewRightNode(localDeleteRightSafe)
									localDeleteRightSafe.setParent(replacingNodeSafe)
									Result:=true
								end--end localDeleteRightSafe attached-if
							end--end localDeleteLeftSafe attached-if

						end--end parentSafe attached-if
					end--end replacingNodeSafe
				end--end replacingNOde=leftNodeOfRemovingNode-if
			end --end localdeleteNodeSafe attached-if
		end--end do


	removeNodeWithTwoChild(localDeleteNode: detachable NODE): BOOLEAN
		local
			replacingNode: detachable NODE
		do
			replacingnode:=current.getbiggestofleftparttree (localdeletenode)

			if attached localdeletenode as localdeletenodeSafe then
				if(replacingnode=localdeletenodeSafe.getLeftNode) then

					if attached localdeletenodeSafe.getRightNode as localDeleteRight then
						if attached localdeletenodeSafe.getParent as localDeleteParent then
							if attached replacingnode as replacingnodeSafe then
								if(localdeletenodeSafe.getValue<localDeleteParent.getValue)then
									replacingnodeSafe.setParent(localDeleteParent)
									localDeleteParent.setNewLeftNode(replacingnodeSafe)

								else
									replacingnodeSafe.setParent(localDeleteParent)
									localDeleteParent.setNewRightNode(replacingnodeSafe)
								end
								replacingnodeSafe.setNewRightNode(localDeleteRight)
								Result:=true
							end--end replacingnodeSafe attached-if
						end--end localDeleteParent attached-if

					end--end localDeleteRightattached-if
				else
					if attached replacingnode as replacingNodeSafe then
						if attached replacingNodeSafe.getParent as parentSafe then
							if attached replacingNodeSafe.getLeftNode as replacingLeftSafe then
								parentSafe.setNewRightNode(replacingLeftSafe)
								replacingLeftSafe.setParent(parentSafe)
							else
								parentSafe.setNewRightNode(void)
							end--end replacingLeftSafe attached-if
							if attached localdeletenodeSafe.getLeftNode as localDeleteLeftSafe then
								if attached localdeletenodeSafe.getRightNode as localDeleteRightSafe then
									if attached localdeletenodeSafe.getParent as deletedParentSafe then
										if(localdeletenodeSafe.getValue<deletedParentSafe.getValue) then
											deletedParentSafe.setNewLeftNode(replacingnodeSafe)
											replacingnodeSafe.setParent(deletedParentSafe)
										elseif (localdeletenodeSafe.getValue>deletedParentSafe.getValue) then
											deletedParentSafe.setNewRightNode(replacingnodeSafe)
											replacingnodeSafe.setParent(deletedParentSafe)
										end
										replacingNodeSafe.setNewRightNode(localDeleteRightSafe)
										localDeleteRightSafe.setParent(replacingNodeSafe)
										replacingNodeSafe.setNewLeftNode(localDeleteLeftSafe)
										localDeleteLeftSafe.setParent(replacingNodeSafe)
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
	getBiggestOfLeftPartTree(actRoot: detachable NODE): detachable NODE
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

	getSmallestOfRightPartTree(actRoot: detachable NODE): detachable NODE
		local
			tempSmallest: detachable NODE
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

feature --test-method

	getroot: detachable NODE
		do
			Result := root
		end

	setRoot(newRoot: detachable NODE)
		do
			root:=newroot
		end

feature --redefine
	is_empty: BOOLEAN
		do
			Result:= Root=Void	--no root no tree
		end

--	linear_representation: LINEAR [INTEGER]
--			do
--				Result:= linear_representation
--			end



feature
	root: detachable NODE

end -- class BINARYTREE

