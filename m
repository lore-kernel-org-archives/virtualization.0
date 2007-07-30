From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Make lguest compile with CONFIG_BLOCK=n and CONFIG_NET=n
Date: Mon, 30 Jul 2007 10:25:22 +1000
Message-ID: <1185755123.12151.102.camel@localhost.localdomain>
References: <46ACAFBF.6060609@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965857AbXG3AZz@vger.kernel.org>
In-Reply-To: <46ACAFBF.6060609@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriel C <nix.or.die@googlemail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-07-29 at 17:18 +0200, Gabriel C wrote:
> Hi Rusty,
> 
> Lguest should depend on BLOCK too , without BLOCK set I get this error:

Hi Gabriel,

	Thanks for the report!  It's probably better to fix this properly
rather than hack it as I did for NET.

Linus, please apply:

Gabriel C reports lguest doesn't compile with CONFIG_BLOCK=n.  Fix
this by introducing a config var for the block device, which depends
on LGUEST && BLOCK.  Do the same for the net driver, rather then
depending gratuitously on CONFIG_NET.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 9e987fcabb16 drivers/block/Makefile
--- a/drivers/block/Makefile	Mon Jul 30 09:47:25 2007 +1000
+++ b/drivers/block/Makefile	Mon Jul 30 10:02:32 2007 +1000
@@ -31,4 +31,4 @@ obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
-obj-$(CONFIG_LGUEST_GUEST)	+= lguest_blk.o
+obj-$(CONFIG_LGUEST_BLOCK)	+= lguest_blk.o
diff -r 9e987fcabb16 drivers/lguest/Kconfig
--- a/drivers/lguest/Kconfig	Mon Jul 30 09:47:25 2007 +1000
+++ b/drivers/lguest/Kconfig	Mon Jul 30 10:03:39 2007 +1000
@@ -1,6 +1,6 @@ config LGUEST
 config LGUEST
 	tristate "Linux hypervisor example code"
-	depends on X86 && PARAVIRT && NET && EXPERIMENTAL && !X86_PAE
+	depends on X86 && PARAVIRT && EXPERIMENTAL && !X86_PAE
 	select LGUEST_GUEST
 	select HVC_DRIVER
 	---help---
@@ -18,3 +18,11 @@ config LGUEST_GUEST
 	  The guest needs code built-in, even if the host has lguest
 	  support as a module.  The drivers are tiny, so we build them
 	  in too.
+
+config LGUEST_NET
+	tristate
+	depends on LGUEST_GUEST && NET
+
+config LGUEST_BLOCK
+	tristate
+	depends on LGUEST_GUEST && BLOCK
diff -r 9e987fcabb16 drivers/net/Makefile
--- a/drivers/net/Makefile	Mon Jul 30 09:47:25 2007 +1000
+++ b/drivers/net/Makefile	Mon Jul 30 10:02:22 2007 +1000
@@ -177,7 +177,7 @@ obj-$(CONFIG_HPLANCE) += hplance.o 7990.
 obj-$(CONFIG_HPLANCE) += hplance.o 7990.o
 obj-$(CONFIG_MVME147_NET) += mvme147.o 7990.o
 obj-$(CONFIG_EQUALIZER) += eql.o
-obj-$(CONFIG_LGUEST_GUEST) += lguest_net.o
+obj-$(CONFIG_LGUEST_NET) += lguest_net.o
 obj-$(CONFIG_MIPS_JAZZ_SONIC) += jazzsonic.o
 obj-$(CONFIG_MIPS_AU1X00_ENET) += au1000_eth.o
 obj-$(CONFIG_MIPS_SIM_NET) += mipsnet.o
