# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="Fast-paced first person sport mod"
MOD_NAME="Deathball"
MOD_DIR="deathball"
MOD_ICON="dbicon.ico"

inherit games-r1 games-mods-r1

HOMEPAGE="http://www.deathball.net/"
SRC_URI="http://www.deathball.net/downloads/deathball${PV/.}.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

src_prepare() {
	default
	cd ${MOD_DIR} || die
	mv -f ../*.txt . || die
	rm -f *.bat *.cmd *.db Help/*.db || die
}
