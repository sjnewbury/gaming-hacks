# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/v1cont/${PN}"
else
	SRC_URI="https://github.com/v1cont/${PN}/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="Yet Another Dialog - allows you to display GTK+ dialog boxes from command line or shell scripts."
HOMEPAGE="https://github.com/v1cont/yad"

LICENSE="GPLv3"
SLOT="0"

DEPEND="
	>=x11-libs/gtk+-3.22.0:3
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
