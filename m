From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 03/29] ia64/xen: introduce sync bitops which is necessary for
	ia64/xen support.
Date: Thu, 17 Jul 2008 11:10:35 +0900
Message-ID: <12162606623470-git-send-email-yamahata__47517.1089558446$1216260843$gmane$org@valinux.co.jp>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12162606614068-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: "Luck, Tony" <tony.luck@intel.com>, virtualization@lists.linux-foundation.org, yamahata@valinux.co.jp, Robin Holt <holt@sgi.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

define sync bitops which is necessary for ia64/xen.
This bit operation is used to communicate with VMM or other guest kernel
Even when this kernel is built for UP, VMM might be SMP so that those operation
must always use atomic operation.

Cc: Robin Holt <holt@sgi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: "Luck, Tony" <tony.luck@intel.com>
---
 include/asm-ia64/sync_bitops.h |   51 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-ia64/sync_bitops.h

diff --git a/include/asm-ia64/sync_bitops.h b/include/asm-ia64/sync_bitops.h
new file mode 100644
index 0000000..593c12e
--- /dev/null
+++ b/include/asm-ia64/sync_bitops.h
@@ -0,0 +1,51 @@
+#ifndef _ASM_IA64_SYNC_BITOPS_H
+#define _ASM_IA64_SYNC_BITOPS_H
+
+/*
+ * Copyright (C) 2008 Isaku Yamahata <yamahata at valinux co jp>
+ *
+ * Based on synch_bitops.h which Dan Magenhaimer wrote.
+ *
+ * bit operations which provide guaranteed strong synchronisation
+ * when communicating with Xen or other guest OSes running on other CPUs.
+ */
+
+static inline void sync_set_bit(int nr, volatile void *addr)
+{
+	set_bit(nr, addr);
+}
+
+static inline void sync_clear_bit(int nr, volatile void *addr)
+{
+	clear_bit(nr, addr);
+}
+
+static inline void sync_change_bit(int nr, volatile void *addr)
+{
+	change_bit(nr, addr);
+}
+
+static inline int sync_test_and_set_bit(int nr, volatile void *addr)
+{
+	return test_and_set_bit(nr, addr);
+}
+
+static inline int sync_test_and_clear_bit(int nr, volatile void *addr)
+{
+	return test_and_clear_bit(nr, addr);
+}
+
+static inline int sync_test_and_change_bit(int nr, volatile void *addr)
+{
+	return test_and_change_bit(nr, addr);
+}
+
+static inline int sync_test_bit(int nr, const volatile void *addr)
+{
+	return test_bit(nr, addr);
+}
+
+#define sync_cmpxchg(ptr, old, new)				\
+	((__typeof__(*(ptr)))cmpxchg_acq((ptr), (old), (new)))
+
+#endif /* _ASM_IA64_SYNC_BITOPS_H */
-- 
1.5.3
