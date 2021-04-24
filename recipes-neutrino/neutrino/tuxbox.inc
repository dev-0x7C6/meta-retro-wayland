HOMEPAGE = "http://www.tuxbox.org"
MAINTAINER = "Tuxbox-Developers"

SRC_URI_append = " \
	git://github.com/tuxbox-neutrino/gui-neutrino.git;protocol=https \
	file://0001-hdd_menu.cpp-assume-device-mounted.patch \
	file://0001-neutrino.cpp-adjust-resolution-for-generic-hardware.patch \
	file://0001-fix-int-resolution.patch \
"

PV = "3.13.0-${SRCPV}"

DEFAULT_THEME ?= "Neutrino-3.0"

EXTRA_OECONF_append += " \
	--with-default-theme=${DEFAULT_THEME} \
	--with-stb-hal-includes=${STAGING_INCDIR}/libstb-hal \
	--with-boxtype=generic \
	--with-stb-hal-includes=${STAGING_INCDIR}/libstb-hal \
"

do_install_append += "mv -f ${D}${RETRO_USER_HOMEDIR}/.config/neutrino/config/bad_package_pattern.list.sample ${D}${RETRO_USER_HOMEDIR}/.config/neutrino/config/bad_package_pattern.list"


