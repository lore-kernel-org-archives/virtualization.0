From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] xen: Make xen-blkfront write its protocol ABI to xenstore
Date: Thu, 06 Dec 2007 14:45:53 +0100
Message-ID: <87hciwlywe.fsf__4218.52916847474$1196948911$gmane$org@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Frontends are expected to write their protocol ABI to xenstore.  Since
the protocol ABI defaults to the backend's native ABI, things work
fine without that as long as the frontend's native ABI is identical to
the backend's native ABI.  This is not the case for xen-blkfront
running 32-on-64, because its ABI differs between 32 and 64 bit, and
thus needs this fix.

Based on http://xenbits.xensource.com/xen-unstable.hg?rev/c545932a18f3
and http://xenbits.xensource.com/xen-unstable.hg?rev/ffe52263b430 by
Gerd Hoffmann <kraxel@suse.de>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 drivers/block/xen-blkfront.c         |    7 +++++++
 include/xen/interface/io/protocols.h |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 include/xen/interface/io/protocols.h

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 2bdebcb..70ddb8c 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -46,6 +46,7 @@
 
 #include <xen/interface/grant_table.h>
 #include <xen/interface/io/blkif.h>
+#include <xen/interface/io/protocols.h>
 
 #include <asm/xen/hypervisor.h>
 
@@ -599,6 +600,12 @@ again:
 		message = "writing event-channel";
 		goto abort_transaction;
 	}
+	err = xenbus_printf(xbt, dev->nodename, "protocol", "%s",
+			    XEN_IO_PROTO_ABI_NATIVE);
+	if (err) {
+		message = "writing protocol";
+		goto abort_transaction;
+	}
 
 	err = xenbus_transaction_end(xbt, 0);
 	if (err) {
diff --git a/include/xen/interface/io/protocols.h b/include/xen/interface/io/protocols.h
new file mode 100644
index 0000000..01fc8ae
--- /dev/null
+++ b/include/xen/interface/io/protocols.h
@@ -0,0 +1,21 @@
+#ifndef __XEN_PROTOCOLS_H__
+#define __XEN_PROTOCOLS_H__
+
+#define XEN_IO_PROTO_ABI_X86_32     "x86_32-abi"
+#define XEN_IO_PROTO_ABI_X86_64     "x86_64-abi"
+#define XEN_IO_PROTO_ABI_IA64       "ia64-abi"
+#define XEN_IO_PROTO_ABI_POWERPC64  "powerpc64-abi"
+
+#if defined(__i386__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_32
+#elif defined(__x86_64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_64
+#elif defined(__ia64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_IA64
+#elif defined(__powerpc64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_POWERPC64
+#else
+# error arch fixup needed here
+#endif
+
+#endif
-- 
1.5.3.3
