indexing

	description:

		"Singleton pattern that fail to match against any node"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_SHARED_NO_NODE_TEST

feature -- Access

	xslt_empty_item: XM_XSLT_NO_NODE_TEST is
			-- Singleton
		once
			create Result.make
		end

end
