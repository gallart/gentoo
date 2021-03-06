# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby21 ruby22 ruby23 ruby24"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_EXTRADOC="README"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Base class with almost all of the methods from Object and Kernel being removed"
HOMEPAGE="https://rubygems.org/gems/blankslate"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"

all_ruby_prepare() {
	# Avoid test failing with rspec 2.x.
	sed -i -e '/cleanliness/,/^  end/ s:^:#:' spec/blankslate_spec.rb || die
}
