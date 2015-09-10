From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/4] tools/virtio: fix build after 4.2 changes
Date: Thu, 10 Sep 2015 10:23:42 +0300
Message-ID: <1441869802-15847-2-git-send-email-mst@redhat.com>
References: <1441869802-15847-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1441869802-15847-1-git-send-email-mst@redhat.com>
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
Cc: "Xie, Huawei" <huawei.xie@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

more stubs, mostly

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/asm/barrier.h  | 2 ++
 tools/virtio/linux/export.h | 3 +++
 tools/virtio/linux/kernel.h | 8 ++++++++
 3 files changed, 13 insertions(+)
 create mode 100644 tools/virtio/linux/export.h

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index aff61e1..26b7926 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -3,6 +3,8 @@
 #define mb() __sync_synchronize()
 
 #define smp_mb()	mb()
+# define dma_rmb()	barrier()
+# define dma_wmb()	barrier()
 # define smp_rmb()	barrier()
 # define smp_wmb()	barrier()
 /* Weak barriers should be used. If not - it's a bug */
diff --git a/tools/virtio/linux/export.h b/tools/virtio/linux/export.h
new file mode 100644
index 0000000..416875e
--- /dev/null
+++ b/tools/virtio/linux/export.h
@@ -0,0 +1,3 @@
+#define EXPORT_SYMBOL_GPL(sym) extern typeof(sym) sym
+#define EXPORT_SYMBOL(sym) extern typeof(sym) sym
+
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 1e8ce69..0a3da64 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -22,6 +22,7 @@
 
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
+typedef unsigned int __wsum;
 
 struct page {
 	unsigned long long dummy;
@@ -47,6 +48,13 @@ static inline void *kmalloc(size_t s, gfp_t gfp)
 		return __kmalloc_fake;
 	return malloc(s);
 }
+static inline void *kzalloc(size_t s, gfp_t gfp)
+{
+	void *p = kmalloc(s, gfp);
+
+	memset(p, 0, s);
+	return p;
+}
 
 static inline void kfree(void *p)
 {
-- 
MST
