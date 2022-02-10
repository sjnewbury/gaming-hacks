# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Simulate keyboard input and mouse activity, move and resize windows"
HOMEPAGE="https://github.com/ReimuNotMoe/ydotool"

if [[ ${PV} = 9999* ]]; then
	inherit git-r3
	KEYWORDS=
	SRC_URI=
	EGIT_REPO_URI=https://github.com/ReimuNotMoe/ydotool
#	EGIT_COMMIT=e33e16e09797c93887673717d514ff19f7beb7eb
else
	SRC_URI="https://github.com/ReimuNotMoe/ydotool/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86 ~riscv"
fi

LICENSE="AGPLv3"
SLOT="0"

RDEPEND="
	dev-libs/wayland
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-base/wayland-proto
"
