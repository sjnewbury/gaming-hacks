# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="Makes the weapons much faster and stronger"
MOD_NAME="Excessive Plus"
MOD_DIR="excessiveplus"
MOD_ICON="excessiveplus.ico"

inherit games-r1 games-mods-r1

HOMEPAGE="https://www.excessiveplus.net"
SRC_URI="https://www.excessiveplus.net/files/release/xp-${PV}.zip"

LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_prepare() {
	default
	rm -f *.bat
	rm -rf ${MOD_DIR}/tools
}
