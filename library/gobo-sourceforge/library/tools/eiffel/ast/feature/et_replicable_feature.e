indexing

	description:

		"Eiffel replicable features: features with the same seed"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class ET_REPLICABLE_FEATURE

inherit

	ANY -- Needed for SE 2.1.

	KL_IMPORTED_ANY_ROUTINES

feature -- Status report

	has_replication: BOOLEAN is
			-- Is current feature replicated?
		do
			-- Result := False
		end

feature -- Access

	replicated_feature: ET_REPLICATED_FEATURE is
			-- Current feature viewed as a replicated feature
		require
			has_replication: has_replication
		do
			check not_replicated: not has_replication end
		ensure
			definition: ANY_.same_objects (Result, Current)
		end

	first_feature: ET_ADAPTED_FEATURE is
			-- First feature with a given seed
		deferred
		ensure
			first_feature_not_void: Result /= Void
		end

feature -- Measurement

	selected_count: INTEGER is
			-- Number of selected features
		deferred
		end

invariant

	selected_count_positive: selected_count >= 0

end
