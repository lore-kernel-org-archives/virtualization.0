From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 07/15] virtio: factor virtqueue initialization
Date: Fri,  7 Apr 2017 20:24:47 +0100
Message-ID: <20170407192455.26814-8-jean-philippe.brucker__22241.3118034185$1491593170$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

All virtio devices are doing the same few operations when initializing
their virtqueues. Move these operations to virtio core, as we'll have to
complexify vring initialization when implementing a virtual IOMMU.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/kvm/virtio.h | 16 +++++++++-------
 virtio/9p.c          |  7 ++-----
 virtio/balloon.c     |  7 +++----
 virtio/blk.c         | 10 ++--------
 virtio/console.c     |  7 ++-----
 virtio/iommu.c       | 10 ++--------
 virtio/net.c         |  8 ++------
 virtio/rng.c         |  6 ++----
 virtio/scsi.c        |  6 ++----
 9 files changed, 26 insertions(+), 51 deletions(-)

diff --git a/include/kvm/virtio.h b/include/kvm/virtio.h
index 00a791ac..24c0c487 100644
--- a/include/kvm/virtio.h
+++ b/include/kvm/virtio.h
@@ -169,15 +169,17 @@ int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 int virtio_compat_add_message(const char *device, const char *config);
 const char* virtio_trans_name(enum virtio_trans trans);
 
-static inline void *virtio_get_vq(struct kvm *kvm, u32 pfn, u32 page_size)
+static inline void virtio_init_device_vq(struct kvm *kvm,
+					 struct virtio_device *vdev,
+					 struct virt_queue *vq, size_t nr_descs,
+					 u32 page_size, u32 align, u32 pfn)
 {
-	return guest_flat_to_host(kvm, (u64)pfn * page_size);
-}
+	void *p		= guest_flat_to_host(kvm, (u64)pfn * page_size);
 
-static inline void virtio_init_device_vq(struct virtio_device *vdev,
-					 struct virt_queue *vq)
-{
-	vq->endian = vdev->endian;
+	vq->endian	= vdev->endian;
+	vq->pfn		= pfn;
+
+	vring_init(&vq->vring, nr_descs, p, align);
 }
 
 #endif /* KVM__VIRTIO_H */
diff --git a/virtio/9p.c b/virtio/9p.c
index 69fdc4be..acd09bdd 100644
--- a/virtio/9p.c
+++ b/virtio/9p.c
@@ -1388,17 +1388,14 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	struct p9_dev *p9dev = dev;
 	struct p9_dev_job *job;
 	struct virt_queue *queue;
-	void *p;
 
 	compat__remove_message(compat_id);
 
 	queue		= &p9dev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 	job		= &p9dev->jobs[vq];
 
-	vring_init(&queue->vring, VIRTQUEUE_NUM, p, align);
-	virtio_init_device_vq(&p9dev->vdev, queue);
+	virtio_init_device_vq(kvm, &p9dev->vdev, queue, VIRTQUEUE_NUM,
+			      page_size, align, pfn);
 
 	*job		= (struct p9_dev_job) {
 		.vq		= queue,
diff --git a/virtio/balloon.c b/virtio/balloon.c
index 9564aa39..9182cae6 100644
--- a/virtio/balloon.c
+++ b/virtio/balloon.c
@@ -198,16 +198,15 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 {
 	struct bln_dev *bdev = dev;
 	struct virt_queue *queue;
-	void *p;
 
 	compat__remove_message(compat_id);
 
 	queue		= &bdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
+
+	virtio_init_device_vq(kvm, &bdev->vdev, queue, VIRTIO_BLN_QUEUE_SIZE,
+			      page_size, align, pfn);
 
 	thread_pool__init_job(&bdev->jobs[vq], kvm, virtio_bln_do_io, queue);
-	vring_init(&queue->vring, VIRTIO_BLN_QUEUE_SIZE, p, align);
 
 	return 0;
 }
diff --git a/virtio/blk.c b/virtio/blk.c
index c485e4fc..8c6e59ba 100644
--- a/virtio/blk.c
+++ b/virtio/blk.c
@@ -178,17 +178,11 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 		   u32 pfn)
 {
 	struct blk_dev *bdev = dev;
-	struct virt_queue *queue;
-	void *p;
 
 	compat__remove_message(compat_id);
 
-	queue		= &bdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
-
-	vring_init(&queue->vring, VIRTIO_BLK_QUEUE_SIZE, p, align);
-	virtio_init_device_vq(&bdev->vdev, queue);
+	virtio_init_device_vq(kvm, &bdev->vdev, &bdev->vqs[vq],
+			      VIRTIO_BLK_QUEUE_SIZE, page_size, align, pfn);
 
 	return 0;
 }
diff --git a/virtio/console.c b/virtio/console.c
index f1c0a190..610962c4 100644
--- a/virtio/console.c
+++ b/virtio/console.c
@@ -143,18 +143,15 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 		   u32 pfn)
 {
 	struct virt_queue *queue;
-	void *p;
 
 	BUG_ON(vq >= VIRTIO_CONSOLE_NUM_QUEUES);
 
 	compat__remove_message(compat_id);
 
 	queue		= &cdev.vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
-	vring_init(&queue->vring, VIRTIO_CONSOLE_QUEUE_SIZE, p, align);
-	virtio_init_device_vq(&cdev.vdev, queue);
+	virtio_init_device_vq(kvm, &cdev.vdev, queue, VIRTIO_CONSOLE_QUEUE_SIZE,
+			      page_size, align, pfn);
 
 	if (vq == VIRTIO_CONSOLE_TX_QUEUE) {
 		thread_pool__init_job(&cdev.jobs[vq], kvm, virtio_console_handle_callback, queue);
diff --git a/virtio/iommu.c b/virtio/iommu.c
index c72e7322..2e5a23ee 100644
--- a/virtio/iommu.c
+++ b/virtio/iommu.c
@@ -497,8 +497,6 @@ static void viommu_set_guest_features(struct kvm *kvm, void *dev, u32 features)
 static int viommu_init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size,
 			  u32 align, u32 pfn)
 {
-	void *ptr;
-	struct virt_queue *queue;
 	struct viommu_dev *viommu = dev;
 
 	if (vq != 0)
@@ -506,12 +504,8 @@ static int viommu_init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size,
 
 	compat__remove_message(compat_id);
 
-	queue = &viommu->vq;
-	queue->pfn = pfn;
-	ptr = virtio_get_vq(kvm, queue->pfn, page_size);
-
-	vring_init(&queue->vring, viommu->queue_size, ptr, align);
-	virtio_init_device_vq(&viommu->vdev, queue);
+	virtio_init_device_vq(kvm, &viommu->vdev, &viommu->vq,
+			      viommu->queue_size, page_size, align, pfn);
 
 	thread_pool__init_job(&viommu->job, kvm, viommu_command, viommu);
 
diff --git a/virtio/net.c b/virtio/net.c
index 529b4111..957cca09 100644
--- a/virtio/net.c
+++ b/virtio/net.c
@@ -505,17 +505,13 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	struct vhost_vring_addr addr;
 	struct net_dev *ndev = dev;
 	struct virt_queue *queue;
-	void *p;
 	int r;
 
 	compat__remove_message(compat_id);
 
 	queue		= &ndev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
-
-	vring_init(&queue->vring, VIRTIO_NET_QUEUE_SIZE, p, align);
-	virtio_init_device_vq(&ndev->vdev, queue);
+	virtio_init_device_vq(kvm, &ndev->vdev, queue, VIRTIO_NET_QUEUE_SIZE,
+			      page_size, align, pfn);
 
 	mutex_init(&ndev->io_lock[vq]);
 	pthread_cond_init(&ndev->io_cond[vq], NULL);
diff --git a/virtio/rng.c b/virtio/rng.c
index 9b9e1283..5f525540 100644
--- a/virtio/rng.c
+++ b/virtio/rng.c
@@ -92,17 +92,15 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	struct rng_dev *rdev = dev;
 	struct virt_queue *queue;
 	struct rng_dev_job *job;
-	void *p;
 
 	compat__remove_message(compat_id);
 
 	queue		= &rdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
 	job = &rdev->jobs[vq];
 
-	vring_init(&queue->vring, VIRTIO_RNG_QUEUE_SIZE, p, align);
+	virtio_init_device_vq(kvm, &rdev->vdev, queue, VIRTIO_RNG_QUEUE_SIZE,
+			      page_size, align, pfn);
 
 	*job = (struct rng_dev_job) {
 		.vq	= queue,
diff --git a/virtio/scsi.c b/virtio/scsi.c
index a429ac85..e0fd85f6 100644
--- a/virtio/scsi.c
+++ b/virtio/scsi.c
@@ -57,16 +57,14 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	struct vhost_vring_addr addr;
 	struct scsi_dev *sdev = dev;
 	struct virt_queue *queue;
-	void *p;
 	int r;
 
 	compat__remove_message(compat_id);
 
 	queue		= &sdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
-	vring_init(&queue->vring, VIRTIO_SCSI_QUEUE_SIZE, p, align);
+	virtio_init_device_vq(kvm, &sdev->vdev, queue, VIRTIO_SCSI_QUEUE_SIZE,
+			      page_size, align, pfn);
 
 	if (sdev->vhost_fd == 0)
 		return 0;
-- 
2.12.1
