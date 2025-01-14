RDEPENDS_${PN}  += "virtual/libgles2"

FILESEXTRAPATHS_prepend := "${THISDIR}/qtbase:"

DEPENDS += "mesa drm wayland wayland-protocols wayland-native"

PACKAGECONFIG_DEFAULT_append = " \
	freetype \
	fontconfig \
	eglfs \
	release \
	optimize-size \
	gles2 \
	openssl \
	journald \
	libinput \
	xkbcommon \
	kms \
	gbm \
	dbus \
	evdev \
	gtk \
	harfbuzz \
"

QT_CONFIG_FLAGS += " \
	-no-xcb \
	-no-bundled-xcb-xinput \
"

INSANE_SKIP_${PN} +="file-rdeps"
INSANE_SKIP_${PN}-plugins +="file-rdeps"

SET_QT_QPA_DEFAULT_PLATFORM = "wayland"

do_configure_prepend() {
cat >> ${S}/mkspecs/oe-device-extra.pri <<EOF
QT_QPA_DEFAULT_PLATFORM = ${SET_QT_QPA_DEFAULT_PLATFORM}
EOF
}

