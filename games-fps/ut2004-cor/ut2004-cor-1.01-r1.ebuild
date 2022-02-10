# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="Shape-shifting robot teamplay mod"
MOD_NAME="Counter Organic Revolution"
MOD_DIR="COR"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/counter-organic-revolution"
SRC_URI="https://ut.rushbase.net/beyondunreal/mods/cor_beta_v1.0.zip
	https://ut.rushbase.net/beyondunreal/mods/cor_patch_b1_to_b101.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

src_prepare() {
	default
	rm -f ${MOD_DIR}/*.bat || die
}
