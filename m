From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Wed, 23 Jan 2019 17:55:57 +0800
Message-ID: <20190123095557.30168-6-jasowang__30354.1285496735$1548237640$gmane$org@redhat.com>
References: <20190123095557.30168-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190123095557.30168-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jasowang@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

It was noticed that the copy_user() friends that was used to access
virtqueue metdata tends to be very expensive for dataplane
implementation like vhost since it involves lots of software checks,
speculation barrier, hardware feature toggling (e.g SMAP). The
extra cost will be more obvious when transferring small packets since
the time spent on metadata accessing become more significant.

This patch tries to eliminate those overheads by accessing them
through kernel virtual address by vmap(). To make the pages can be
migrated, instead of pinning them through GUP, we use MMU notifiers to
invalidate vmaps and re-establish vmaps during each round of metadata
prefetching if necessary. For devices that doesn't use metadata
prefetching, the memory accessors fallback to normal copy_user()
implementation gracefully. The invalidation was synchronized with
datapath through vq mutex, and in order to avoid hold vq mutex during
range checking, MMU notifier was teared down when trying to modify vq
metadata.

Another thing is kernel lacks efficient solution for tracking dirty
pages by vmap(), this will lead issues if vhost is using file backed
memory which needs care of writeback. This patch solves this issue by
just skipping the vma that is file backed and fallback to normal
copy_user() friends. This might introduce some overheads for file
backed users but consider this use case is rare we could do
optimizations on top.

Note that this was only done when device IOTLB is not enabled. We
could use similar method to optimize it in the future.

Tests shows at most about 22% improvement on TX PPS when using
virtio-user + vhost_net + xdp1 + TAP on 2.6GHz Broadwell:

        SMAP on | SMAP off
Before: 5.0Mpps | 6.6Mpps
After:  6.1Mpps | 7.4Mpps

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 288 +++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  13 ++
 mm/shmem.c            |   1 +
 3 files changed, 300 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 37e2cac8e8b0..096ae3298d62 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -440,6 +440,9 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->indirect = NULL;
 		vq->heads = NULL;
 		vq->dev = dev;
+		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
+		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
+		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
@@ -510,6 +513,73 @@ static size_t vhost_get_desc_size(struct vhost_virtqueue *vq, int num)
 	return sizeof(*vq->desc) * num;
 }
 
+static void vhost_uninit_vmap(struct vhost_vmap *map)
+{
+	if (map->addr)
+		vunmap(map->unmap_addr);
+
+	map->addr = NULL;
+	map->unmap_addr = NULL;
+}
+
+static int vhost_invalidate_vmap(struct vhost_virtqueue *vq,
+				 struct vhost_vmap *map,
+				 unsigned long ustart,
+				 size_t size,
+				 unsigned long start,
+				 unsigned long end,
+				 bool blockable)
+{
+	if (end < ustart || start > ustart - 1 + size)
+		return 0;
+
+	if (!blockable)
+		return -EAGAIN;
+
+	mutex_lock(&vq->mutex);
+	vhost_uninit_vmap(map);
+	mutex_unlock(&vq->mutex);
+
+	return 0;
+}
+
+static int vhost_invalidate_range_start(struct mmu_notifier *mn,
+					const struct mmu_notifier_range *range)
+{
+	struct vhost_dev *dev = container_of(mn, struct vhost_dev,
+					     mmu_notifier);
+	int i;
+
+	for (i = 0; i < dev->nvqs; i++) {
+		struct vhost_virtqueue *vq = dev->vqs[i];
+
+		if (vhost_invalidate_vmap(vq, &vq->avail_ring,
+					  (unsigned long)vq->avail,
+					  vhost_get_avail_size(vq, vq->num),
+					  range->start, range->end,
+					  range->blockable))
+			return -EAGAIN;
+		if (vhost_invalidate_vmap(vq, &vq->desc_ring,
+					  (unsigned long)vq->desc,
+					  vhost_get_desc_size(vq, vq->num),
+					  range->start, range->end,
+					  range->blockable))
+			return -EAGAIN;
+		if (vhost_invalidate_vmap(vq, &vq->used_ring,
+					  (unsigned long)vq->used,
+					  vhost_get_used_size(vq, vq->num),
+					  range->start, range->end,
+					  range->blockable))
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
+	.invalidate_range_start = vhost_invalidate_range_start,
+};
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -541,7 +611,14 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 	if (err)
 		goto err_cgroup;
 
+	dev->mmu_notifier.ops = &vhost_mmu_notifier_ops;
+	err = mmu_notifier_register(&dev->mmu_notifier, dev->mm);
+	if (err)
+		goto err_mmu_notifier;
+
 	return 0;
+err_mmu_notifier:
+	vhost_dev_free_iovecs(dev);
 err_cgroup:
 	kthread_stop(worker);
 	dev->worker = NULL;
@@ -632,6 +709,97 @@ static void vhost_clear_msg(struct vhost_dev *dev)
 	spin_unlock(&dev->iotlb_lock);
 }
 
+/* Suppress the vma that needs writeback since we can not track dirty
+ * pages now.
+ */
+static bool vma_can_vmap(struct vm_area_struct *vma)
+{
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	       vma_is_shmem(vma);
+}
+
+static int vhost_init_vmap(struct vhost_dev *dev,
+			   struct vhost_vmap *map, unsigned long uaddr,
+			   size_t size, int write)
+{
+	struct mm_struct *mm = dev->mm;
+	struct vm_area_struct *vma;
+	struct page **pages;
+	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
+	int npinned;
+	void *vaddr;
+	int err = 0;
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, uaddr);
+	if (!vma || !vma_can_vmap(vma) ||
+	    vma->vm_end < uaddr - 1 + size) {
+		err = -EINVAL;
+		goto err_vma;
+	}
+
+	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
+
+	npinned = get_user_pages_fast(uaddr, npages, write, pages);
+	if (npinned != npages) {
+		err = -EFAULT;
+		goto err_gup;
+	}
+
+	vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
+	if (!vaddr) {
+		err = EFAULT;
+		goto err_gup;
+	}
+
+	map->addr = vaddr + (uaddr & (PAGE_SIZE - 1));
+	map->unmap_addr = vaddr;
+
+err_gup:
+	/* Don't pin pages, mmu notifier will notify us about page
+	 * migration.
+	 */
+	if (npinned > 0)
+		release_pages(pages, npinned);
+err_alloc:
+	kfree(pages);
+err_vma:
+	up_read(&mm->mmap_sem);
+	return err;
+}
+
+static void vhost_clean_vmaps(struct vhost_virtqueue *vq)
+{
+	vhost_uninit_vmap(&vq->avail_ring);
+	vhost_uninit_vmap(&vq->desc_ring);
+	vhost_uninit_vmap(&vq->used_ring);
+}
+
+static int vhost_setup_avail_vmap(struct vhost_virtqueue *vq,
+				  unsigned long avail)
+{
+	return vhost_init_vmap(vq->dev, &vq->avail_ring, avail,
+			       vhost_get_avail_size(vq, vq->num), false);
+}
+
+static int vhost_setup_desc_vmap(struct vhost_virtqueue *vq,
+				 unsigned long desc)
+{
+	return vhost_init_vmap(vq->dev, &vq->desc_ring, desc,
+			       vhost_get_desc_size(vq, vq->num), false);
+}
+
+static int vhost_setup_used_vmap(struct vhost_virtqueue *vq,
+				 unsigned long used)
+{
+	return vhost_init_vmap(vq->dev, &vq->used_ring, used,
+			       vhost_get_used_size(vq, vq->num), true);
+}
+
 void vhost_dev_cleanup(struct vhost_dev *dev)
 {
 	int i;
@@ -661,8 +829,12 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		kthread_stop(dev->worker);
 		dev->worker = NULL;
 	}
-	if (dev->mm)
+	if (dev->mm) {
+		mmu_notifier_unregister(&dev->mmu_notifier, dev->mm);
 		mmput(dev->mm);
+	}
+	for (i = 0; i < dev->nvqs; i++)
+		vhost_clean_vmaps(dev->vqs[i]);
 	dev->mm = NULL;
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
@@ -891,6 +1063,16 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 
 static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			*((__virtio16 *)&used->ring[vq->num]) =
+				cpu_to_vhost16(vq, vq->avail_idx);
+			return 0;
+		}
+	}
+
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
 			      vhost_avail_event(vq));
 }
@@ -899,6 +1081,16 @@ static inline int vhost_put_used(struct vhost_virtqueue *vq,
 				 struct vring_used_elem *head, int idx,
 				 int count)
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			memcpy(used->ring + idx, head,
+			       count * sizeof(*head));
+			return 0;
+		}
+	}
+
 	return vhost_copy_to_user(vq, vq->used->ring + idx, head,
 				  count * sizeof(*head));
 }
@@ -906,6 +1098,15 @@ static inline int vhost_put_used(struct vhost_virtqueue *vq,
 static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
 
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			used->flags = cpu_to_vhost16(vq, vq->used_flags);
+			return 0;
+		}
+	}
+
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
 			      &vq->used->flags);
 }
@@ -913,6 +1114,15 @@ static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
 static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
 
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			used->idx = cpu_to_vhost16(vq, vq->last_used_idx);
+			return 0;
+		}
+	}
+
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
 			      &vq->used->idx);
 }
@@ -958,12 +1168,30 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
 				      __virtio16 *idx)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*idx = avail->idx;
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *idx, &vq->avail->idx);
 }
 
 static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
 				       __virtio16 *head, int idx)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*head = avail->ring[idx & (vq->num - 1)];
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *head,
 			       &vq->avail->ring[idx & (vq->num - 1)]);
 }
@@ -971,24 +1199,60 @@ static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
 static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
 					__virtio16 *flags)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*flags = avail->flags;
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *flags, &vq->avail->flags);
 }
 
 static inline int vhost_get_used_event(struct vhost_virtqueue *vq,
 				       __virtio16 *event)
 {
+	if (!vq->iotlb) {
+		struct vring_avail *avail = vq->avail_ring.addr;
+
+		if (likely(avail)) {
+			*event = (__virtio16)avail->ring[vq->num];
+			return 0;
+		}
+	}
+
 	return vhost_get_avail(vq, *event, vhost_used_event(vq));
 }
 
 static inline int vhost_get_used_idx(struct vhost_virtqueue *vq,
 				     __virtio16 *idx)
 {
+	if (!vq->iotlb) {
+		struct vring_used *used = vq->used_ring.addr;
+
+		if (likely(used)) {
+			*idx = used->idx;
+			return 0;
+		}
+	}
+
 	return vhost_get_used(vq, *idx, &vq->used->idx);
 }
 
 static inline int vhost_get_desc(struct vhost_virtqueue *vq,
 				 struct vring_desc *desc, int idx)
 {
+	if (!vq->iotlb) {
+		struct vring_desc *d = vq->desc_ring.addr;
+
+		if (likely(d)) {
+			*desc = *(d + idx);
+			return 0;
+		}
+	}
+
 	return vhost_copy_from_user(vq, desc, vq->desc + idx, sizeof(*desc));
 }
 
@@ -1329,8 +1593,16 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	unsigned int num = vq->num;
 
-	if (!vq->iotlb)
+	if (!vq->iotlb) {
+		if (unlikely(!vq->avail_ring.addr))
+			vhost_setup_avail_vmap(vq, (unsigned long)vq->avail);
+		if (unlikely(!vq->desc_ring.addr))
+			vhost_setup_desc_vmap(vq, (unsigned long)vq->desc);
+		if (unlikely(!vq->used_ring.addr))
+			vhost_setup_used_vmap(vq, (unsigned long)vq->used);
+
 		return 1;
+	}
 
 	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
 			       vhost_get_desc_size(vq, num), VHOST_ADDR_DESC) &&
@@ -1482,6 +1754,13 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 
 	mutex_lock(&vq->mutex);
 
+	/* Unregister MMU notifer to allow invalidation callback
+	 * can access vq->avail, vq->desc , vq->used and vq->num
+	 * without holding vq->mutex.
+	 */
+	if (d->mm)
+		mmu_notifier_unregister(&d->mmu_notifier, d->mm);
+
 	switch (ioctl) {
 	case VHOST_SET_VRING_NUM:
 		/* Resizing ring with an active backend?
@@ -1498,6 +1777,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EINVAL;
 			break;
 		}
+		vhost_clean_vmaps(vq);
 		vq->num = s.num;
 		break;
 	case VHOST_SET_VRING_BASE:
@@ -1575,6 +1855,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			}
 		}
 
+		vhost_clean_vmaps(vq);
+
 		vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
 		vq->desc = (void __user *)(unsigned long)a.desc_user_addr;
 		vq->avail = (void __user *)(unsigned long)a.avail_user_addr;
@@ -1655,6 +1937,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	if (pollstart && vq->handle_kick)
 		r = vhost_poll_start(&vq->poll, vq->kick);
 
+	if (d->mm)
+		mmu_notifier_register(&d->mmu_notifier, d->mm);
 	mutex_unlock(&vq->mutex);
 
 	if (pollstop && vq->handle_kick)
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 4e21011b6628..c04bc327db9f 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -12,6 +12,8 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
 #include <linux/atomic.h>
+#include <linux/pagemap.h>
+#include <linux/mmu_notifier.h>
 
 struct vhost_work;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
@@ -80,6 +82,11 @@ enum vhost_uaddr_type {
 	VHOST_NUM_ADDRS = 3,
 };
 
+struct vhost_vmap {
+	void *addr;
+	void *unmap_addr;
+};
+
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
@@ -90,6 +97,11 @@ struct vhost_virtqueue {
 	struct vring_desc __user *desc;
 	struct vring_avail __user *avail;
 	struct vring_used __user *used;
+
+	struct vhost_vmap avail_ring;
+	struct vhost_vmap desc_ring;
+	struct vhost_vmap used_ring;
+
 	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
 	struct eventfd_ctx *call_ctx;
@@ -158,6 +170,7 @@ struct vhost_msg_node {
 
 struct vhost_dev {
 	struct mm_struct *mm;
+	struct mmu_notifier mmu_notifier;
 	struct mutex mutex;
 	struct vhost_virtqueue **vqs;
 	int nvqs;
diff --git a/mm/shmem.c b/mm/shmem.c
index 6ece1e2fe76e..745e7c7f7a6c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -237,6 +237,7 @@ bool vma_is_shmem(struct vm_area_struct *vma)
 {
 	return vma->vm_ops == &shmem_vm_ops;
 }
+EXPORT_SYMBOL_GPL(vma_is_shmem);
 
 static LIST_HEAD(shmem_swaplist);
 static DEFINE_MUTEX(shmem_swaplist_mutex);
-- 
2.17.1
