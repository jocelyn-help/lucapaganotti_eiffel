indexing

	description:

		"Generates C glue header for callback wrappers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2004/10/24 17:36:19 $"
	revision: "$Revision: 1.9 $"

class EWG_C_GLUE_HEADER_ANSI_C_CALLBACK_WRAPPER_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR
		redefine
			make_internal
		end

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

creation

	make

feature {NONE} -- Initialization

	make_internal is
		do
			Precursor
			make_printers
		end

	make_printers is
		do
			create declaration_printer.make (output_stream)
			create parameter_list_printer.make (output_stream, declaration_printer)
		end

feature -- Generation

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET) is
		local
			cs: DS_BILINEAR_CURSOR [EWG_CALLBACK_WRAPPER]
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			file_name := directory_structure.callback_c_glue_header_file_name (eiffel_compiler_mode.eiffel_compiler_mode)
			create file.make (file_name)
			file.recursive_open_write
			if not file.is_open_write then
				error_handler.report_cannot_write_error (file_name)
			else
				output_stream := file
				make_printers
				output_stream.put_string ("#ifndef EWG_CALLBACK_")
				output_stream.put_string (STRING_.as_upper(directory_structure.config_system.name))
				output_stream.put_line ("___")
				output_stream.put_string ("#define EWG_CALLBACK_")
				output_stream.put_string (STRING_.as_upper(directory_structure.config_system.name))
				output_stream.put_line ("___")
				output_stream.put_new_line
				from
					cs := a_eiffel_wrapper_set.new_callback_wrapper_cursor
					cs.start
				until
					cs.off
				loop
					generate_callback_wrapper (cs.item)
					cs.forth
					error_handler.tick
				end
				output_stream.put_line ("#endif")
				file.close
			end
		end

feature {NONE} -- Implementation

	generate_callback_wrapper (a_callback_wrapper: EWG_CALLBACK_WRAPPER) is
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		do
			output_stream.put_string ("#include <")
			output_stream.put_string (a_callback_wrapper.header_file_name)
			output_stream.put_line (">")
			output_stream.put_new_line
			generate_typedef (a_callback_wrapper)
			generate_stub_getter_prototype (a_callback_wrapper)
			generate_entry_struct (a_callback_wrapper)
			generate_entry_setter_prototype (a_callback_wrapper)
			generate_caller_declaration_prototype (a_callback_wrapper)
			output_stream.put_new_line
		end

	generate_typedef (a_callback_wrapper: EWG_CALLBACK_WRAPPER) is
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			function_pointer: EWG_C_AST_POINTER_TYPE
			function: EWG_C_AST_FUNCTION_TYPE
			members: DS_ARRAYED_LIST [EWG_C_AST_DECLARATION]
			declarator: STRING
			declaration: EWG_C_AST_DECLARATION
			cs: DS_LINEAR_CURSOR [EWG_C_AST_DECLARATION]
		do
			create members.make (a_callback_wrapper.c_pointer_type.function_type.members.count + 1)
			create declaration.make ("a_class",
											 c_system.types.void_pointer_type,
											 directory_structure.relative_callback_c_glue_header_file_name)
			members.force_last (declaration)
			from
				cs := a_callback_wrapper.c_pointer_type.function_type.members.new_cursor
				cs.start
			until
				cs.off
			loop
				create declaration.make (cs.item.declarator, cs.item.type,
												 directory_structure.relative_callback_c_glue_header_file_name)
				members.force_last (declaration)
				cs.forth
			end
			create function.make (directory_structure.relative_callback_c_glue_header_file_name,
										 a_callback_wrapper.c_pointer_type.function_type.return_type,
										 members)
			create function_pointer.make (directory_structure.relative_callback_c_glue_header_file_name,
													function)
			declarator := clone (a_callback_wrapper.mapped_eiffel_name)
			declarator.append_string ("_eiffel_feature")
			output_stream.put_string ("typedef ")
			declaration_printer.print_declaration_from_type (function_pointer, declarator)
			output_stream.put_line (";")
			output_stream.put_new_line
		end

	generate_stub_getter_prototype (a_callback_wrapper: EWG_CALLBACK_WRAPPER) is
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		do
			output_stream.put_string ("void* get_")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_stub ();")
			output_stream.put_new_line
		end

	generate_entry_struct (a_callback_wrapper: EWG_CALLBACK_WRAPPER) is
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		do
			output_stream.put_string ("struct ")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_entry_struct")
			output_stream.put_line ("{")
			output_stream.put_line ("%Tvoid* a_class;")
			output_stream.put_string ("%T")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_eiffel_feature feature;")
			output_stream.put_line ("};")
			output_stream.put_new_line
		end

	generate_entry_setter_prototype (a_callback_wrapper: EWG_CALLBACK_WRAPPER) is
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		do
			output_stream.put_string ("void set_")
			output_stream.put_string (a_callback_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_entry (void* a_class, void* a_feature);")
			output_stream.put_new_line
		end

	generate_caller_declaration_prototype (a_callback_wrapper: EWG_CALLBACK_WRAPPER) is
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			function: EWG_C_AST_FUNCTION_TYPE
			members: DS_ARRAYED_LIST [EWG_C_AST_DECLARATION]
			declarator: STRING
			declaration: EWG_C_AST_DECLARATION
			cs: DS_LINEAR_CURSOR [EWG_C_AST_DECLARATION]
		do
			create members.make (a_callback_wrapper.c_pointer_type.function_type.members.count + 1)
			create declaration.make ("a_function",
											 c_system.types.void_pointer_type,
											 directory_structure.relative_callback_c_glue_header_file_name)
			members.force_last (declaration)
			from
				cs := a_callback_wrapper.c_pointer_type.function_type.members.new_cursor
				cs.start
			until
				cs.off
			loop
				create declaration.make (cs.item.declarator, cs.item.type,
												 directory_structure.relative_callback_c_glue_header_file_name)
				members.force_last (declaration)
				cs.forth
			end
			create function.make (directory_structure.relative_callback_c_glue_header_file_name,
										 a_callback_wrapper.c_pointer_type.function_type.return_type,
										 members)

			declarator := clone ("call_")
			declarator.append_string (a_callback_wrapper.mapped_eiffel_name)
			declaration_printer.print_declaration_from_type (function, declarator)
			output_stream.put_line (";")
			output_stream.put_new_line
		end

	parameter_list_printer: EWG_C_DECLARATION_LIST_PRINTER
	declaration_printer: EWG_C_DECLARATION_PRINTER

invariant

	declaration_printer_not_void: declaration_printer /= Void
	parameter_list_printer_not_void: parameter_list_printer /= Void

end
