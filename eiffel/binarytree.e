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
	make (value: INTEGER_32)
		do
			create root.make (value, Void)
		end

feature --insert

	insert (value: INTEGER_32)
		local
			currentnode: detachable NODE
			prevnode: detachable NODE
			issmaller: BOOLEAN
		do
			prevnode := Current.root
			from
				currentnode := prevnode
			until
				currentnode = Void
			loop
				if (value < currentnode.getvalue) then
					prevnode := currentnode
					currentnode := currentnode.getleftnode
					issmaller := True
				elseif (value > currentnode.getvalue) then
					prevnode := currentnode
					currentnode := currentnode.getrightnode
					issmaller := False
				end
			end
			if (issmaller) then
				if attached prevnode as prevnodesafe then
					prevnodesafe.setleftnode (value)
				end

			else
				if attached prevnode as prevnodesafe then
					prevnodesafe.setrightnode (value)
					end
			end
		end

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
			tempParent: detachable NODE
			tempLeft: detachable NODE
			tempRight: detachable NODE
			tempNodeL: detachable NODE --temporary left node for deleting the root
			tempNodeR: detachable NODE --temporary right node for deleting the root
			bool: BOOLEAN

		do
			deleteNode:=current.find (localvalue)		--search for the node wich has to be deleted
			if attached deleteNode as deleteNodeSafe then	--ensure that there is the node wich hast to be delete
			--space for removing the Root

				if deletenode=root then

					if deleteNodeSafe.getLeftNode=Void AND deleteNode.getRightNode=Void then			--both left and right node are void
						Current.setRoot(void)
						Result:=true


					elseif deletenodesafe.getleftnode/=void AND deleteNodeSafe.getrightnode=void then	--deleting a root with a left child
						if attached deleteNode.getLeftNode as delLeftSafe then	--ensure that the left child of the node which has to be deleted isn't void
							from											--searching for the biggest value in the left part-tree of the deleted node
								tempLeft:=deleteNode.getLeftNode					--set the left child of the node which has to be deleted locally						
							until
								bool=true
							loop
								if attached tempLeft as tempLeftSafe then		--ensure that the actual templeft isn't void
									if(tempLeftSafe.getrightnode/=void) then	-- only if the next right child of the actual tmpleft isn't void it gets set; otherwise->endless-loop
										templeft:=tempLeftSafe.getRightNode
									end
								end
								if attached tempLeft as tempLeftSafe then	--ensure void-safety
									if tempLeftSafe.getRightNode=void then	--there is no bigger value in this part tree->actual templeft is the node with the biggest value
										bool:=true
									end
								end
							end --end loop

							if attached tempLeft as tempLeftSafe then	--ensure void-safety

								if attached tempLeftSafe.getparent as tempLeftParent then	--ensure void-safety
									if  attached tempLeftSafe.getleftnode as tempLeftLeft then	--ensure void-safety
										tempLeftParent.setNewRightNode(tempLeftLeft)	--parent of the node which replaces the deleted node gets new right child
										tempLeftLeft.setparent (templeftSafe.getparent)			--child of the node whitch replaces the delete node gets new parent	
									else
										tempLeftParent.setNewRightNode(void)	--parent of the node which replaces the deleted node has no more child
									end --end tempLeftLeft
								end --end templeftparent attahced-if
								if attached current.getroot as rootSafe then	--setting the new Root and the child of the old root to the new one
									tempNodeL:=rootSafe.getleftnode
									current.setroot (tempLeftSafe)	--setting new root
									if attached current.getroot as newRootSafe then	--new root new if
										if attached tempnodeL as tempnodeLSafe then
											tempnodeLSafe.setparent (newRootSafe)
											newRootSafe.setNewLeftNode(tempnodeL)
											Result:=true
										end --end tempnodesafe attached-if
									end --end newRootSafe attached-if
								end --end rootsafe attached-if


							end --tempLeftSafe attahced-if


						end --delleftsafe if-attached
					elseif deleteNode.getrightnode/=Void AND deletenode.getleftnode=void then					--left node is void, right node is a child
						if attached deleteNode.getRightNode as delRightSafe then	--ensure void-safety

							from											--searching for the node with the smallest value in the right part-tree of the deleted node
								tempRight:=deleteNode.getRightNode
							until
								bool=true
							loop
								if attached tempRight as tempRightSafe then	--ensure void-safety
									if(temprightsafe.getleftnode/=void) then --only if the next left node of the actual tempright isn't void it gets set; otherwise->endless-loop
										tempRight:=tempRightSafe.getLeftNode
									end
								end
								if attached tempRight as tempRightSafe then --ensure void-safety
									if tempRightSafe.getLeftNode=void then --there is no node with a smaller value in this part tree->the actual tempright node is the one with the smallest value
										bool:=true
									end

								end
							end --end loop


							if attached tempRight as tempRightSafe then	--ensure void-safety

								if attached temprightSafe.getparent as tempRightParent then	--ensure void-safety
									if attached temprightSafe.getrightnode as tempRightRight then	--ensure void-safety
										tempRightParent.setNewLeftNode(tempRightRight)				--parent of the node which replaces th deleted node gets a new left child
										tempRightRight.setparent (tempRightSafe.getparent)			--child of the node whitch replaces the delete node gets new parent
									else
										tempRightParent.setNewLeftNode(void)						--if the node which replaces th deleted node has no children the parent node gets no new child
									end --end tempRightRight

									if attached current.getroot as rootSafe then	--setting the new Root and the child of the old root to the new one
									tempNodeR:=rootSafe.getrightNode
									current.setroot (tempRightSafe)	--setting new root
									if attached current.getroot as newRootSafe then	--new root new if to get the actual root
										if attached tempNodeR as tempnodeRSafe then
											tempnodeRSafe.setparent (newRootSafe)
											newRootSafe.setNewRightNode(tempnodeR)
											Result:=true
										end --end tempnodesafe attached-if
									end --end newRootSafe attached-if
								end --end rootsafe attached-if
								end --end tempRightParent
							end --end tempRightSafe

						end --end delRightSafe attached-if

					elseif deletenode.getleftnode/=void AND deletenode.getrightnode/=void then
						if attached deleteNode.getLeftNode as delLeftSafe then	--ensure that the left child of the node which has to be deleted isn't void
							from											--searching for the biggest value in the left part-tree of the deleted node
								tempLeft:=deleteNode.getLeftNode					--set the left child of the node which has to be deleted locally						
							until
								bool=true
							loop
								if attached tempLeft as tempLeftSafe then		--ensure that the actual templeft isn't void
									if(tempLeftSafe.getrightnode/=void) then	-- only if the next right child of the actual tmpleft isn't void it gets set; otherwise->endless-loop
										templeft:=tempLeftSafe.getRightNode
									end
								end
								if attached tempLeft as tempLeftSafe then	--ensure void-safety
									if tempLeftSafe.getRightNode=void then	--there is no bigger value in this part tree->actual templeft is the node with the biggest value
										bool:=true
									end
								end
							end --end loop

							if attached tempLeft as tempLeftSafe then	--ensure void-safety

								if attached tempLeftSafe.getparent as tempLeftParent then	--ensure void-safety
									if  attached tempLeftSafe.getleftnode as tempLeftLeft then	--ensure void-safety
										tempLeftParent.setNewRightNode(tempLeftLeft)	--parent of the node which replaces the deleted node gets new right child
										tempLeftLeft.setparent (templeftSafe.getparent)			--child of the node whitch replaces the delete node gets new parent	
									else
										tempLeftParent.setNewRightNode(void)	--parent of the node which replaces the deleted node has no more child
									end --end tempLeftLeft
								end --end templeftparent attahced-if
								if attached current.getroot as rootSafe then	--setting the new Root and the child of the old root to the new one
									tempNodeL:=rootSafe.getleftnode
									tempNodeR:=rootSafe.getrightnode
									if attached rootsafe.getrightnode as tempnodeRSafe then
									print(tempnodeRSafe.getvalue)
									end
									current.setroot (tempLeftSafe)	--setting new root
									if attached current.getroot as newRootSafe then	--new root new if
										if attached tempnodeL as tempnodeLSafe then
											if attached tempnodeR as tempnodeRSafe then

												tempnodeRSafe.setparent(newRootSafe)
												newRootSafe.setnewRightNode(tempnodeRSafe)
												Result:=true
											end
											tempnodeLSafe.setparent (newRootSafe)
											newRootSafe.setNewLeftNode(tempnodeL)


										end --end tempnodesafe attached-if
									end --end newRootSafe attached-if
								end --end rootsafe attached-if


							end --tempLeftSafe attahced-if


						end --delleftsafe if-attached
					end --end if-/elseif-structure
				else



					if attached deleteNode.getparent as parentSafe  then	--ensure the deleting node has a parent
						if deleteNodeSafe.getLeftNode=Void AND deleteNode.getRightNode=Void then			--both left and right node are void
							if(deleteNode.getValue<parentSafe.getValue) then	--is the node which has to be deleted the left or the right child of the parent?
								parentSafe.setNewLeftNode(Void)
								Result:=true
							else
								parentSafe.setNewRightNode(Void)
								Result:=true
							end

						elseif deleteNode.getLeftNode /=Void AND deletenode.getrightnode=void	then			--left node is a child, right node is void
							if attached deleteNode.getLeftNode as delLeftSafe then	--ensure that the left child of the node which has to be deleted isn't void
								from											--searching for the biggest value in the left part-tree of the deleted node
									tempLeft:=deleteNode.getLeftNode					--set the left child of the node which has to be deleted locally						
								until
									bool=true
								loop
									if attached tempLeft as tempLeftSafe then		--ensure that the actual templeft isn't void
										if(tempLeftSafe.getrightnode/=void) then	-- only if the next right child of the actual tmpleft isn't void it gets set; otherwise->endless-loop
											templeft:=tempLeftSafe.getRightNode
										end
									end
									if attached tempLeft as tempLeftSafe then	--ensure void-safety
										if tempLeftSafe.getRightNode=void then	--there is no bigger value in this part tree->actual templeft is the node with the biggest value
											bool:=true
										end
									end

								end --end loop

								if attached tempLeft as tempLeftSafe then	--ensure void-safety
									if attached tempLeftSafe.getparent as tempLeftParent then	--ensure void-safety
										if  attached tempLeftSafe.getleftnode as tempLeftLeft then	--ensure void-safety
											tempLeftParent.setNewRightNode(tempLeftLeft)	--parent of the node which replaces the deleted node gets new right child
											tempLeftLeft.setparent (templeftSafe.getparent)			--child of the node whitch replaces the delete node gets new parent	
										else
											tempLeftParent.setNewRightNode(void)	--parent of the node which replaces the deleted node has no more child
										end --end tempLeftLeft
										templeftSafe.setNewLeftNode(deletenode.getleftnode)				--set the child of the deleted node as the new child of the replacing node with the biggest value under the deleted value
										delLeftSafe.setparent (templeft)					--replace the parent of the child of the deleted node with the node with the biggest value under the deleted value


										if(deletenode.getvalue<parentSafe.getvalue) then	--was the deleted node a left or a right child?
											parentSafe.setNewLeftNode(templeft)				--parent of the deleted node gets a new left child
											templeftSafe.setparent (deletenode.getparent)	--new child gets a new parent
										else
											parentSafe.setNewRightNode(templeft)			--parent of the deleted node gets a new right child
											templeftSafe.setparent (deletenode.getparent)	--new child gets a new parent
										end --end if-else-clause right above
									Result:=true		--successful removement

									end --end tempLeftParent
								end --end tempLeftSafe attached if
							end --end delLeftSafe attached-if


						elseif deleteNode.getrightnode/=Void AND deletenode.getleftnode=void then					--left node is void, right node is a child
							if attached deleteNode.getRightNode as delRightSafe then	--ensure void-safety

								from											--searching for the node with the smallest value in the right part-tree of the deleted node
									tempRight:=deleteNode.getRightNode
								until
									bool=true
								loop
									if attached tempRight as tempRightSafe then	--ensure void-safety
										if(temprightsafe.getleftnode/=void) then --only if the next left node of the actual tempright isn't void it gets set; otherwise->endless-loop
											tempRight:=tempRightSafe.getLeftNode
										end
									end
									if attached tempRight as tempRightSafe then --ensure void-safety
										if tempRightSafe.getLeftNode=void then --there is no node with a smaller value in this part tree->the actual tempright node is the one with the smallest value
											bool:=true
										end

									end
								end


								if attached tempRight as tempRightSafe then	--ensure void-safety

									if attached temprightSafe.getparent as tempRightParent then	--ensure void-safety
										if attached temprightSafe.getrightnode as tempRightRight then	--ensure void-safety
											tempRightParent.setNewLeftNode(tempRightRight)				--parent of the node which replaces th deleted node gets a new left child
											tempRightRight.setparent (tempRightSafe.getparent)			--child of the node whitch replaces the delete node gets new parent
										else
											tempRightParent.setNewLeftNode(void)						--if the node which replaces th deleted node has no children the parent node gets no new child
										end --end tempRightRight

										temprightSafe.setNewRightNode(deletenode.getrightnode)			--node which replaces the deleted noe gets the deleted nodes right child
										delRightSafe.setparent (tempright)								--right child gets new replaced parent

										if(deletenode.getvalue<parentSafe.getvalue) then			--was the deleted node a left or a right child?
											parentSafe.setNewLeftNode(tempright)					--parent of the deleted node gets a new left child
											temprightSafe.setparent (deletenode.getparent)			--new child gets new parent
										else
											parentSafe.setNewRightNode(tempright)					--parent of the deleted node gets a new right child
											temprightSafe.setparent (deletenode.getparent)			--new child gets new parent
										end
										Result:=true			--successful removement
									end --end tempRightParent
								end --end tempRightSafe

							end --end delRightSafe attached-if

						elseif deletenode.getleftnode/=void AND deletenode.getrightnode/=void then		--deleted node has both left and right child
							if attached deleteNode.getRightNode as delRightSafe then		--ensure void-safety
								if attached deleteNode.getLeftNode as delLeftSafe then		--ensure void-safety


									from												--searching for the smallest value in the right part-tree of the deleted node
										tempRight:=deleteNode.getRightNode
									until
										bool=true
									loop
										if attached tempRight as tempRightSafe then		--ensure void-safety
											if(temprightsafe.getleftnode/=void) then	--only if the next left node of tempRight isn't void it will get the next tempRight; otherwise->endless-loop
											tempRight:=tempRightSafe.getLeftNode
											end
										end-- end temprightsafe attached-if
										if attached tempRight as tempRightSafe then		--ensure void-safety
											if tempRightSafe.getLeftNode=void then		--if the next left node is void, you found the smallest node which menas no more loops
												bool:=true
											end
										end--end temprightsafe attached-if
									end

									if attached tempright as tempRightSafe then			--ensure void-safety
										if attached temprightSafe.getparent as tempRightParent then	--ensure void-safety
											if attached temprightSafe.getrightnode as tempRightRight then	--ensure void-safety/has the replacing node got a right child?(no left child possible, it's already the smallest)
												tempRightParent.setNewLeftNode(tempRightRight)				--parent of the replacing node gets the child of the replacing node as a new left child
												tempRightRight.setparent (tempRightSafe.getparent)
											else
												tempRightParent.setNewLeftNode(void)						--replacing child hadn't had a right child, so the parents left child is void
											end --end tempRightRight

											temprightSafe.setNewRightNode(deletenode.getrightnode)			--replacing node gets new right child
											delRightSafe.setparent (tempright)								--former right child of the deleted node gets a new parent
											tempRightSafe.setNewLeftNode(deletenode.getleftnode)			--replacing node gets new left child
											delLeftSafe.setparent(tempright)								--former left child of the deleted node gets a new parent


											if(deletenode.getvalue<parentSafe.getvalue) then				--was the deleted node a left or a right child?
												parentSafe.setNewLeftNode(tempright)						--value was smaller so the replacing node is now the left child of the parent node
												temprightSafe.setparent (deletenode.getparent)				--the other way around the former parent of the deleted node is now the parent of the replacing node
											else
												parentSafe.setNewRightNode(tempright)						--same as 2 rows above, only as a right child
												temprightSafe.setparent (deletenode.getparent)				--same as 3 rows above
											end
											Result:=true					--removement was successful
										end --end tempRightParent
									end --end tempRightSafe
								end--end delLeftSafe attached-if

							end --end delRightSafe attached-if

						end		--end normal if-/elseif-clauses

					end--end root-if



				end		--end parentSafe attached-if
			end			--end deleteNode attached-if
		end				--end do


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

