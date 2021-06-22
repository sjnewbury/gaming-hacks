# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils

CTF_V="1.07"
ROGUE_V="2.07"
XATRIX_V="2.08"

DESCRIPTION="Quake 2 engine focused on single player"
HOMEPAGE="https://www.yamagi.org/quake2/"

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI=https://github.com/yquake2/yquake2
	inherit git-r3
else
	SRC_URI="https://deponie.yamagi.org/quake2/quake2-${PV}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

SRC_URI+="ctf? ( https://deponie.yamagi.org/quake2/quake2-ctf-${CTF_V}.tar.xz )
	rogue? ( https://deponie.yamagi.org/quake2/quake2-rogue-${ROGUE_V}.tar.xz )
	xatrix? ( https://deponie.yamagi.org/quake2/quake2-xatrix-${XATRIX_V}.tar.xz )"

[[ ${PV} == 9999* ]] || S="${WORKDIR}/quake2-${PV}"

LICENSE="GPL-2"
SLOT="0"
IUSE="+client ctf dedicated openal +opengl rogue softrender xatrix vulkan"
REQUIRED_USE="
	|| ( client dedicated )
	client? ( || ( opengl softrender ) )
"

DEPEND="
	client? (
		media-libs/libsdl2[video]
		!openal? ( media-libs/libsdl2[sound] )
		opengl? (
			media-libs/libsdl2[opengl]
			virtual/opengl
		)
		vulkan? ( dev-util/vulkan-headers )
	)
"
RDEPEND="${DEPEND}
	client? ( openal? ( media-libs/openal ) )
"

PATCHES=(
	"${FILESDIR}"/${PN}-respect-flags-r1.patch
)
DOCS=( CHANGELOG README.md doc )

mymake() {
	emake \
		VERBOSE=1 \
		WITH_SYSTEMWIDE=yes \
		WITH_SYSTEMDIR="${EPREFIX}"/usr/share/quake2 \
		WITH_OPENAL=$(usex openal) \
		"$@"
}

src_unpack() {
	if [[ ${PV} == 9999* ]]; then
		git-r3_src_unpack
		if (use ctf || use rogue || use xatrix); then
			unpack ${A}
		fi

		if (use vulkan); then
			git-r3_fetch https://github.com/yquake2/ref_vk
			git-r3_checkout https://github.com/yquake2/ref_vk ${WORKDIR}/ref_vk
		fi
	else
		unpack ${A}
	fi
}

src_prepare() {
	local addon
	for addon in ctf rogue xatrix; do
		use ${addon} || continue

		pushd "${WORKDIR}"/quake2-${addon}-* >/dev/null || die
		if [[ ${addon} = ctf ]]; then
			eapply -l -- "${FILESDIR}"/${PN}-addon-respect-flags-r4.patch
		else
			eapply -l -- "${FILESDIR}"/${PN}-addon-respect-flags-r3.patch
		fi
		popd >/dev/null || die
	done

	default
}

src_compile() {
	local targets=( game )
	if use client; then
		targets+=( client )
		use opengl && targets+=( ref_gl1 ref_gl3 )
		use softrender && targets+=( ref_soft )
	fi
	use dedicated && targets+=( server )

	mymake config
	mymake "${targets[@]}"

	if use vulkan; then
		mymake -C "${WORKDIR}"/ref_vk
	fi

	local addon
	for addon in ctf rogue xatrix; do
		use ${addon} || continue
		emake -C "${WORKDIR}"/quake2-${addon}-* VERBOSE=1
	done
}

src_install() {
	insinto /usr/lib/yamagi-quake2
	# Yamagi Quake II expects all binaries to be in the same directory
	# See stuff/packaging.md for more info
	exeinto /usr/lib/yamagi-quake2
	doins -r release/.
	use vulkan && doins -r ${WORKDIR}/ref_vk/release/.

	if use client; then
		doexe release/quake2
		dosym ../lib/yamagi-quake2/quake2 /usr/bin/yquake2

		newicon stuff/icon/Quake2.svg "yamagi-quake2.svg"
		make_desktop_entry "yquake2" "Yamagi Quake II"
	fi

	if use dedicated; then
		doexe release/q2ded
		dosym ../lib/yamagi-quake2/q2ded /usr/bin/yq2ded
	fi

	insinto /usr/lib/yamagi-quake2/baseq2
	doins stuff/yq2.cfg

	local addon
	for addon in ctf rogue xatrix; do
		use ${addon} || continue

		insinto /usr/lib/yamagi-quake2/${addon}
		doins "${WORKDIR}"/quake2-${addon}-*/release/game.so

		if use client; then
			local addon_name
			case ${addon} in
				ctf)    addon_name="CTF" ;;
				rogue)  addon_name="Ground Zero" ;;
				xatrix) addon_name="The Reckoning" ;;
			esac

			make_wrapper "yquake2-${addon}" "yquake2 +set game ${addon}"
			make_desktop_entry "yquake2-${addon}" "Yamagi Quake II: ${addon_name}"
		fi
	done

	einstalldocs
	if use client; then
		docinto examples
		dodoc stuff/cdripper.sh
	fi
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog
		elog "In order to play, you must at least install:"
		elog "games-fps/quake2-data or games-fps/quake2-demodata or copy game"
		elog "data files to ~/.yq2/ or ${EPREFIX}/usr/share/quake2/ manually."
		elog "Read ${EPREFIX}/usr/share/doc/${PF}/README.md* for more information."
		elog
	fi
}
