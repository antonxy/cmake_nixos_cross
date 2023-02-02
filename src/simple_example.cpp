#include "simple_lib.hpp"

extern "C" {
	#include <libavcodec/avcodec.h>
}

int main() {
	Hello hello;
	hello.say_hello();
	hello.exists();

	const AVCodec * codec = avcodec_find_decoder_by_name("h264");
	return 0;
}
