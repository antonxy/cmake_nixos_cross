#include "simple_lib.hpp"

#include <output.hpp>

#include <boost/filesystem.hpp>

void Hello::say_hello() {
	write("Hello");
	boost::filesystem::exists("/tmp/foo");
}
