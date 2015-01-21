From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [pciutils patch v2] add virtio vendor capability support
Date: Wed, 21 Jan 2015 16:35:04 +0100
Message-ID: <1421854504-11945-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mj@ucw.cz
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio uses vendor-specific capabilities to specify the location of
the virtio register ranges.  The specification can be found here:

http://docs.oasis-open.org/virtio/virtio/v1.0/cs01/virtio-v1.0-cs01.html#x1-690004

This patch adds support for decoding these capabilities to lspci.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile         |  2 +-
 ls-caps-vendor.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ls-caps.c        |  2 +-
 lspci.h          |  4 +++
 4 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 ls-caps-vendor.c

diff --git a/Makefile b/Makefile
index 8d49afa..39a07d1 100644
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ force:
 lib/config.h lib/config.mk:
 	cd lib && ./configure
 
-lspci: lspci.o ls-vpd.o ls-caps.o ls-ecaps.o ls-kernel.o ls-tree.o ls-map.o common.o lib/$(PCILIB)
+lspci: lspci.o ls-vpd.o ls-caps.o ls-caps-vendor.o ls-ecaps.o ls-kernel.o ls-tree.o ls-map.o common.o lib/$(PCILIB)
 setpci: setpci.o common.o lib/$(PCILIB)
 
 LSPCIINC=lspci.h pciutils.h $(PCIINC)
diff --git a/ls-caps-vendor.c b/ls-caps-vendor.c
new file mode 100644
index 0000000..4cdfe22
--- /dev/null
+++ b/ls-caps-vendor.c
@@ -0,0 +1,76 @@
+/*
+ *	The PCI Utilities -- Show Vendor-specific Capabilities
+ *
+ *	Copyright (c) 2014 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL.
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include "lspci.h"
+
+static void
+show_vendor_caps_virtio(struct device *d, int where, int cap)
+{
+  int length = BITS(cap, 0, 8);
+  int type = BITS(cap, 8, 8);
+  char *tname;
+
+  if (length < 16)
+    return;
+  if (!config_fetch(d, where, length))
+    return;
+
+  switch (type)
+    {
+    case 1:
+      tname = "CommonCfg";
+      break;
+    case 2:
+      tname = "Notify";
+      break;
+    case 3:
+      tname = "ISR";
+      break;
+    case 4:
+      tname = "DeviceCfg";
+      break;
+    default:
+      tname = "<unknown>";
+      break;
+    }
+
+  printf("VirtIO: %s\n", tname);
+
+  if (verbose < 2)
+    return;
+
+  printf("\t\tBAR=%d offset=%08x size=%08x\n",
+	 get_conf_byte(d, where +  4),
+	 get_conf_long(d, where +  8),
+	 get_conf_long(d, where + 12));
+
+  if (type != 2 || length < 20)
+    return;
+
+  printf("\t\tmultiplier=%08x\n",
+	 get_conf_long(d, where+16));
+}
+
+void
+show_vendor_caps(struct device *d, int where, int cap)
+{
+  switch (get_conf_word(d, PCI_VENDOR_ID))
+    {
+    case 0x1af4: /* Red Hat */
+      if (get_conf_word(d, PCI_DEVICE_ID) >= 0x1000 &&
+	  get_conf_word(d, PCI_DEVICE_ID) <= 0x107f)
+	show_vendor_caps_virtio(d, where, cap);
+      break;
+    default:
+      printf("Vendor Specific Information: Len=%02x <?>\n", BITS(cap, 0, 8));
+      break;
+    }
+}
diff --git a/ls-caps.c b/ls-caps.c
index 7de55ef..c145ed6 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1315,7 +1315,7 @@ show_caps(struct device *d, int where)
 	      cap_ht(d, where, cap);
 	      break;
 	    case PCI_CAP_ID_VNDR:
-	      printf("Vendor Specific Information: Len=%02x <?>\n", BITS(cap, 0, 8));
+	      show_vendor_caps(d, where, cap);
 	      break;
 	    case PCI_CAP_ID_DBG:
 	      cap_debug_port(cap);
diff --git a/lspci.h b/lspci.h
index 86429b2..a3fc9d0 100644
--- a/lspci.h
+++ b/lspci.h
@@ -70,6 +70,10 @@ void show_caps(struct device *d, int where);
 
 void show_ext_caps(struct device *d);
 
+/* ls-caps-vendor.c */
+
+void show_vendor_caps(struct device *d, int where, int cap);
+
 /* ls-kernel.c */
 
 void show_kernel_machine(struct device *d UNUSED);
-- 
1.8.3.1
