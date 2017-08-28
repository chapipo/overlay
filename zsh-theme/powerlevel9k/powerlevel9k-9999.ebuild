# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3

DESCRIPTION="Theme for Zsh"
HOMEPAGE="https://github.com/bhilburn/powerlevel9k"
EGIT_REPO_URI="https://github.com/bhilburn/powerlevel9k.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/oh-my-zsh
	app-misc/powerline
	${DEPEND}"

src_install() {
	insinto /usr/share/zsh/site-contrib/oh-my-zsh/themes/powerlevel9k
	doins -r "${S}"/*
}
