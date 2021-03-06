indexing

	description:

		"Tables that allow bilinear traversing"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2008-07-20 21:27:20 +0200 (Sun, 20 Jul 2008) $"
	revision: "$Revision: 6454 $"

deferred class DS_BILINEAR_TABLE [G, K]

inherit

	DS_TABLE [G, K]

	DS_BILINEAR [G]
		rename
			has as has_item
		redefine
			new_cursor
		end

feature -- Access

	key_for_iteration: K is
			-- Key at internal cursor position
		require
			not_off: not off
		do
			Result := cursor_key (internal_cursor)
		end

	new_cursor: DS_BILINEAR_TABLE_CURSOR [G, K] is
			-- New external cursor for traversal
		deferred
		end

feature {DS_BILINEAR_TABLE_CURSOR} -- Cursor implementation

	cursor_key (a_cursor: like new_cursor): K is
			-- Key at `a_cursor' position
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_valid: valid_cursor (a_cursor)
			a_cursor_not_off: not cursor_off (a_cursor)
		deferred
		end

end
