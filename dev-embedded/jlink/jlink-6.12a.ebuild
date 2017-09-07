# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit versionator

MY_P="JLink_Linux_V${PV/\./}_x86_64"
INSTALLDIR="/opt/${PN}"

DESCRIPTION="J-Link gdb-server and commander for Segger J-Link jtag adapter"
HOMEPAGE="http://www.segger.com/jlink-software.html"
SRC_URI="JLink_Linux_V${PV/\./}_x86_64.tgz"
LICENSE="J-Link Terms of Use"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
QA_PREBUILT="*"

RESTRICT="fetch strip"
DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/libedit"

S=${WORKDIR}/${MY_P}

pkg_nofetch() {
    einfo "Segger requires you to download the needed files manually after"
    einfo "entering the serial number of your debugging probe."
    einfo
	einfo "Download ${SRC_URI}"
    einfo "from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_install() {
	dodir ${INSTALLDIR} || die
	dodir ${INSTALLDIR}/lib || die
	dodir ${INSTALLDIR}/doc || die

	local BINS="JLinkExe JLinkGDBServer JLinkRemoteServer JLinkSWOViewer"
	for wrapper in $BINS ; do
		make_wrapper $wrapper ./$wrapper ${INSTALLDIR} lib
	done

	exeinto ${INSTALLDIR}
	doexe $BINS || die

	exeinto ${INSTALLDIR}/lib
	doexe "libjlinkarm.so.${PV/[a-z]/}.1" || die
	dosym "lib/libjlinkarm.so.${PV/[a-z]/}.1" ${INSTALLDIR}/libjlinkarm.so || die

	exeinto /usr/bin
	for bin in $BINS ; do
		dosym ${INSTALLDIR}/$bin $bin
	done

	insinto ${INSTALLDIR}/doc
	doins README.txt || die
	doins Doc/License.txt
	doins Doc/UM08001_JLink.pdf || die
	doins Doc/ReleaseNotes/ReleaseNotes_JLink.html || die

	insinto ${INSTALLDIR}
	doins -r Samples || die "doins failed"

	insinto /lib/udev/rules.d/
	doins 99-jlink.rules || die "doins udev rules failed"
}

pkg_postinst() {
	enewgroup plugdev
	elog "To be able to access the jlink usb adapter, you have to be"
	elog "a member of the 'plugdev' group."
}
