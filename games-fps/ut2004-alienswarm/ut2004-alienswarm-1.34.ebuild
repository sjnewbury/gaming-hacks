# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-alienswarm/ut2004-alienswarm-1.32.ebuild,v 1.5 2011/08/04 07:32:55 tupone Exp $

EAPI=7

MOD_DESC="an overhead-view tactical squad-based shooter"
MOD_NAME="Alien Swarm"
MOD_DIR="AlienSwarm"
MOD_ICON="Help/Linux Icons/as-icon-64.png"

inherit games-r1 games-mods-r1

MY_PV=${PV/.}
AS_V="13"
PC_V="10"
TC_V="1_1"
N_SRC="http://www.night-blade.com/AS"
IAF_SRC="http://www.iaf-database.com/maps"

HOMEPAGE="http://www.blackcatgames.com/swarm/"
SRC_URI="${N_SRC}/AlienSwarm-v${AS_V}.zip
	mirror://gentoo/PhalanxASwCampaign${PC_V}.zip
	${IAF_SRC}/TelicCampaign_${TC_V}.zip
	http://www.bliny.co.uk/mirror/swarm/TelicCampaign_${TC_V}.zip
	${N_SRC}/AlienSwarm_13_to_${MY_PV}_Patch.zip"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated"

src_unpack() {
	# It is (surprisingly) deliberate to have Music & System dirs
	# outside of the main AlienSwarm dir. Not sure why. Is same with
	# LIFLG installer.
	unpack AlienSwarm-v${AS_V}.zip

	# Phalanx is the only file meant to be unzipped within AlienSwarm
	cd ${MOD_DIR} || die
	unpack PhalanxASwCampaign${PC_V}.zip
	cd ..

	unpack TelicCampaign_${TC_V}.zip
	unpack AlienSwarm_13_to_${MY_PV}_Patch.zip
}

src_prepare() {
	default
	rm -f SwarmReadMe.txt ${MOD_DIR}/{*.{bat,exe},Alien-Swarm-Linux}
}
