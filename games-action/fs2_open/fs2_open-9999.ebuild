# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils cmake-utils

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

SLOT="0"
IUSE="debug babylon freespace2 inferno speech"
RESTRICT="mirror"

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
		virtual/x11 )"

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

src_configure() {
	local mycmakeargs=(
		-DENABLE_DEBUG=$(usex debug)
		-DSPEECH=$(usex speech)
		-DINFERNO=$(usex inferno)
	)

       cmake-utils_src_configure
}

src_install() {
	if use debug; then
		DEBUG_SUFFIX=_d
	else
		DEBUG_SUFFIX=_r
	fi

	if use inferno; then
		INF_SUFFIX=_INF
	else
		INF_SUFFIX=
	fi

	newicon code/freespace2/app_icon.png fs2_open.png

	if use babylon; then
		exeinto "${TBPDATA}"
		sed -e "s/.fs2_open/.babylon5/g" code/${PN}${INF_SUFFIX}${DEBUG_SUFFIX} > code/babylon || die "Hardcoding binary failed"
		newexe code/babylon babylon || die "Copying binary failed"
		dosym ${TBPDATA}/babylon /usr/bin/babylon || die "dosym failed"
		make_desktop_entry babylon "The babylon project" || die "Making desktop entry failed"
	fi
	if use freespace2; then
		exeinto "${FS2DATA}"
		newexe code/${PN}${INF_SUFFIX}${DEBUG_SUFFIX} freespace2 || die "Copying binary failed"
		dosym ${FS2DATA}/freespace2 /usr/bin/freespace2 || die "dosym failed"
		make_desktop_entry freespace2 "Freespace2 project" || die "Making desktop entry failed"
	fi

	dodoc AUTHORS ChangeLog COPYING NEWS README FS2OpenSCPReadMe.doc
}

pkg_postinst() {
	if use babylon && ! use inferno; then
		elog "Please, for full advantage of TBP, enable inferno useflag too and rebuild!"
	fi
}