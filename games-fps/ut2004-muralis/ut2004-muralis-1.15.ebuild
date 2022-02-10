# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="third-person hand-to-hand single/multiplayer mod"
MOD_NAME="Muralis"
MOD_DIR="muralis"

inherit unpacker games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/muralis"
SRC_URI="https://ut.rushbase.net/beyondunreal/mods/muralis-v${PV}-zip.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

src_prepare() {
	default
	mv -f Muralis ${MOD_DIR} || die
}
