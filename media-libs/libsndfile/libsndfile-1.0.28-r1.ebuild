# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy{,3} )

inherit python-any-r1 multilib-minimal

MY_P=${P/_pre/pre}

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile"
if [[ ${MY_P} == ${P} ]]; then
	SRC_URI="http://www.mega-nerd.com/libsndfile/files/${P}.tar.gz"
else
	SRC_URI="http://www.mega-nerd.com/tmp/${MY_P}b.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~arm64 hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="alsa minimal sqlite static-libs test"

RDEPEND="
	!minimal? (
		>=media-libs/flac-1.2.1-r5[${MULTILIB_USEDEP}]
		>=media-libs/libogg-1.3.0[${MULTILIB_USEDEP}]
		>=media-libs/libvorbis-1.3.3-r1[${MULTILIB_USEDEP}]
	)
	alsa? ( media-libs/alsa-lib )
	sqlite? ( >=dev-db/sqlite-3.2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( ${PYTHON_DEPS} )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		--disable-octave \
		--enable-gcc-pipe \
		--enable-gcc-opt \
		$(use_enable static-libs static) \
		$(use_enable !minimal external-libs) \
		$(multilib_native_enable full-suite) \
		$(multilib_native_use_enable alsa) \
		$(multilib_native_use_enable sqlite)
}

multilib_src_install_all() {
	einstalldocs

	# package provides .pc files
	find "${D}" -name '*.la' -delete || die
}
