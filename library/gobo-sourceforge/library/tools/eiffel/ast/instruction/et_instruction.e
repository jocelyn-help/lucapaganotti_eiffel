indexing

	description:

		"Eiffel instructions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-04-23 23:23:03 +0200 (Mon, 23 Apr 2007) $"
	revision: "$Revision: 5948 $"

deferred class ET_INSTRUCTION

inherit

	ET_AST_NODE

feature -- Initialization

	reset is
			-- Reset instruction as it was just after it was last parsed.
		do
		end

feature -- Status report

	is_semicolon: BOOLEAN is
			-- Is current node a semicolon?
		do
			-- Result := False
		end

end
