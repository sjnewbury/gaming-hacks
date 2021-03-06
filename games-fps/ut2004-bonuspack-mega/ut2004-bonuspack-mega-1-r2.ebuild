# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOD_DESC="Megapack bonus pack"
MOD_NAME="Megapack"

inherit games-r1 games-mods-r1

MY_P="ut2004megapack-linux.tar.bz2"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="http://ut2004.ut-files.com/BonusPacks/${MY_P}"

LICENSE="ut2003"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	default

	mv -f UT2004MegaPack/* . || die
	rmdir UT2004MegaPack

	# Remove files in Megapack which are already installed
	rm -r Animations Speech Web

	rm Help/{ReadMePatch.int.txt,UT2004Logo.bmp}
	mv Help/BonusPackReadme.txt Help/MegapackReadme.txt

	rm Maps/ONS-{Adara,IslandHop,Tricky,Urban}.ut2
	rm Sounds/{CicadaSnds,DistantBooms,ONSBPSounds}.uax
	rm StaticMeshes/{BenMesh02,BenTropicalSM01,HourAdara,ONS-BPJW1,PC_UrbanStatic}.usx

	# System
	rm System/{AL,AS-,B,b,C,D,E,F,G,I,L,O,o,S,s,U,V,W,X,x}*
	rm System/{ucc,ut2004}-bin
	rm System/{ucc,ut2004}-bin-linux-amd64
	rm Textures/{AW-2k4XP,BenTex02,BenTropical01,BonusParticles,CicadaTex,Construction_S,HourAdaraTexor,jwfasterfiles,ONSBP_DestroyedVehicles,ONSBPTextures,PC_UrbanTex,UT2004ECEPlayerSkins}.utx
}
