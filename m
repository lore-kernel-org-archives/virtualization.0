From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V5 1/5] vhost: factor out IOTLB
Date: Wed, 26 Feb 2020 14:04:52 +0800
Message-ID: <20200226060456.27275-2-jasowang@redhat.com>
References: <20200226060456.27275-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200226060456.27275-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: mhabets@solarflare.com, jgg@mellanox.com, rob.miller@broadcom.com, saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com, haotian.wang@sifive.com, shahafs@mellanox.com, parav@mellanox.com, vmireyno@marvell.com, gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com, rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This patch factors out IOTLB into a dedicated module in order to be
reused by other modules like vringh. User may choose to enable the
automatic retiring by specifying VHOST_IOTLB_FLAG_RETIRE flag to fit
for the case of vhost device IOTLB implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS                 |   1 +
 drivers/vhost/Kconfig       |   6 +
 drivers/vhost/Makefile      |   2 +
 drivers/vhost/net.c         |   2 +-
 drivers/vhost/vhost.c       | 221 +++++++++++-------------------------
 drivers/vhost/vhost.h       |  36 ++----
 drivers/vhost/vhost_iotlb.c | 171 ++++++++++++++++++++++++++++
 include/linux/vhost_iotlb.h |  45 ++++++++
 8 files changed, 303 insertions(+), 181 deletions(-)
 create mode 100644 drivers/vhost/vhost_iotlb.c
 create mode 100644 include/linux/vhost_iotlb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c74e4ea714a5..0fb645b5a7df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17768,6 +17768,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
 S:	Maintained
 F:	drivers/vhost/
 F:	include/uapi/linux/vhost.h
+F:	include/linux/vhost_iotlb.h
 
 VIRTIO INPUT DRIVER
 M:	Gerd Hoffmann <kraxel@redhat.com>
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 3d03ccbd1adc..e76a72490563 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -36,6 +36,7 @@ config VHOST_VSOCK
 
 config VHOST
 	tristate
+	select VHOST_IOTLB
 	---help---
 	  This option is selected by any driver which needs to access
 	  the core of vhost.
@@ -54,3 +55,8 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  adds some overhead, it is disabled by default.
 
 	  If unsure, say "N".
+
+config VHOST_IOTLB
+	tristate
+	help
+	  Generic IOTLB implementation for vhost and vringh.
diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
index 6c6df24f770c..df99756fbb26 100644
--- a/drivers/vhost/Makefile
+++ b/drivers/vhost/Makefile
@@ -11,3 +11,5 @@ vhost_vsock-y := vsock.o
 obj-$(CONFIG_VHOST_RING) += vringh.o
 
 obj-$(CONFIG_VHOST)	+= vhost.o
+
+obj-$(CONFIG_VHOST_IOTLB) += vhost_iotlb.o
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index e158159671fa..e4a20d7a2921 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1594,7 +1594,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	struct socket *tx_sock = NULL;
 	struct socket *rx_sock = NULL;
 	long err;
-	struct vhost_umem *umem;
+	struct vhost_iotlb *umem;
 
 	mutex_lock(&n->dev.mutex);
 	err = vhost_dev_check_owner(&n->dev);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f44340b41494..9059b95cac83 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -50,10 +50,6 @@ enum {
 #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
 #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
 
-INTERVAL_TREE_DEFINE(struct vhost_umem_node,
-		     rb, __u64, __subtree_last,
-		     START, LAST, static inline, vhost_umem_interval_tree);
-
 #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
 static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
 {
@@ -581,21 +577,25 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
 
-struct vhost_umem *vhost_dev_reset_owner_prepare(void)
+static struct vhost_iotlb *iotlb_alloc(void)
+{
+	return vhost_iotlb_alloc(max_iotlb_entries,
+				 VHOST_IOTLB_FLAG_RETIRE);
+}
+
+struct vhost_iotlb *vhost_dev_reset_owner_prepare(void)
 {
-	return kvzalloc(sizeof(struct vhost_umem), GFP_KERNEL);
+	return iotlb_alloc();
 }
 EXPORT_SYMBOL_GPL(vhost_dev_reset_owner_prepare);
 
 /* Caller should have device mutex */
-void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_umem *umem)
+void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 {
 	int i;
 
 	vhost_dev_cleanup(dev);
 
-	/* Restore memory to default empty mapping. */
-	INIT_LIST_HEAD(&umem->umem_list);
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -618,28 +618,6 @@ void vhost_dev_stop(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
-static void vhost_umem_free(struct vhost_umem *umem,
-			    struct vhost_umem_node *node)
-{
-	vhost_umem_interval_tree_remove(node, &umem->umem_tree);
-	list_del(&node->link);
-	kfree(node);
-	umem->numem--;
-}
-
-static void vhost_umem_clean(struct vhost_umem *umem)
-{
-	struct vhost_umem_node *node, *tmp;
-
-	if (!umem)
-		return;
-
-	list_for_each_entry_safe(node, tmp, &umem->umem_list, link)
-		vhost_umem_free(umem, node);
-
-	kvfree(umem);
-}
-
 static void vhost_clear_msg(struct vhost_dev *dev)
 {
 	struct vhost_msg_node *node, *n;
@@ -677,9 +655,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		eventfd_ctx_put(dev->log_ctx);
 	dev->log_ctx = NULL;
 	/* No one will access memory at this point */
-	vhost_umem_clean(dev->umem);
+	vhost_iotlb_free(dev->umem);
 	dev->umem = NULL;
-	vhost_umem_clean(dev->iotlb);
+	vhost_iotlb_free(dev->iotlb);
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
@@ -715,27 +693,26 @@ static bool vhost_overflow(u64 uaddr, u64 size)
 }
 
 /* Caller should have vq mutex and device mutex. */
-static bool vq_memory_access_ok(void __user *log_base, struct vhost_umem *umem,
+static bool vq_memory_access_ok(void __user *log_base, struct vhost_iotlb *umem,
 				int log_all)
 {
-	struct vhost_umem_node *node;
+	struct vhost_iotlb_map *map;
 
 	if (!umem)
 		return false;
 
-	list_for_each_entry(node, &umem->umem_list, link) {
-		unsigned long a = node->userspace_addr;
+	list_for_each_entry(map, &umem->list, link) {
+		unsigned long a = map->addr;
 
-		if (vhost_overflow(node->userspace_addr, node->size))
+		if (vhost_overflow(map->addr, map->size))
 			return false;
 
 
-		if (!access_ok((void __user *)a,
-				    node->size))
+		if (!access_ok((void __user *)a, map->size))
 			return false;
 		else if (log_all && !log_access_ok(log_base,
-						   node->start,
-						   node->size))
+						   map->start,
+						   map->size))
 			return false;
 	}
 	return true;
@@ -745,17 +722,17 @@ static inline void __user *vhost_vq_meta_fetch(struct vhost_virtqueue *vq,
 					       u64 addr, unsigned int size,
 					       int type)
 {
-	const struct vhost_umem_node *node = vq->meta_iotlb[type];
+	const struct vhost_iotlb_map *map = vq->meta_iotlb[type];
 
-	if (!node)
+	if (!map)
 		return NULL;
 
-	return (void *)(uintptr_t)(node->userspace_addr + addr - node->start);
+	return (void *)(uintptr_t)(map->addr + addr - map->start);
 }
 
 /* Can we switch to this memory table? */
 /* Caller should have device mutex but not vq mutex */
-static bool memory_access_ok(struct vhost_dev *d, struct vhost_umem *umem,
+static bool memory_access_ok(struct vhost_dev *d, struct vhost_iotlb *umem,
 			     int log_all)
 {
 	int i;
@@ -1020,47 +997,6 @@ static inline int vhost_get_desc(struct vhost_virtqueue *vq,
 	return vhost_copy_from_user(vq, desc, vq->desc + idx, sizeof(*desc));
 }
 
-static int vhost_new_umem_range(struct vhost_umem *umem,
-				u64 start, u64 size, u64 end,
-				u64 userspace_addr, int perm)
-{
-	struct vhost_umem_node *tmp, *node;
-
-	if (!size)
-		return -EFAULT;
-
-	node = kmalloc(sizeof(*node), GFP_ATOMIC);
-	if (!node)
-		return -ENOMEM;
-
-	if (umem->numem == max_iotlb_entries) {
-		tmp = list_first_entry(&umem->umem_list, typeof(*tmp), link);
-		vhost_umem_free(umem, tmp);
-	}
-
-	node->start = start;
-	node->size = size;
-	node->last = end;
-	node->userspace_addr = userspace_addr;
-	node->perm = perm;
-	INIT_LIST_HEAD(&node->link);
-	list_add_tail(&node->link, &umem->umem_list);
-	vhost_umem_interval_tree_insert(node, &umem->umem_tree);
-	umem->numem++;
-
-	return 0;
-}
-
-static void vhost_del_umem_range(struct vhost_umem *umem,
-				 u64 start, u64 end)
-{
-	struct vhost_umem_node *node;
-
-	while ((node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
-							   start, end)))
-		vhost_umem_free(umem, node);
-}
-
 static void vhost_iotlb_notify_vq(struct vhost_dev *d,
 				  struct vhost_iotlb_msg *msg)
 {
@@ -1117,9 +1053,9 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 			break;
 		}
 		vhost_vq_meta_reset(dev);
-		if (vhost_new_umem_range(dev->iotlb, msg->iova, msg->size,
-					 msg->iova + msg->size - 1,
-					 msg->uaddr, msg->perm)) {
+		if (vhost_iotlb_add_range(dev->iotlb, msg->iova,
+					  msg->iova + msg->size - 1,
+					  msg->uaddr, msg->perm)) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -1131,8 +1067,8 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 			break;
 		}
 		vhost_vq_meta_reset(dev);
-		vhost_del_umem_range(dev->iotlb, msg->iova,
-				     msg->iova + msg->size - 1);
+		vhost_iotlb_del_range(dev->iotlb, msg->iova,
+				      msg->iova + msg->size - 1);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1311,44 +1247,42 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
 }
 
 static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
-				 const struct vhost_umem_node *node,
+				 const struct vhost_iotlb_map *map,
 				 int type)
 {
 	int access = (type == VHOST_ADDR_USED) ?
 		     VHOST_ACCESS_WO : VHOST_ACCESS_RO;
 
-	if (likely(node->perm & access))
-		vq->meta_iotlb[type] = node;
+	if (likely(map->perm & access))
+		vq->meta_iotlb[type] = map;
 }
 
 static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 			    int access, u64 addr, u64 len, int type)
 {
-	const struct vhost_umem_node *node;
-	struct vhost_umem *umem = vq->iotlb;
+	const struct vhost_iotlb_map *map;
+	struct vhost_iotlb *umem = vq->iotlb;
 	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
 
 	if (vhost_vq_meta_fetch(vq, addr, len, type))
 		return true;
 
 	while (len > s) {
-		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
-							   addr,
-							   last);
-		if (node == NULL || node->start > addr) {
+		map = vhost_iotlb_itree_first(umem, addr, last);
+		if (map == NULL || map->start > addr) {
 			vhost_iotlb_miss(vq, addr, access);
 			return false;
-		} else if (!(node->perm & access)) {
+		} else if (!(map->perm & access)) {
 			/* Report the possible access violation by
 			 * request another translation from userspace.
 			 */
 			return false;
 		}
 
-		size = node->size - addr + node->start;
+		size = map->size - addr + map->start;
 
 		if (orig_addr == addr && size >= len)
-			vhost_vq_meta_update(vq, node, type);
+			vhost_vq_meta_update(vq, map, type);
 
 		s += size;
 		addr += size;
@@ -1364,12 +1298,12 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 	if (!vq->iotlb)
 		return 1;
 
-	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
+	return iotlb_access_ok(vq, VHOST_MAP_RO, (u64)(uintptr_t)vq->desc,
 			       vhost_get_desc_size(vq, num), VHOST_ADDR_DESC) &&
-	       iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
+	       iotlb_access_ok(vq, VHOST_MAP_RO, (u64)(uintptr_t)vq->avail,
 			       vhost_get_avail_size(vq, num),
 			       VHOST_ADDR_AVAIL) &&
-	       iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->used,
+	       iotlb_access_ok(vq, VHOST_MAP_WO, (u64)(uintptr_t)vq->used,
 			       vhost_get_used_size(vq, num), VHOST_ADDR_USED);
 }
 EXPORT_SYMBOL_GPL(vq_meta_prefetch);
@@ -1408,25 +1342,11 @@ bool vhost_vq_access_ok(struct vhost_virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
 
-static struct vhost_umem *vhost_umem_alloc(void)
-{
-	struct vhost_umem *umem = kvzalloc(sizeof(*umem), GFP_KERNEL);
-
-	if (!umem)
-		return NULL;
-
-	umem->umem_tree = RB_ROOT_CACHED;
-	umem->numem = 0;
-	INIT_LIST_HEAD(&umem->umem_list);
-
-	return umem;
-}
-
 static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 {
 	struct vhost_memory mem, *newmem;
 	struct vhost_memory_region *region;
-	struct vhost_umem *newumem, *oldumem;
+	struct vhost_iotlb *newumem, *oldumem;
 	unsigned long size = offsetof(struct vhost_memory, regions);
 	int i;
 
@@ -1448,7 +1368,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 		return -EFAULT;
 	}
 
-	newumem = vhost_umem_alloc();
+	newumem = iotlb_alloc();
 	if (!newumem) {
 		kvfree(newmem);
 		return -ENOMEM;
@@ -1457,13 +1377,12 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 	for (region = newmem->regions;
 	     region < newmem->regions + mem.nregions;
 	     region++) {
-		if (vhost_new_umem_range(newumem,
-					 region->guest_phys_addr,
-					 region->memory_size,
-					 region->guest_phys_addr +
-					 region->memory_size - 1,
-					 region->userspace_addr,
-					 VHOST_ACCESS_RW))
+		if (vhost_iotlb_add_range(newumem,
+					  region->guest_phys_addr,
+					  region->guest_phys_addr +
+					  region->memory_size - 1,
+					  region->userspace_addr,
+					  VHOST_MAP_RW))
 			goto err;
 	}
 
@@ -1481,11 +1400,11 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 	}
 
 	kvfree(newmem);
-	vhost_umem_clean(oldumem);
+	vhost_iotlb_free(oldumem);
 	return 0;
 
 err:
-	vhost_umem_clean(newumem);
+	vhost_iotlb_free(newumem);
 	kvfree(newmem);
 	return -EFAULT;
 }
@@ -1726,10 +1645,10 @@ EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
 int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
 {
-	struct vhost_umem *niotlb, *oiotlb;
+	struct vhost_iotlb *niotlb, *oiotlb;
 	int i;
 
-	niotlb = vhost_umem_alloc();
+	niotlb = iotlb_alloc();
 	if (!niotlb)
 		return -ENOMEM;
 
@@ -1745,7 +1664,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
 		mutex_unlock(&vq->mutex);
 	}
 
-	vhost_umem_clean(oiotlb);
+	vhost_iotlb_free(oiotlb);
 
 	return 0;
 }
@@ -1875,8 +1794,8 @@ static int log_write(void __user *log_base,
 
 static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
 {
-	struct vhost_umem *umem = vq->umem;
-	struct vhost_umem_node *u;
+	struct vhost_iotlb *umem = vq->umem;
+	struct vhost_iotlb_map *u;
 	u64 start, end, l, min;
 	int r;
 	bool hit = false;
@@ -1886,16 +1805,15 @@ static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
 		/* More than one GPAs can be mapped into a single HVA. So
 		 * iterate all possible umems here to be safe.
 		 */
-		list_for_each_entry(u, &umem->umem_list, link) {
-			if (u->userspace_addr > hva - 1 + len ||
-			    u->userspace_addr - 1 + u->size < hva)
+		list_for_each_entry(u, &umem->list, link) {
+			if (u->addr > hva - 1 + len ||
+			    u->addr - 1 + u->size < hva)
 				continue;
-			start = max(u->userspace_addr, hva);
-			end = min(u->userspace_addr - 1 + u->size,
-				  hva - 1 + len);
+			start = max(u->addr, hva);
+			end = min(u->addr - 1 + u->size, hva - 1 + len);
 			l = end - start + 1;
 			r = log_write(vq->log_base,
-				      u->start + start - u->userspace_addr,
+				      u->start + start - u->addr,
 				      l);
 			if (r < 0)
 				return r;
@@ -2046,9 +1964,9 @@ EXPORT_SYMBOL_GPL(vhost_vq_init_access);
 static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 			  struct iovec iov[], int iov_size, int access)
 {
-	const struct vhost_umem_node *node;
+	const struct vhost_iotlb_map *map;
 	struct vhost_dev *dev = vq->dev;
-	struct vhost_umem *umem = dev->iotlb ? dev->iotlb : dev->umem;
+	struct vhost_iotlb *umem = dev->iotlb ? dev->iotlb : dev->umem;
 	struct iovec *_iov;
 	u64 s = 0;
 	int ret = 0;
@@ -2060,25 +1978,24 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 			break;
 		}
 
-		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
-							addr, addr + len - 1);
-		if (node == NULL || node->start > addr) {
+		map = vhost_iotlb_itree_first(umem, addr, addr + len - 1);
+		if (map == NULL || map->start > addr) {
 			if (umem != dev->iotlb) {
 				ret = -EFAULT;
 				break;
 			}
 			ret = -EAGAIN;
 			break;
-		} else if (!(node->perm & access)) {
+		} else if (!(map->perm & access)) {
 			ret = -EPERM;
 			break;
 		}
 
 		_iov = iov + ret;
-		size = node->size - addr + node->start;
+		size = map->size - addr + map->start;
 		_iov->iov_len = min((u64)len - s, size);
 		_iov->iov_base = (void __user *)(unsigned long)
-			(node->userspace_addr + addr - node->start);
+				 (map->addr + addr - map->start);
 		s += size;
 		addr += size;
 		++ret;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index a123fd70847e..b99c6ffb6be1 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -12,6 +12,7 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
 #include <linux/atomic.h>
+#include <linux/vhost_iotlb.h>
 
 struct vhost_work;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
@@ -52,27 +53,6 @@ struct vhost_log {
 	u64 len;
 };
 
-#define START(node) ((node)->start)
-#define LAST(node) ((node)->last)
-
-struct vhost_umem_node {
-	struct rb_node rb;
-	struct list_head link;
-	__u64 start;
-	__u64 last;
-	__u64 size;
-	__u64 userspace_addr;
-	__u32 perm;
-	__u32 flags_padding;
-	__u64 __subtree_last;
-};
-
-struct vhost_umem {
-	struct rb_root_cached umem_tree;
-	struct list_head umem_list;
-	int numem;
-};
-
 enum vhost_uaddr_type {
 	VHOST_ADDR_DESC = 0,
 	VHOST_ADDR_AVAIL = 1,
@@ -90,7 +70,7 @@ struct vhost_virtqueue {
 	struct vring_desc __user *desc;
 	struct vring_avail __user *avail;
 	struct vring_used __user *used;
-	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
+	const struct vhost_iotlb_map *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
 	struct eventfd_ctx *call_ctx;
 	struct eventfd_ctx *error_ctx;
@@ -128,8 +108,8 @@ struct vhost_virtqueue {
 	struct iovec *indirect;
 	struct vring_used_elem *heads;
 	/* Protected by virtqueue mutex. */
-	struct vhost_umem *umem;
-	struct vhost_umem *iotlb;
+	struct vhost_iotlb *umem;
+	struct vhost_iotlb *iotlb;
 	void *private_data;
 	u64 acked_features;
 	u64 acked_backend_features;
@@ -164,8 +144,8 @@ struct vhost_dev {
 	struct eventfd_ctx *log_ctx;
 	struct llist_head work_list;
 	struct task_struct *worker;
-	struct vhost_umem *umem;
-	struct vhost_umem *iotlb;
+	struct vhost_iotlb *umem;
+	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
 	struct list_head read_list;
 	struct list_head pending_list;
@@ -182,8 +162,8 @@ void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
 long vhost_dev_set_owner(struct vhost_dev *dev);
 bool vhost_dev_has_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
-struct vhost_umem *vhost_dev_reset_owner_prepare(void);
-void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_umem *);
+struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
+void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *iotlb);
 void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
diff --git a/drivers/vhost/vhost_iotlb.c b/drivers/vhost/vhost_iotlb.c
new file mode 100644
index 000000000000..e08710f1690c
--- /dev/null
+++ b/drivers/vhost/vhost_iotlb.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Red Hat, Inc.
+ * Author: Jason Wang <jasowang@redhat.com>
+ *
+ * IOTLB implementation for vhost.
+ */
+#include <linux/slab.h>
+#include <linux/vhost_iotlb.h>
+#include <linux/module.h>
+
+#define MOD_VERSION  "0.1"
+#define MOD_DESC     "VHOST IOTLB"
+#define MOD_AUTHOR   "Jason Wang <jasowang@redhat.com>"
+#define MOD_LICENSE  "GPL v2"
+
+#define START(map) ((map)->start)
+#define LAST(map) ((map)->last)
+
+INTERVAL_TREE_DEFINE(struct vhost_iotlb_map,
+		     rb, __u64, __subtree_last,
+		     START, LAST, static inline, vhost_iotlb_itree);
+
+static void iotlb_map_free(struct vhost_iotlb *iotlb,
+			   struct vhost_iotlb_map *map)
+{
+	vhost_iotlb_itree_remove(map, &iotlb->root);
+	list_del(&map->link);
+	kfree(map);
+	iotlb->nmaps--;
+}
+
+/**
+ * vhost_iotlb_add_range - add a new range to vhost IOTLB
+ * @iotlb: the IOTLB
+ * @start: start of the IOVA range
+ * @last: last of IOVA range
+ * @addr: the address that is mapped to @start
+ * @perm: access permission of this range
+ *
+ * Returns an error last is smaller than start or memory allocation
+ * fails
+ */
+int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
+			  u64 start, u64 last,
+			  u64 addr, unsigned int perm)
+{
+	struct vhost_iotlb_map *map;
+
+	if (last < start)
+		return -EFAULT;
+
+	if (iotlb->limit &&
+	    iotlb->nmaps == iotlb->limit &&
+	    iotlb->flags & VHOST_IOTLB_FLAG_RETIRE) {
+		map = list_first_entry(&iotlb->list, typeof(*map), link);
+		iotlb_map_free(iotlb, map);
+	}
+
+	map = kmalloc(sizeof(*map), GFP_ATOMIC);
+	if (!map)
+		return -ENOMEM;
+
+	map->start = start;
+	map->size = last - start + 1;
+	map->last = last;
+	map->addr = addr;
+	map->perm = perm;
+
+	iotlb->nmaps++;
+	vhost_iotlb_itree_insert(map, &iotlb->root);
+
+	INIT_LIST_HEAD(&map->link);
+	list_add_tail(&map->link, &iotlb->list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_add_range);
+
+/**
+ * vring_iotlb_del_range - delete overlapped ranges from vhost IOTLB
+ * @iotlb: the IOTLB
+ * @start: start of the IOVA range
+ * @last: last of IOVA range
+ */
+void vhost_iotlb_del_range(struct vhost_iotlb *iotlb, u64 start, u64 last)
+{
+	struct vhost_iotlb_map *map;
+
+	while ((map = vhost_iotlb_itree_iter_first(&iotlb->root,
+						   start, last)))
+		iotlb_map_free(iotlb, map);
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_del_range);
+
+/**
+ * vhost_iotlb_alloc - add a new vhost IOTLB
+ * @limit: maximum number of IOTLB entries
+ * @flags: VHOST_IOTLB_FLAG_XXX
+ *
+ * Returns an error is memory allocation fails
+ */
+struct vhost_iotlb *vhost_iotlb_alloc(unsigned int limit, unsigned int flags)
+{
+	struct vhost_iotlb *iotlb = kzalloc(sizeof(*iotlb), GFP_KERNEL);
+
+	if (!iotlb)
+		return NULL;
+
+	iotlb->root = RB_ROOT_CACHED;
+	iotlb->limit = limit;
+	iotlb->nmaps = 0;
+	iotlb->flags = flags;
+	INIT_LIST_HEAD(&iotlb->list);
+
+	return iotlb;
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_alloc);
+
+/**
+ * vhost_iotlb_reset - reset vhost IOTLB (free all IOTLB entries)
+ * @iotlb: the IOTLB to be reset
+ */
+void vhost_iotlb_reset(struct vhost_iotlb *iotlb)
+{
+	vhost_iotlb_del_range(iotlb, 0ULL, 0ULL - 1);
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_reset);
+
+/**
+ * vhost_iotlb_free - reset and free vhost IOTLB
+ * @iotlb: the IOTLB to be freed
+ */
+void vhost_iotlb_free(struct vhost_iotlb *iotlb)
+{
+	if (iotlb) {
+		vhost_iotlb_reset(iotlb);
+		kfree(iotlb);
+	}
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_free);
+
+/**
+ * vhost_iotlb_itree_first - return the first overlapped range
+ * @iotlb: the IOTLB
+ * @start: start of IOVA range
+ * @end: end of IOVA range
+ */
+struct vhost_iotlb_map *
+vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last)
+{
+	return vhost_iotlb_itree_iter_first(&iotlb->root, start, last);
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_itree_first);
+
+/**
+ * vhost_iotlb_itree_first - return the next overlapped range
+ * @iotlb: the IOTLB
+ * @start: start of IOVA range
+ * @end: end of IOVA range
+ */
+struct vhost_iotlb_map *
+vhost_iotlb_itree_next(struct vhost_iotlb_map *map, u64 start, u64 last)
+{
+	return vhost_iotlb_itree_iter_next(map, start, last);
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_itree_next);
+
+MODULE_VERSION(MOD_VERSION);
+MODULE_DESCRIPTION(MOD_DESC);
+MODULE_AUTHOR(MOD_AUTHOR);
+MODULE_LICENSE(MOD_LICENSE);
diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
new file mode 100644
index 000000000000..a44c61f5627b
--- /dev/null
+++ b/include/linux/vhost_iotlb.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VHOST_IOTLB_H
+#define _LINUX_VHOST_IOTLB_H
+
+#include <linux/interval_tree_generic.h>
+
+struct vhost_iotlb_map {
+	struct rb_node rb;
+	struct list_head link;
+	u64 start;
+	u64 last;
+	u64 size;
+	u64 addr;
+#define VHOST_MAP_RO 0x1
+#define VHOST_MAP_WO 0x2
+#define VHOST_MAP_RW 0x3
+	u32 perm;
+	u32 flags_padding;
+	u64 __subtree_last;
+};
+
+#define VHOST_IOTLB_FLAG_RETIRE 0x1
+
+struct vhost_iotlb {
+	struct rb_root_cached root;
+	struct list_head list;
+	unsigned int limit;
+	unsigned int nmaps;
+	unsigned int flags;
+};
+
+int vhost_iotlb_add_range(struct vhost_iotlb *iotlb, u64 start, u64 last,
+			  u64 addr, unsigned int perm);
+void vhost_iotlb_del_range(struct vhost_iotlb *iotlb, u64 start, u64 last);
+
+struct vhost_iotlb *vhost_iotlb_alloc(unsigned int limit, unsigned int flags);
+void vhost_iotlb_free(struct vhost_iotlb *iotlb);
+void vhost_iotlb_reset(struct vhost_iotlb *iotlb);
+
+struct vhost_iotlb_map *
+vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last);
+struct vhost_iotlb_map *
+vhost_iotlb_itree_next(struct vhost_iotlb_map *map, u64 start, u64 last);
+
+#endif
-- 
2.19.1
