# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop cmake-utils

MY_PV=${PV/_pre/_PRE}

DESCRIPTION="A Doom 3 GPL source modification."
HOMEPAGE=https://github.com/RobertBeckebans/RBDOOM-3-BFG.git

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI=https://github.com/RobertBeckebans/RBDOOM-3-BFG.git
#	EGIT_BRANCH=PBR2
	EGIT_SUBMODULES=("-*")
	inherit git-r3
else
	SRC_URI="https://github.com/RobertBeckebans/RBDOOM-3-BFG/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libglvnd vulkan"

DEPEND="
	virtual/jpeg:0
	media-libs/libogg
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/openal
	net-misc/curl
	sys-libs/zlib:=
	vulkan? ( media-libs/shaderc )
"
RDEPEND="${DEPEND}"

[[ ${PV} == 9999* ]] || S="${WORKDIR}/${PN}-${MY_PV}"

CMAKE_USE_DIR="${S}/neo"

DATADIR=/usr/share/games/doom3bfg
DOCS="README.md"

# TODO: patch for common games-dir with roe and doom3-data

src_prepare() {
	eapply "${FILESDIR}"/SDL2.patch
	eapply "${FILESDIR}"/shaderc-shared.patch
	eapply "${FILESDIR}"/static-idlib.patch
	eapply "${FILESDIR}"/wayland-r1.patch
	eapply "${FILESDIR}"/hidpi.patch
#	eapply "${FILESDIR}"/PBR2-buildfix.patch
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DSDL2=ON
		-DUSE_PRECOMPILED_HEADERS=OFF
		-DUSE_VULKAN=$(usex vulkan)
		-DSPIRV_SHADERC=ON
		-DOpenGL_GL_PREFERENCE=$(usex libglvnd GLVND LEGACY)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	keepdir "${DATADIR}"
	dobin ${BUILD_DIR}/RBDoom3BFG

	#newicon "${CMAKE_USE_DIR}"/sys/linux/setup/image/doom3.png "${PN}".png
	make_desktop_entry "${PN}" "Doom 3 - RB-BFG"
}

pkg_postinst() {
	elog "You need to copy *.pk4 from either your installation media or your hard drive to"
	elog "${DATADIR}/base before running the game,"
	elog "or 'emerge games-fps/doom3-data' to install from CD."
	echo
}
