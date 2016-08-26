note
	description: "MATISSE-Eiffel Binding: define the Matisse Object class"
	license: "[
	The contents of this file are subject to the Matisse Interfaces 
	Public License Version 1.0 (the 'License'); you may not use this 
	file except in compliance with the License. You may obtain a copy of
	the License at http://www.matisse.com/pdf/developers/MIPL.html

	Software distributed under the License is distributed on an 'AS IS'
	basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See 
	the License for the specific language governing rights and
	limitations under the License.

	The Original Code was created by Matisse Software Inc. 
	and its successors.

	The Initial Developer of the Original Code is Matisse Software Inc. 
	Portions created by Matisse Software are Copyright (C) 
	Matisse Software Inc. All Rights Reserved.

	Contributor(s): Kazuhiro Nakao
                   Didier Cabannes
                   Neal Lester
                   Luca Paganotti
	]"


deferred class
	MT_OBJECT

inherit
	INTERNAL
		rename
			c_is_instance_of as internal_c_instance_of,
			is_instance_of as internal_instance_of
	   export
			{NONE} all
		undefine
			is_equal
		end
	ANY
		redefine
			is_equal
		end

feature {NONE} -- Initialization


feature -- Access

	-- Matisse Object ID
	oid: INTEGER_32

feature -- Comparison

	is_equal (other: like Current ): BOOLEAN
		-- Is current object equal to other according to ids?
		do
			Result := oid = other.oid
		end

feature -- interface

end -- class MT_OBJECT

