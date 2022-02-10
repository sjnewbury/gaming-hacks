# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit gnustep-2 games-r1 flag-o-matic

DESCRIPTION="Elite space trading & warfare remake"
HOMEPAGE="http://oolite.org/"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/OoliteProject/oolite"
	SRC_URI=
else
	FF_JS_URI="http://jens.ayton.se/oolite/deps/firefox-4.0.source.js-only.tbz"
	BINRES_REV=f5aed27fefc32c24775b39fce25402b970b09b84
	SRC_URI="https://github.com/OoliteProject/oolite/archive/${PV}.tar.gz -> ${P}.tar.gz
		http://github.com/OoliteProject/oolite-binary-resources/archive/${BINRES_REV}.zip -> oolite-binary-resources-${PV}.zip
		${FF_JS_URI}"
KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="${IUSE} debug"

RDEPEND="virtual/opengl
		gnustep-base/gnustep-gui
		media-libs/sdl-mixer
		media-libs/sdl-image
		app-accessibility/espeak
		media-libs/libvorbis
		dev-libs/nspr
		media-libs/libpng
		media-libs/openal
		sys-libs/zlib[minizip]"

DEPEND="${RDEPEND}
		gnustep-base/gnustep-make[-libobjc2]"

S="${WORKDIR}/${P}"
PATCHES=(
	#"${FILESDIR}/experimental-SDL2-support.patch"
	#"${FILESDIR}/rescale-experiment.patch"
	"${FILESDIR}/${PN}-gentoo-r1.patch"
)

pkg_setup() {
	games-r1_pkg_setup
	gnustep-base_pkg_setup
}

src_unpack() {
	[[ ${PV} == 9999* ]] && git-r3_src_unpack
}

src_prepare() {
	base_src_prepare
	gnustep-base_src_prepare
	if [[ ${PV} != 9999* ]]; then
		mv "${WORKDIR}/mozilla-2.0/js" "${S}"/deps/mozilla/ || die
		mv "${WORKDIR}/mozilla-2.0/nsprpub" "${S}"/deps/mozilla/ || die
		mv "${WORKDIR}/oolite-binary-resources-${BINRES_REV}"/* "${S}"/Resources/Binary/
		echo "${FF_JS_URI}" > "${S}"/deps/mozilla/current.url
	fi
	sed -i -e 's/^\.PHONY: all$/.PHONY: .NOTPARALLEL all/' "${S}"/libjs.make || die
	sed -i -e 's:.*STRIP.*:	true:' \
		-e "/ADDITIONAL_OBJCFLAGS *=/aADDITIONAL_OBJCFLAGS += -fobjc-exceptions ${OBJCFLAGS}" \
		-e "/ADDITIONAL_OBJC_LIBS *=/aADDITIONAL_OBJC_LIBS += -lminizip ${LIBS}" \
		-e "/ADDITIONAL_LDFLAGS.*=/aADDITIONAL_LDFLAGS += ${LDFLAGS}" \
		-e 's|:src/Core/MiniZip||g' \
		-e 's|-Isrc/Core/MiniZip|-I/usr/include/minizip|' \
		"${S}"/GNUmakefile || die
	sed "/void png_error/d" -i src/Core/Materials/OOPNGTextureLoader.m

}

src_compile() {
	append-cxxflags -Wno-error=narrowing
	egnustep_env
	emake V=99 -f Makefile $(use debug && echo debug || echo release)
}

src_install() {
	#gnustep-base_src_install
	install_root="$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)"
	insinto "${install_root}"
	doins -r oolite.app

	echo "openapp oolite" > "${T}/oolite"
	dogamesbin "${T}/oolite"
	prepgamesdirs "${install_root}"
	fperms ug+x "${install_root}/oolite.app/oolite"
	doicon installers/FreeDesktop/oolite-icon.png
	domenu installers/FreeDesktop/oolite.desktop
}
