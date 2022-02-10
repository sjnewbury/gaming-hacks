# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="a US Navy Seals conversion mod"
MOD_NAME="Navy Seals: Covert Operations"
MOD_DIR="seals"

inherit games-r1 games-mods-r1

HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://www.mirrorservice.org/sites/quakeunity.com/modifications/navyseals/nsco_beta19.zip
	https://www.mirrorservice.org/sites/quakeunity.com/modifications/navyseals/nsco_beta193upd.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"
RESTRICT="strip mirror"

src_prepare() {
	default
	rm -rf seals/launch* || die
}
