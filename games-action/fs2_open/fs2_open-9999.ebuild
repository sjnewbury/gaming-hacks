# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils cmake-utils desktop

MY_PV=$(ver_rs 1- '_')
MY_P="${PN}_${MY_PV}"

DESCRIPTION="Freespace2 SCP"
HOMEPAGE="http://scp.indiegames.us/"

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI=https://github.com/scp-fs2open/fs2open.github.com.git
	inherit git-r3
else
	SRC_URI="http://swc.fs2downloads.com/builds/${MY_P}_src.tgz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="fs2_open"

PATCHES=("${FILESDIR}/lz4-pkgconfig.patch")

SLOT="0"
IUSE="debug babylon freespace2"
RESTRICT="mirror"

REQUIRED_USE="|| ( babylon freespace2 )"

RDEPEND="media-libs/libogg
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/libtheora
	media-libs/openal
	virtual/opengl
	|| (
		(	media-libs/mesa
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXext )
		virtual/x11 )
	dev-cpp/antlr-cpp"

DEPEND="${RDEPEND}"

dir=/usr/share/${PN}

pkg_setup() {
	if use freespace2 ; then
		FS2DATA=/opt/fso/freespace2
	fi
	if use babylon ; then
		TBPDATA=/opt/fso/babylon
	fi
}

src_prepare() {
	#sed -i -e '/ADD_SUBDIRECTORY(lib)/s/^/#/' CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DFSO_BUILD_WITH_OPENGL=ON
		-DFSO_BUILD_WITH_VULKAN=OFF
		-DFSO_FREESPACE_PATH="${FS2DATA}"
		-DFSO_BUILD_INCLUDED_LIBS=OFF
		-DENABLE_DEBUG=$(usex debug)
	)

	cmake-utils_src_configure
}

src_install() {
	newicon freespace2/resources/app_icon.png fs2_open.png

	pushd "${BUILD_DIR}"

	if use babylon; then
		exeinto "${TBPDATA}"
		sed -e "s/.fs2_open/.babylon5/g" bin/${PN} > bin/babylon || die "Hardcoding binary failed"
		newexe bin/babylon babylon || die "Copying binary failed"
		doexe ${FILESDIR}/babylon || die "Failed to install start script"
		#dosym ${TBPDATA}/babylon /usr/bin/babylon || die "dosym failed"
		make_desktop_entry babylon "The babylon project" || die "Making desktop entry failed"
		insinto "${TBPDATA}"
		doins bin/libRocket*.so
	fi
	if use freespace2; then
		exeinto "${FS2DATA}"
		newexe bin/${PN}* freespace2 || die "Copying binary failed"
		exeinto /usr/bin
		doexe ${FILESDIR}/freespace2 || die "Failed to install start script"
		#dosym ${FS2DATA}/freespace2 /usr/bin/freespace2 || die "dosym failed"
		make_desktop_entry freespace2 "Freespace2 project" || die "Making desktop entry failed"
		insinto "${FS2DATA}"
		doins bin/libRocket*.so
	fi

	popd

	dodoc About.md Authors.md Changelog.md Copying.md NEWS Readme.md
}

pkg_postinst() {
	if use babylon && ! use inferno; then
		elog "Please, for full advantage of TBP, enable inferno useflag too and rebuild!"
	fi
}
