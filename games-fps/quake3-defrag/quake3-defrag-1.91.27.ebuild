# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MOD_DESC="Trickjumping challenges for Quake III"
MOD_NAME="Defrag"
MOD_DIR="defrag"

inherit games-r1 games-mods-r1

HOMEPAGE="http://q3df.org/"
SRC_URI="http://q3defrag.org/files/defrag/defrag_${PV}.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragcpmpak01.zip
	http://slashbunny.com/aur/quake3-defrag-maps/df-extras002.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak1.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak2.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak3.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak4.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak5.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak7.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak8.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak9.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak10.zip
	http://slashbunny.com/aur/quake3-defrag-maps/defragpak11.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_unpack() {
	unpack defrag_${PV}.zip
	cd ${MOD_DIR} || die
	unpack defragpak{1,2,3,4,5,7,8,9,10,11}.zip
	unpack defragcpmpak01.zip
	unpack df-extras002.zip
}

src_prepare() {
	default
	cd ${MOD_DIR} || die
	mv -f DeFRaG/* . || die
	rm -rf DeFRaG || die
	mv -f *.txt docs/ || die
	rm -rf misc/{mirc-script,misc,tools} || die
}
