# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="Control Ki-powered superheros and battle in the air"
MOD_NAME="Bid For Power"
MOD_DIR="bfpq3"
MOD_ICON="bfp.ico"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.moddb.com/mods/bid-for-power"
SRC_URI="https://www.mirrorservice.org/sites/quakeunity.com/modifications/bidforpower/bidforpower${PV/./-}.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"
