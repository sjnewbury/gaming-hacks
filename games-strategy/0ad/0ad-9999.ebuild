# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

WX_GTK_VER="3.0"

EGIT_REPO_URI=https://github.com/0ad/0ad.git

if [[ ${PV} == 9999* ]]; then
	GIT_ECLASS="git-r3"
fi

inherit eutils wxwidgets toolchain-funcs flag-o-matic desktop xdg-utils ${GIT_ECLASS}

MY_P=0ad-${PV/_/-}
DESCRIPTION="A free, real-time strategy game"
HOMEPAGE="http://play0ad.com/"

if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/zero-ad/${MY_P}-unix-build.tar.xz"
fi

LICENSE="GPL-2 LGPL-2.1 MIT CC-BY-SA-3.0 ZLIB"
SLOT="0"
KEYWORDS=""
IUSE="editor +lobby nvtt pch sound test"
RESTRICT="test"

RDEPEND="
	dev-libs/boost
	dev-libs/icu:=
	dev-libs/libxml2
	dev-libs/nspr
	media-libs/libpng:0
	media-libs/libsdl2[X,opengl,video]
	net-libs/enet:1.3
	net-libs/miniupnpc:=
	net-misc/curl
	sys-libs/zlib
	virtual/jpeg:0
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXcursor
	editor? ( x11-libs/wxGTK:${WX_GTK_VER}[X,opengl] )
	lobby? ( net-libs/gloox )
	nvtt? ( media-gfx/nvidia-texture-tools )
	sound? ( media-libs/libvorbis
		media-libs/openal )"
DEPEND="${RDEPEND}
	=dev-lang/spidermonkey-78.6.0:78
	virtual/pkgconfig
	test? ( dev-lang/perl )"

PDEPEND="~games-strategy/0ad-data-${PV}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	eapply "${FILESDIR}"/${P}-gentoo-r1.patch
#	eapply "${FILESDIR}"/${PN}-0.0.19_alpha-miniupnpc14.patch
#	eapply "${FILESDIR}"/${P}-spidermonkey-cxxflags.patch
	#eapply "${FILESDIR}"/${P}-GL4.patch
#	eapply "${FILESDIR}"/${P}-gcc10.patch
#	eapply "${FILESDIR}"/${P}-hidpi.patch
	# Make COLLADA plugins happy
	strip-flags

#	sed -i -e '/#if MOZJS_MINOR_VERSION/s/6/7/' source/scriptinterface/ScriptTypes.h || die version bump

	sed -i -e 's/MOZJS_MINOR_VERSION.*/0/' source/scriptinterface/ScriptTypes.h || die spidermonkey minor hack
	rm -rf libraries/source/spidermonkey || die failed to remove bundled spidermonkey
	default
}

src_configure() {
	local myconf=(
		--with-system-mozjs
		--with-system-nvtt
#		--with-system-miniupnpc
		--minimal-flags
		$(usex nvtt "" "--without-nvtt")
		$(usex pch "" "--without-pch")
		$(usex test "" "--without-tests")
		$(usex sound "" "--without-audio")
		$(usex editor "--atlas" "")
		$(usex lobby "" "--without-lobby")
		--bindir="/usr/bin"
		--libdir="/usr/$(get_libdir)"/${PN}
		--datadir="/usr/share/games/${PN}"
		)

	# stock premake4/5 does not work, use the shipped one
	emake -C "${S}"/build/premake/premake5/build/gmake2.unix

	# regenerate scripts.c so our patch applies
	cd "${S}"/build/premake/premake5 || die
	"${S}"/build/premake/premake5/bin/release/premake5 embed || die

	# rebuild premake again... this is the most stupid build system
	emake -C "${S}"/build/premake/premake5/build/gmake2.unix clean
	emake -C "${S}"/build/premake/premake5/build/gmake2.unix

	# run premake to create build scripts
	cd "${S}"/build/premake || die
	"${S}"/build/premake/premake5/bin/release/premake5 \
		--file="premake5.lua" \
		--outpath="../workspaces/gcc/" \
		--os=linux \
		"${myconf[@]}" \
		gmake || die "Premake failed"
}

src_compile() {
	tc-export AR

	# build bundled and patched spidermonkey
	#cd libraries/source/spidermonkey || die
	#JOBS="${MAKEOPTS}" ./build.sh || die
	#cd "${S}" || die

	# build 3rd party fcollada
	emake -C libraries/source/fcollada/src

	# build 0ad
	emake -C build/workspaces/gcc verbose=1
}

src_test() {
	cd binaries/system || die
	./test -libdir "${S}/binaries/system" || die "test phase failed"
}

src_install() {
	# Needs to be available for building 0ad-data
	dobin binaries/system/pyrogenesis 
	dosym /usr/bin/pyrogenesis /usr/bin/0ad
	use editor && newbin binaries/system/ActorEditor 0ad-ActorEditor

	insinto /usr/share/games/${PN}
	doins -r binaries/data/l10n

	# Need to be available for building 0ad-data
	insinto "/usr/$(get_libdir)"/${PN}
	doins binaries/system/libCollada.so
	#doins libraries/source/spidermonkey/lib/*.so
	use editor && doins binaries/system/libAtlasUI.so

	dodoc binaries/system/readme.txt
	doicon -s 128 build/resources/${PN}.png
	make_desktop_entry ${PN}
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
