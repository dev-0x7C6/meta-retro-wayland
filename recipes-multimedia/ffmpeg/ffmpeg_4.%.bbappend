FILESEXTRAPATHS_prepend := "${THISDIR}/ffmpeg:"

SRC_URI = " \
	https://github.com/xbmc/FFmpeg/archive/${PV}.tar.gz \
	file://mips64_cpu_detection.patch \
	file://0001-libavutil-include-assembly-with-full-path-from-sourc.patch \
	file://4_02_fix_mpegts.patch \
	file://4_03_allow_to_choose_rtmp_impl_at_runtime.patch \
	file://4_04_hls_replace_key_uri.patch \
	file://4_06_optimize_aac.patch \
	file://4_07_increase_buffer_size.patch \
	file://4_08_recheck_discard_flags.patch \
	file://4_09_ffmpeg_fix_edit_list_parsing.patch \
	file://4_10_rtsp_patch \
	file://4_11_dxva2_patch \
	file://4_A02-corrupt-h264-frames.patch \
	file://4_A11-FFmpeg-devel-amfenc-Add-support-for-pict_type-field.patch \
	file://ffmpeg-001-libreelec.patch \
	file://ffmpeg-0002-WIP-deint-filter.patch \
	file://ffmpeg-0003-libavfilter-v4l2deinterlace-dequeue-both-destination.patch \
"

SRC_URI_append_rpi = "	\
	file://rpi/ffmpeg-rpi.patch \
	file://rpi/workaround-header-issue.patch \
"
	
SRC_URI_append_rockchip = " \
	file://ffmpeg-001-v4l2-request.patch \
	file://ffmpeg-001-v4l2-drmprime.patch \
"

SRC_URI[sha256sum] = "c2558449f1eddb6b13ed168288388c7804049c2af8d6db4952ccd6b4af6e9fdd"

PV = "4.3.2-Matrix-19.1"
S = "${WORKDIR}/FFmpeg-${PV}"

PACKAGECONFIG[libass] = "--enable-libass,--disable-libass,libass"
PACKAGECONFIG[libfreetype] = "--enable-libfreetype,--disable-libfreetype,freetype"
PACKAGECONFIG[librtmp] = "--enable-librtmp,--disable-librtmp,rtmpdump"
PACKAGECONFIG[wavpack] = "--enable-libwavpack,--disable-libwavpack,wavpack"
PACKAGECONFIG[webp] = "--enable-libwebp,--disable-libwebp,libwebp"
PACKAGECONFIG[libv4l2] = "--enable-libv4l2,--disable-libv4l2,v4l-utils"
PACKAGECONFIG[pulseaudio] = "--enable-libpulse,--disable-libpulse,pulseaudio"
PACKAGECONFIG[libdrm] = "--enable-libdrm,--disable-libdrm,libdrm"

PACKAGECONFIG_append = " \
	librtmp \
	libvorbis \
	mp3lame \
	openssl \
	pulseaudio \
	vpx \
	webp \
	wavpack \
	libv4l2 \
	libdrm \
	gpl \
	x264 \
"

inherit retro-overrides

VAAPISUPPORT_rockchip = "0"
VDPAUSUPPORT_armarch = "0"

EXTRA_FFCONF = " \
	--prefix=${prefix} \
	--disable-static \
	--disable-runtime-cpudetect \
	--disable-doc \
	--disable-fast-unaligned \	
	--disable-htmlpages \
	--disable-manpages \
	--disable-podpages \
	--disable-txtpages \
	--disable-debug \
	--disable-altivec \
	--enable-inline-asm \
	--enable-asm \
	--enable-muxers \
	--enable-encoders \
	--enable-decoders \
	--enable-demuxers \
	--enable-ffprobe \
	--enable-nonfree \
	--enable-parsers \
	--enable-bsfs \
	--enable-protocols \
	--enable-indevs \
	--enable-outdevs \
	--enable-filters \
	--enable-libudev \
	--enable-hwaccels \
	--enable-optimizations \
	--enable-pthreads \
	--enable-postproc \
	--enable-network \
	--enable-swscale \
	--disable-gray \
	--enable-swscale-alpha \
	--disable-small \
	--enable-dct \
	--enable-fft \
	--enable-mdct \
	--enable-rdft \
	--disable-crystalhd \
	--extra-ldflags="${TARGET_LDFLAGS},--gc-sections -Wl,--print-gc-sections,-lrt" \
	--extra-cflags="${TARGET_CFLAGS} ${HOST_CC_ARCH}${TOOLCHAIN_OPTIONS} -ffunction-sections -fdata-sections -fno-aggressive-loop-optimizations" \
"

EXTRA_FFCONF_append_armarch = " \
	--disable-amd3dnow \
	--disable-amd3dnowext \
	--disable-mmx \
	--disable-mmxext \
	--disable-sse \
	--disable-sse2 \
	--disable-sse3 \
	--disable-ssse3 \
	--disable-sse4 \
	--disable-sse42 \
	--disable-x86asm \
	--disable-avx \
	--disable-xop \
	--disable-fma3 \
	--disable-fma4 \
	--disable-avx2 \
	--enable-v4l2-request \
	--enable-v4l2-m2m \
	${@bb.utils.contains("TARGET_ARCH", "arm", "--enable-armv6 --enable-armv6t2 --enable-vfp --enable-neon", "", d)} \
	${@bb.utils.contains("TUNE_FEATURES", "aarch64", "--enable-armv8 --enable-vfp --enable-neon", "", d)} \
"

EXTRA_FFCONF_append_rpi = " \
	--disable-rpi \
	--enable-sand \
	--disable-mmal \
	--disable-hwaccel=h264_v4l2request \
	--disable-hwaccel=mpeg2_v4l2request \
	--disable-hwaccel=vp8_v4l2request \
	--disable-hwaccel=vp9_v4l2request \
"

LICENSE_FLAGS_WHITELIST = "commercial"

