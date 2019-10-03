From: Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 07/11] vhost: convert vhost_umem_interval_tree to half closed
	intervals
Date: Thu,  3 Oct 2019 13:18:54 -0700
Message-ID: <20191003201858.11666-8-dave__4335.05750713579$1570134839$gmane$org@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akpm@linux-foundation.org
Cc: dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>, peterz@infradead.org, Michael@mail.linuxfoundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, walken@google.com, linux-rdma@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The vhost_umem interval tree really wants [a, b) intervals,
not fully closed as currently. As such convert it to use the
new interval_tree_gen.h, and also rename the 'last' endpoint
in the node to 'end', which both a more suitable name for
the half closed interval and also reduces the chances of some
caller being missed.

Cc: Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/vhost/vhost.c | 19 +++++++++----------
 drivers/vhost/vhost.h |  4 ++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 36ca2cf419bf..80c3cca24dc7 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -28,7 +28,7 @@
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree_gen.h>
 #include <linux/nospec.h>
 
 #include "vhost.h"
@@ -51,7 +51,7 @@ enum {
 
 INTERVAL_TREE_DEFINE(struct vhost_umem_node,
 		     rb, __u64, __subtree_last,
-		     START, LAST, static inline, vhost_umem_interval_tree);
+		     START, END, static inline, vhost_umem_interval_tree);
 
 #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
 static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
@@ -1034,7 +1034,7 @@ static int vhost_new_umem_range(struct vhost_umem *umem,
 
 	node->start = start;
 	node->size = size;
-	node->last = end;
+	node->end = end;
 	node->userspace_addr = userspace_addr;
 	node->perm = perm;
 	INIT_LIST_HEAD(&node->link);
@@ -1112,7 +1112,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 		}
 		vhost_vq_meta_reset(dev);
 		if (vhost_new_umem_range(dev->iotlb, msg->iova, msg->size,
-					 msg->iova + msg->size - 1,
+					 msg->iova + msg->size,
 					 msg->uaddr, msg->perm)) {
 			ret = -ENOMEM;
 			break;
@@ -1126,7 +1126,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 		}
 		vhost_vq_meta_reset(dev);
 		vhost_del_umem_range(dev->iotlb, msg->iova,
-				     msg->iova + msg->size - 1);
+				     msg->iova + msg->size);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1320,15 +1320,14 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 {
 	const struct vhost_umem_node *node;
 	struct vhost_umem *umem = vq->iotlb;
-	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
+	u64 s = 0, size, orig_addr = addr, last = addr + len;
 
 	if (vhost_vq_meta_fetch(vq, addr, len, type))
 		return true;
 
 	while (len > s) {
 		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
-							   addr,
-							   last);
+							   addr, last);
 		if (node == NULL || node->start > addr) {
 			vhost_iotlb_miss(vq, addr, access);
 			return false;
@@ -1455,7 +1454,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 					 region->guest_phys_addr,
 					 region->memory_size,
 					 region->guest_phys_addr +
-					 region->memory_size - 1,
+					 region->memory_size,
 					 region->userspace_addr,
 					 VHOST_ACCESS_RW))
 			goto err;
@@ -2055,7 +2054,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 		}
 
 		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
-							addr, addr + len - 1);
+							   addr, addr + len);
 		if (node == NULL || node->start > addr) {
 			if (umem != dev->iotlb) {
 				ret = -EFAULT;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index e9ed2722b633..bb36cb9ed5ec 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -53,13 +53,13 @@ struct vhost_log {
 };
 
 #define START(node) ((node)->start)
-#define LAST(node) ((node)->last)
+#define END(node) ((node)->end)
 
 struct vhost_umem_node {
 	struct rb_node rb;
 	struct list_head link;
 	__u64 start;
-	__u64 last;
+	__u64 end;
 	__u64 size;
 	__u64 userspace_addr;
 	__u32 perm;
-- 
2.16.4
