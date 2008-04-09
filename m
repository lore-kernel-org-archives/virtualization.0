From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 01/23] ia64/xen: introduce synch bitops which is necessary for
	ia64/xen support.
Date: Wed,  9 Apr 2008 13:50:08 +0900
Message-ID: <12077166303062-git-send-email-yamahata__6630.07725165716$1207717630$gmane$org@valinux.co.jp>
References: <12077166301391-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12077166301391-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

define sync bitops which is necessary for ia64/xen.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/sync_bitops.h |   59 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-ia64/sync_bitops.h

diff --git a/include/asm-ia64/sync_bitops.h b/include/asm-ia64/sync_bitops.h
new file mode 100644
index 0000000..f56cd90
--- /dev/null
+++ b/include/asm-ia64/sync_bitops.h
@@ -0,0 +1,59 @@
+#ifndef _ASM_IA64_SYNC_BITOPS_H
+#define _ASM_IA64_SYNC_BITOPS_H
+
+/*
+ * Copyright 1992, Linus Torvalds.
+ * Heavily modified to provide guaranteed strong synchronisation
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
+static inline int sync_const_test_bit(int nr, const volatile void *addr)
+{
+	return test_bit(nr, addr);
+}
+
+static inline int sync_var_test_bit(int nr, volatile void *addr)
+{
+	return test_bit(nr, addr);
+}
+
+#define sync_cmpxchg	ia64_cmpxchg4_acq
+
+#define sync_test_bit(nr,addr)			\
+	(__builtin_constant_p(nr) ?		\
+	 sync_const_test_bit((nr), (addr)) :	\
+	 sync_var_test_bit((nr), (addr)))
+
+#define sync_cmpxchg_subword sync_cmpxchg
+
+#endif /* _ASM_IA64_SYNC_BITOPS_H */
-- 
1.5.3
