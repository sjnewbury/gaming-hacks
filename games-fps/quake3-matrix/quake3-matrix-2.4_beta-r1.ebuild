# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="Matrix conversion mod"
MOD_NAME="Matrix"
MOD_DIR="matrix"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/matrix-quake-3"
SRC_URI="https://www.mirrorservice.org/sites/quakeunity.com/modifications/matrix24.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_unpack() {
	mkdir ${MOD_DIR} || die
	cd ${MOD_DIR} || die
	unpack ${A}
}
