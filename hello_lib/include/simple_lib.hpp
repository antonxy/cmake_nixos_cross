#pragma once

#include <boost/filesystem.hpp>

class Hello {
public:
	void say_hello();
	boost::filesystem::path get_path();

	// This makes boost a public dependency
	void exists() {
		boost::filesystem::exists("/tmp/bar");
	}
};
