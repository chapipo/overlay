# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3

DESCRIPTION="A minimal project manager for the terminal."
HOMEPAGE="https://github.com/eivind88/prm"
EGIT_REPO_URI="https://github.com/eivind88/prm.git"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	install -d "${D}/usr/share/prm"
	install -m 644 prm.sh "${D}/usr/share/prm/"
	dodoc README.md
}

pkg_postinst() {
	elog "The script prm.sh should not be run as a subshell"
	elog "but instead sourced. To simplify this process add"
	elog "the following to your shell rc file:"
	elog ""
	elog "    alias prm='. /usr/share/prm/prm.sh'"
	elog ""
	elog "then resource your rc file."
}
