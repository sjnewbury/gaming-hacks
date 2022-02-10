# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="offhand grapple all-weapons capture the flag mod"
MOD_NAME="Loki's Revenge CTF"
MOD_DIR="lrctf"

inherit games-r1 games-mods-r1

HOMEPAGE="http://www.lrctf.com/"
SRC_URI="http://lrctf.com/release/LRCTF_Q3A_v${PV}_full.zip"

LICENSE="LRCTF"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"
