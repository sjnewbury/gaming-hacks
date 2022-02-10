# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="Action movie mod"
MOD_NAME="Action"
MOD_DIR="action"
MOD_ICON="aut.ico"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/action-unreal-tournament/addons/action-unreal-tournament-r1"
SRC_URI="https://ut.rushbase.net/beyondunreal/mods/aut-r1-msuc.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

src_unpack() {
	mkdir ${MOD_DIR} || die
	cd ${MOD_DIR} || die
	unpack ${A}
}
