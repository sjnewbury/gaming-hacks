# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="advanced FPS competition mod"
MOD_NAME="Challenge Pro Mode Arena"
MOD_DIR="cpma"

inherit games-r1 games-mods-r1

HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://cdn.playmorepromode.com/files/cpma/cpma-${PV}-nomaps.zip
	https://cdn.playmorepromode.com/files/cpma-mappack-full.zip"

LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_prepare() {
	default
	mv -f *.pk3 ${MOD_DIR} || die
}

pkg_postinst() {
	games-mods-r1_pkg_postinst
	elog "To enable bots: +bot_enable 1"
}
