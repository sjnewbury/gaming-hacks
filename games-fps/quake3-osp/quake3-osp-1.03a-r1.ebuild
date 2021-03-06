# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="a tournament mod"
MOD_NAME="OSP"
MOD_DIR="osp"

inherit games-r1 games-mods-r1

HOMEPAGE="http://www.orangesmoothie.org/"
SRC_URI="http://osp.dget.cc/orangesmoothie/downloads/osp-Quake3-${PV}_full.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_prepare() {
	default
	cd ${MOD_DIR} || die
	rm -f VoodooStats-ReadMe.txt *.exe || die
	rm -rf voodoo || die
}
