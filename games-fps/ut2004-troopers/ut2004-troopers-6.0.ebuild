# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="Star Wars mod"
MOD_NAME="Troopers"
MOD_DIR="Troopers"
MOD_ICON="Help/Troopers.ico"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/troopers-dawn-of-destiny/"
SRC_URI="troopersversion${PV/.}zip.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"
RESTRICT="fetch"

pkg_nofetch() {
	elog "Please download ${SRC_URI} from:"
	elog "${HOMEPAGE}"
	elog "and move it to your DISTDIR directory."
}

src_prepare() {
	default
	rm -f ${MOD_DIR}/*.{bat,sh}
}
