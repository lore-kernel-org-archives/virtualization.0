From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: use virt_xxx barriers
Date: Wed, 20 Jan 2016 21:14:32 +0200
Message-ID: <1453317265-13913-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Kamal Mostafa <kamal@canonical.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Fix build after API changes.

Reported-by: Kamal Mostafa <kamal@canonical.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/asm/barrier.h    | 22 +++++++++++++---------
 tools/virtio/linux/compiler.h |  9 +++++++++
 tools/virtio/linux/kernel.h   |  1 +
 3 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100644 tools/virtio/linux/compiler.h

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index 26b7926..ba34f9e 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -1,15 +1,19 @@
 #if defined(__i386__) || defined(__x86_64__)
 #define barrier() asm volatile("" ::: "memory")
-#define mb() __sync_synchronize()
-
-#define smp_mb()	mb()
-# define dma_rmb()	barrier()
-# define dma_wmb()	barrier()
-# define smp_rmb()	barrier()
-# define smp_wmb()	barrier()
+#define virt_mb() __sync_synchronize()
+#define virt_rmb() barrier()
+#define virt_wmb() barrier()
+/* Atomic store should be enough, but gcc generates worse code in that case. */
+#define virt_store_mb(var, value)  do { \
+	typeof(var) virt_store_mb_value = (value); \
+	__atomic_exchange(&(var), &virt_store_mb_value, &virt_store_mb_value, \
+			  __ATOMIC_SEQ_CST); \
+	barrier(); \
+} while (0);
 /* Weak barriers should be used. If not - it's a bug */
-# define rmb()	abort()
-# define wmb()	abort()
+# define mb() abort()
+# define rmb() abort()
+# define wmb() abort()
 #else
 #error Please fill in barrier macros
 #endif
diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
new file mode 100644
index 0000000..845960e
--- /dev/null
+++ b/tools/virtio/linux/compiler.h
@@ -0,0 +1,9 @@
+#ifndef LINUX_COMPILER_H
+#define LINUX_COMPILER_H
+
+#define WRITE_ONCE(var, val) \
+	(*((volatile typeof(val) *)(&(var))) = (val))
+
+#define READ_ONCE(var) (*((volatile typeof(val) *)(&(var))))
+
+#endif
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 4db7d56..0338499 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -8,6 +8,7 @@
 #include <assert.h>
 #include <stdarg.h>
 
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/printk.h>
 #include <linux/bug.h>
-- 
MST
