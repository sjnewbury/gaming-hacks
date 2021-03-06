# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="Cute and violent hamster cage rampage mod"
MOD_NAME="Hamster Bash"
MOD_DIR="hamsterbash"

inherit unpacker games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/hamsterbash"
SRC_URI="HamsterBashFinal.zip"

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
	mv -f HamsterBash ${MOD_DIR} || die
	rm -rf System
}
