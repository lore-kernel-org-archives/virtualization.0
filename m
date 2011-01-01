From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] LGUEST_GUEST: fix unmet direct dependencies (VIRTUALIZATION
	&& VIRTIO)
Date: Sat, 1 Jan 2011 11:08:46 -0800
Message-ID: <20110101110846.6a88bf7e.rdunlap@xenotime.net>
References: <201012271242.53835.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201012271242.53835.toralf.foerster@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, lguest@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Honor the kconfig menu hierarchy to remove kconfig dependency warnings:
VIRTIO and VIRTIO_RING are subordinate to VIRTUALIZATION.

warning: (LGUEST_GUEST) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)
warning: (LGUEST_GUEST && VIRTIO_PCI && VIRTIO_BALLOON) selects VIRTIO_RING which has unmet direct dependencies (VIRTUALIZATION && VIRTIO)

Reported-by: Toralf F_rster <toralf.foerster@gmx.de>
Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/x86/lguest/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20101231.orig/arch/x86/lguest/Kconfig
+++ linux-next-20101231/arch/x86/lguest/Kconfig
@@ -2,6 +2,7 @@ config LGUEST_GUEST
 	bool "Lguest guest support"
 	select PARAVIRT
 	depends on X86_32
+	select VIRTUALIZATION
 	select VIRTIO
 	select VIRTIO_RING
 	select VIRTIO_CONSOLE
