From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [patch xen.git xen-tip/master] xen: fix xenbus frontend build
Date: Tue, 05 May 2009 11:42:00 -0700
Message-ID: <4A008878.7030409@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Cc: Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Randy Dunlap <randy.dunlap@oracle.com>

When a driver kconfig symbol =m and it selects another symbol,
that other symbol will also be =m (unless something else
causes it to be =y), so when XEN_BLKDEV_FRONTEND=m and/or
XEN_NETDEV_FRONTEND=m, then XEN_XENBUS_FRONTEND=m, but that
won't build (build error message below).  Changing
XEN_XENBUS_FRONTEND from a tristate to a bool makes it be
=y (builtin) any time that it is selected, so there is
no build error.

arch/x86/pci/built-in.o: In function `xenbus_register_frontend':
include/xen/xenbus.h:115: undefined reference to `__xenbus_register_frontend'

OTOH, I could have goofed my git trees somehow...

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/xen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-xyz.orig/drivers/xen/Kconfig
+++ linux-xyz/drivers/xen/Kconfig
@@ -85,7 +85,7 @@ config XEN_SYS_HYPERVISOR
 	 but will have no xen contents.
 
 config XEN_XENBUS_FRONTEND
-       tristate
+       bool
 
 config XEN_GNTDEV
 	bool "userspace grant access device driver"
