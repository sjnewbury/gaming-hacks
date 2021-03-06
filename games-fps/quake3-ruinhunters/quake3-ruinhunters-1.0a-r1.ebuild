# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="Anime mod with cartoon actors and arcade-like gameplay"
MOD_NAME="Ruin Hunters"
MOD_DIR="ruin"

inherit games-r1 games-mods-r1

HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="
	https://www.mirrorservice.org/sites/quakeunity.com/modifications/ruinhunters/ruin_hunters_v10.zip
	https://www.mirrorservice.org/sites/quakeunity.com/modifications/ruinhunters/ruin_hunters_v10a_patch.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_prepare() {
	default
	rm -f *.bat
}
