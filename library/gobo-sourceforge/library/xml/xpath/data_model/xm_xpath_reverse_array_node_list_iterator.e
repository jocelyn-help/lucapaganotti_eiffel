indexing

	description:

		"Iterators over an arrayed list of nodes in reverse order"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-04-06 10:51:44 +0200 (Sun, 06 Apr 2008) $"
	revision: "$Revision: 6340 $"

class XM_XPATH_REVERSE_ARRAY_NODE_LIST_ITERATOR

inherit

	XM_XPATH_REVERSE_ARRAY_LIST_ITERATOR [XM_XPATH_NODE]
		redefine
			is_node_iterator, as_node_iterator
		end

create

	make, make_slice

feature -- Access

	is_node_iterator: BOOLEAN is
			-- Does `Current' yield a node_sequence?
		do
			Result := True
		end

	as_node_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE] is
			-- `Current' seen as a node iterator
		do
			Result ?= ANY_.to_any (Current)
		end
	
end