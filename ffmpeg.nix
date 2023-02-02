{ stdenv, fetchurl, pkgconfig, perl, texinfo, yasm, lib, withBinaries ? false
}:

let
  inherit (lib) optional optionals enableFeature;

  demuxers = [ "avi" "matroska,webm" "mjpeg" "mov,mp4,m4a,3gp,3g2,mj2" "mpeg" ];
  demuxerFlags = builtins.map (m: "--enable-demuxer=" + m) demuxers;
  muxers = [ "matroska" ];
  muxerFlags = builtins.map (m: "--enable-muxer=" + m) muxers;
  decoders = [ "012v" "apng" "av1" "bmp" "ffv1" "ffvhuff" "gif" "h261" "h263" "h263i" "h263p" "h264" "h264_cuvid" "hevc" "hevc_cuvid" "huffyuv" "hymt" "jpeg2000" "jpegls" "mjpeg" "mjpeg_cuvid" "mjpegb" "mpeg1video" "mpeg1_cuvid" "mpeg2video" "mpegvideo" "mpeg2_cuvid" "mpeg4" "mpeg4_cuvid" "msmpeg4v1" "msmpeg4v2" "msmpeg4" "mss1" "mss2" "msvideo1" "png" "prores" "r210" "rawvideo" "theora" "tiff" "v210" "v210x" "v308" "v408" "v410" "vc1" "vc1_cuvid" "vc1image" "vp3" "vp4" "vp5" "vp6" "vp6a" "vp6f" "vp7" "vp8" "libvpx" "vp8_cuvid" "vp9" "libvpx-v9" "vp9_cuvid" "webp" "wmv1" "wmv2" "wmv3" "wmv3image" "wrapped_avfr" "y41p" "ylc" "yuv4" ];
  decoderFlags = builtins.map (m: "--enable-decoder=" + m) decoders;
  encoders = [ "mjpeg" "ffv1" "rawvideo" ];
  encoderFlags = builtins.map (m: "--enable-encoder=" + m) encoders;
  protocols = [ "file" ];
  protocolFlags = builtins.map (m: "--enable-protocol=" + m) protocols;

  target_os = if stdenv.hostPlatform.isMinGW then
                "mingw32"
              else if stdenv.hostPlatform.isLinux then
                "linux"
              else
                 (assert false; "Don't know the taget_os");
in

stdenv.mkDerivation rec {

  name = "ffmpeg-${version}";
  version = "${branch}";
  branch = "5.1.2";
  sha256 = "sha256-OaC8yNmFSfFsVwYkZ4JGpqxzbAZs69tAn5UC6RWyLys=";

  src = fetchurl {
    url = "https://www.ffmpeg.org/releases/${name}.tar.bz2";
    inherit sha256;
  };

  configurePlatforms = [ ];

  configureFlags = [
    # License
      "--enable-version3"
    # Build flags
      "--enable-shared"
      "--disable-static"
      "--enable-pic"
      "--enable-gray"
      "--disable-network"
    # Binaries
      (if withBinaries then "" else "--disable-programs")
    # Libraries
      "--enable-avcodec"
      "--enable-avformat"
      "--enable-avutil"
      "--enable-swscale"
      "--disable-swresample"
      "--disable-avdevice"
      "--disable-avfilter"
    # Components
      "--disable-devices"
      "--disable-filters"
      "--disable-bsfs"

      "--disable-demuxers"
      "--disable-muxers"
      "--disable-decoders"
      "--disable-encoders"
      "--disable-protocols"
  ]
  ++ demuxerFlags
  ++ muxerFlags
  ++ decoderFlags
  ++ encoderFlags
  ++ protocolFlags
  ++ [
    # Docs
      "--disable-doc"
    # Cross
      "--arch=${stdenv.hostPlatform.parsed.cpu.name}"
      "--target_os=${target_os}"
  ] ++ optionals (stdenv.hostPlatform != stdenv.buildPlatform) [
      "--cross-prefix=${stdenv.cc.targetPrefix}"
      "--enable-cross-compile"
  ] ++ optional stdenv.cc.isClang "--cc=clang";

  nativeBuildInputs = [ perl pkgconfig texinfo yasm ];

  buildInputs = [
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "A complete, cross-platform solution to record, convert and stream audio and video";
    homepage = http://www.ffmpeg.org/;
    longDescription = ''
      FFmpeg is the leading multimedia framework, able to decode, encode, transcode, 
      mux, demux, stream, filter and play pretty much anything that humans and machines 
      have created. It supports the most obscure ancient formats up to the cutting edge. 
      No matter if they were designed by some standards committee, the community or 
      a corporation. 
    '';
    license = [licenses.lgpl3];
    platforms = platforms.all;
  };
}
