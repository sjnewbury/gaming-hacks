# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="a terrorist vs. strike force mod"
MOD_NAME="Strike Force"
MOD_DIR="StrikeForce"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/strike-force-2004"
SRC_URI="https://ut.rushbase.net/beyondunreal/mods/strikeforce-ce-v${PV}.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

src_prepare() {
	default
	rm -f ${MOD_DIR}/*.exe
}
