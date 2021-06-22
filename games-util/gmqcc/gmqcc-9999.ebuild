# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/graphitemaster/gmqcc.git"
	inherit git-r3
else
	SRC_URI="https://github.com/graphitemaster/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="An Improved Quake C Compiler"
HOMEPAGE="http://graphitemaster.github.com/gmqcc/"

LICENSE="MIT"
SLOT="0"
IUSE=""

DOCS=( "README" "AUTHORS" )

src_configure() {
	tc-export CC CXX
}

src_compile() {
	emake STRIP=true CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin gmqcc
	dobin qcvm
	doman doc/*.1
	einstalldocs
}
