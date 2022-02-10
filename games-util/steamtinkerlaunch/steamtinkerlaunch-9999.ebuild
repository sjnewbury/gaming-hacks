# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/frostworx/${PN}"
else
	SRC_URI="https://github.com/frostworx/${PN}/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="stl - Linux wrapper tool for use with the Steam client which allows customizing and start tools and options for games quickly on the fly"
HOMEPAGE="https://github.com/frostworx/steamtinkerlaunch"

LICENSE="GPLv3"
SLOT="0"

RDEPEND="
	x11-misc/xdotool
	x11-apps/xrandr
	x11-apps/xwininfo
	sys-process/procps
	net-misc/wget
	sys-apps/gawk
	x11-apps/xprop
	app-editors/vim-core
	dev-vcs/git
	app-shells/bash
	app-arch/unzip
	sys-apps/which
	gui-libs/yad
"

PATCHES=( "${FILESDIR}"/destdir.patch )
