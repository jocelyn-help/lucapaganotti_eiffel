indexing

	description:

		"Hash tables, implemented with single arrays. %
		%Keys are hashed using `hash_code' from HASHABLE by default."

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2000-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_HASH_TABLE [G, K -> HASHABLE]

inherit

	DS_ARRAYED_SPARSE_TABLE [G, K]
		redefine
			new_cursor
		end

create

	make,
	make_equal,
	make_default,
	make_map,
	make_map_equal,
	make_map_default,
	make_with_equality_testers

feature -- Access

	new_cursor: DS_HASH_TABLE_CURSOR [G, K] is
			-- New external cursor for traversal
		do
			create Result.make (Current)
		end

feature -- Hashing

	hash_function: KL_HASH_FUNCTION [K]
			-- Hash function to compute position in the container

	set_hash_function (a_hash_function: like hash_function) is
			-- Set `hash_function' to `a_hash_function'.
		require
			empty: is_empty
		do
			hash_function := a_hash_function
		ensure
			hash_function_set: hash_function = a_hash_function
		end

feature {NONE} -- Implementation

	hash_position (k: K): INTEGER is
			-- Hash position of `k' in `slots';
			-- Use `hash_function' as hashing function
			-- if not Void, `k.hash_code' otherwise.
		do
			if k /= Void then
				if hash_function /= Void then
					Result := hash_function.hash_code (k) \\ modulus
				else
					Result := k.hash_code \\ modulus
				end
			else
				Result := modulus
			end
		end

end
