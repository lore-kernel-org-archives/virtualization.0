From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: move list macro stubs
Date: Mon, 30 Nov 2015 10:41:35 +0200
Message-ID: <1448872891-13717-1-git-send-email-mst@redhat.com>
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
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Makes them more generally available.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/kernel.h | 6 ++++++
 tools/virtio/linux/virtio.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 0a3da64..4db7d56 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -110,4 +110,10 @@ static inline void free_page(unsigned long addr)
 	(void) (&_min1 == &_min2);		\
 	_min1 < _min2 ? _min1 : _min2; })
 
+/* TODO: empty stubs for now. Broken but enough for virtio_ring.c */
+#define list_add_tail(a, b) do {} while (0)
+#define list_del(a) do {} while (0)
+#define list_for_each_entry(a, b, c) while (0)
+/* end of stubs */
+
 #endif /* KERNEL_H */
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index a3e0701..ee125e7 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -3,12 +3,6 @@
 #include <linux/scatterlist.h>
 #include <linux/kernel.h>
 
-/* TODO: empty stubs for now. Broken but enough for virtio_ring.c */
-#define list_add_tail(a, b) do {} while (0)
-#define list_del(a) do {} while (0)
-#define list_for_each_entry(a, b, c) while (0)
-/* end of stubs */
-
 struct virtio_device {
 	void *dev;
 	u64 features;
-- 
MST
