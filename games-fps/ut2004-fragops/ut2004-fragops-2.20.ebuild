# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="realism mod"
MOD_NAME="Frag Ops"
MOD_DIR="FragOps"
MOD_ICON="Help/FragOps.ico"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/fragops"
SRC_URI="https://ut.rushbase.net/beyondunreal/mods/fragops_v220_fulllmw.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

src_prepare() {
	default
	rm -f *.TXT ${MOD_DIR}/*.bat || die
}
