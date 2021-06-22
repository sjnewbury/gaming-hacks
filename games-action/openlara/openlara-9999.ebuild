EAPI=7

DESCRIPTION="OpenLara - Free re-implementation of the Lara Croft engine"
HOMEPAGE="https://github.com/XProger/OpenLara.git"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/XProger/OpenLara.git"
else
	SRC_URI="https://github.com/XProger/OpenLara/archive/${PV}.tar.gz"
fi

LICENSE="Clarified-Artistic"
SLOT="0"

RDEPEND="media-fonts/dejavu
	virtual/opengl
	media-libs/libsdl2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/src/platform/sdl2
