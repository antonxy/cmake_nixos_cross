set(FFmpeg_ALL_COMPONENTS avcodec avformat avutil swscale)

find_path(FFmpeg_INCLUDE_DIR NAMES libavcodec/avcodec.h)

foreach(_comp ${FFmpeg_ALL_COMPONENTS})
	find_library(FFmpeg_${_comp}_LIBRARY NAMES lib${_comp} lib${_comp}.so)
	if(FFmpeg_${_comp}_LIBRARY AND EXISTS "${FFmpeg_${_comp}_LIBRARY}")
		set(FFmpeg_${_comp}_FOUND TRUE)
	else()
		set(FFmpeg_${_comp}_FOUND FALSE)
	endif()
endforeach()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FFmpeg
	FOUND_VAR FFmpeg_FOUND
	REQUIRED_VARS
		FFmpeg_INCLUDE_DIR
	HANDLE_COMPONENTS
)

if(FFmpeg_FOUND)
	add_library(FFmpeg INTERFACE IMPORTED)

	foreach(_comp ${FFmpeg_FIND_COMPONENTS})
		add_library(FFmpeg::${_comp} UNKNOWN IMPORTED)
		set_target_properties(FFmpeg::${_comp} PROPERTIES
			IMPORTED_LOCATION "${FFmpeg_${_comp}_LIBRARY}"
			INTERFACE_INCLUDE_DIRECTORIES "${FFmpeg_INCLUDE_DIR}"
		)

		target_link_libraries(FFmpeg INTERFACE FFmpeg::${_comp})
	endforeach()
endif()
