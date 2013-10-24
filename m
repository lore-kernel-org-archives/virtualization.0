From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 1/9] virtio_ring: change host notification API
Date: Thu, 24 Oct 2013 17:23:12 +0200
Message-ID: <1382628200-42956-2-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Currently a host kick error is silently ignored and not reflected in
the virtqueue of a particular virtio device.

Changing the notify API for guest->host notification seems to be one
prerequisite in order to be able to handle such errors in the context
where the kick is triggered.

This patch changes the notify API. The notify function must return a
negative int return value in case the host notification failed.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/lguest/lguest_device.c         |  3 ++-
 drivers/remoteproc/remoteproc_virtio.c |  3 ++-
 drivers/s390/kvm/kvm_virtio.c          |  8 ++++++--
 drivers/s390/kvm/virtio_ccw.c          |  5 ++++-
 drivers/virtio/virtio_mmio.c           |  3 ++-
 drivers/virtio/virtio_pci.c            |  3 ++-
 drivers/virtio/virtio_ring.c           |  4 ++--
 include/linux/virtio_ring.h            |  2 +-
 tools/virtio/virtio_test.c             |  3 ++-
 tools/virtio/vringh_test.c             | 13 +++++++++----
 10 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index b3256ff..1275f18 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -229,7 +229,7 @@ struct lguest_vq_info {
  * make a hypercall.  We hand the physical address of the virtqueue so the Host
  * knows which virtqueue we're talking about.
  */
-static void lg_notify(struct virtqueue *vq)
+static int lg_notify(struct virtqueue *vq)
 {
 	/*
 	 * We store our virtqueue information in the "priv" pointer of the
@@ -238,6 +238,7 @@ static void lg_notify(struct virtqueue *vq)
 	struct lguest_vq_info *lvq = vq->priv;
 
 	hcall(LHCALL_NOTIFY, lvq->config.pfn << PAGE_SHIFT, 0, 0, 0);
+	return 0;
 }
 
 /* An extern declaration inside a C file is bad form.  Don't do it. */
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index b09c75c..39723ee 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -30,7 +30,7 @@
 #include "remoteproc_internal.h"
 
 /* kick the remote processor, and let it know which virtqueue to poke at */
-static void rproc_virtio_notify(struct virtqueue *vq)
+static int rproc_virtio_notify(struct virtqueue *vq)
 {
 	struct rproc_vring *rvring = vq->priv;
 	struct rproc *rproc = rvring->rvdev->rproc;
@@ -39,6 +39,7 @@ static void rproc_virtio_notify(struct virtqueue *vq)
 	dev_dbg(&rproc->dev, "kicking vq index: %d\n", notifyid);
 
 	rproc->ops->kick(rproc, notifyid);
+	return 0;
 }
 
 /**
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 2ea6165..4097a46 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -166,11 +166,15 @@ static void kvm_reset(struct virtio_device *vdev)
  * make a hypercall.  We hand the address  of the virtqueue so the Host
  * knows which virtqueue we're talking about.
  */
-static void kvm_notify(struct virtqueue *vq)
+static int kvm_notify(struct virtqueue *vq)
 {
+	long rc;
 	struct kvm_vqconfig *config = vq->priv;
 
-	kvm_hypercall1(KVM_S390_VIRTIO_NOTIFY, config->address);
+	rc = kvm_hypercall1(KVM_S390_VIRTIO_NOTIFY, config->address);
+	if (rc < 0)
+		return rc;
+	return 0;
 }
 
 /*
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 6a410d4..c640ecd 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -375,7 +375,7 @@ static inline long do_kvm_notify(struct subchannel_id schid,
 	return __rc;
 }
 
-static void virtio_ccw_kvm_notify(struct virtqueue *vq)
+static int virtio_ccw_kvm_notify(struct virtqueue *vq)
 {
 	struct virtio_ccw_vq_info *info = vq->priv;
 	struct virtio_ccw_device *vcdev;
@@ -384,6 +384,9 @@ static void virtio_ccw_kvm_notify(struct virtqueue *vq)
 	vcdev = to_vc_device(info->vq->vdev);
 	ccw_device_get_schid(vcdev->cdev, &schid);
 	info->cookie = do_kvm_notify(schid, vq->index, info->cookie);
+	if (info->cookie < 0)
+		return info->cookie;
+	return 0;
 }
 
 static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1ba0d68..e213991 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -219,13 +219,14 @@ static void vm_reset(struct virtio_device *vdev)
 /* Transport interface */
 
 /* the notify function used when creating a virt queue */
-static void vm_notify(struct virtqueue *vq)
+static int vm_notify(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
 
 	/* We write the queue's selector into the notification register to
 	 * signal the other end */
 	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	return 0;
 }
 
 /* Notify all virtqueues on an interrupt. */
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a7ce730..7988137 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -197,13 +197,14 @@ static void vp_reset(struct virtio_device *vdev)
 }
 
 /* the notify function used when creating a virt queue */
-static void vp_notify(struct virtqueue *vq)
+static int vp_notify(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 
 	/* we write the queue's selector into the notification register to
 	 * signal the other end */
 	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
+	return 0;
 }
 
 /* Handle a configuration change: Tell driver if it wants to know. */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5217baf..aa40f6c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -81,7 +81,7 @@ struct vring_virtqueue
 	u16 last_used_idx;
 
 	/* How to notify other side. FIXME: commonalize hcalls! */
-	void (*notify)(struct virtqueue *vq);
+	int (*notify)(struct virtqueue *vq);
 
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
@@ -741,7 +741,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
 				      void *pages,
-				      void (*notify)(struct virtqueue *),
+				      int (*notify)(struct virtqueue *),
 				      void (*callback)(struct virtqueue *),
 				      const char *name)
 {
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index ca3ad41..74fa580 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -70,7 +70,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
 				      void *pages,
-				      void (*notify)(struct virtqueue *vq),
+				      int (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name);
 void vring_del_virtqueue(struct virtqueue *vq);
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index da7a195..8e3e432 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -41,13 +41,14 @@ struct vdev_info {
 	struct vhost_memory *mem;
 };
 
-void vq_notify(struct virtqueue *vq)
+int vq_notify(struct virtqueue *vq)
 {
 	struct vq_info *info = vq->priv;
 	unsigned long long v = 1;
 	int r;
 	r = write(info->kick, &v, sizeof v);
 	assert(r == sizeof v);
+	return 0;
 }
 
 void vq_callback(struct virtqueue *vq)
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index d053ea4..965ccfe 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -22,7 +22,7 @@ static u64 user_addr_offset;
 #define RINGSIZE 256
 #define ALIGN 4096
 
-static void never_notify_host(struct virtqueue *vq)
+static int never_notify_host(struct virtqueue *vq)
 {
 	abort();
 }
@@ -65,17 +65,22 @@ struct guest_virtio_device {
 	unsigned long notifies;
 };
 
-static void parallel_notify_host(struct virtqueue *vq)
+static int parallel_notify_host(struct virtqueue *vq)
 {
+	int rc;
 	struct guest_virtio_device *gvdev;
 
 	gvdev = container_of(vq->vdev, struct guest_virtio_device, vdev);
-	write(gvdev->to_host_fd, "", 1);
+	rc = write(gvdev->to_host_fd, "", 1);
+	if (rc < 0)
+		return rc;
 	gvdev->notifies++;
+	return 0;
 }
 
-static void no_notify_host(struct virtqueue *vq)
+static int no_notify_host(struct virtqueue *vq)
 {
+	return 0;
 }
 
 #define NUM_XFERS (10000000)
-- 
1.8.3.1
