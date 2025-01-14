SUMMARY = "GTK GUI for ConnMan"
HOMEPAGE = "https://github.com/jgke/connman-gtk"
SECTION = "libs/network"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS = "gtk+3 dbus-glib glib-2.0-native"
RDEPENDS_${PN} = "connman"

SRCREV = "${AUTOREV}"
SRC_URI = "git://github.com/jgke/connman-gtk.git \
          "
S = "${WORKDIR}/git"

inherit meson gsettings pkgconfig features_check
ANY_OF_DISTRO_FEATURES = "${GTK3DISTROFEATURES}"

FILES_${PN} += "${datadir}/glib-2.0"

