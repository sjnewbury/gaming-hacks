# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

MY_PN="hexen2"
LIT_VER=20140628

DESCRIPTION="Colored lighting data for Hexen 2"
HOMEPAGE="http://uhexen2.sourceforge.net/"
SRC_URI="mirror://sourceforge/u${MY_PN}/${MY_PN}-litfiles-${LIT_VER}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	local my_dir=/usr/share/${MY_PN}
	insinto "${my_dir}"
	doins -r data1 || die

	# The 3 demo maps are also in the demo data.
	dodir "${my_dir}"/demo/data1/maps
	local my_i
	for my_i in 1 2 3 ; do
		dosym  ../../../data1/maps/demo${my_i}.lit \
			"${my_dir}"/demo/data1/maps/demo${my_i}.lit || die
	done

	dodoc *.txt || die
}

pkg_postinst() {
	if ! has_version "games-fps/uhexen2" ; then
		elog "This is just lighting data. To play, emerge a client"
		elog "such as uhexen2."
	fi
}
