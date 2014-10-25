From: "john.liuli" <john.liuli@huawei.com>
Subject: [RFC PATCH 2/2] Assign a new irq handler while irqfd enabled
Date: Sat, 25 Oct 2014 16:24:54 +0800
Message-ID: <1414225494-2208-3-git-send-email-john.liuli__31016.4985749454$1414417106$gmane$org@huawei.com>
References: <1414225494-2208-1-git-send-email-john.liuli@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1414225494-2208-1-git-send-email-john.liuli@huawei.com>
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
Cc: joel.schopp@amd.com, yingshiuan.pan@gmail.com, mst@redhat.com, Li Liu <john.liuli@huawei.com>, remy.gauguey@cea.fr, qemu-devel@nongnu.org, n.nikolaev@virtualopensystems.com, virtualization@lists.linux-foundation.org, peter.huangpeng@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

From: Li Liu <john.liuli@huawei.com>

This irq handler will get the interrupt reason from a
shared memory. And will be assigned only while irqfd
enabled.

Signed-off-by: Li Liu <john.liuli@huawei.com>
---
 drivers/virtio/virtio_mmio.c |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 28ddb55..7229605 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -259,7 +259,31 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	return ret;
 }
 
+/* Notify all virtqueues on an interrupt. */
+static irqreturn_t vm_interrupt_irqfd(int irq, void *opaque)
+{
+	struct virtio_mmio_device *vm_dev = opaque;
+	struct virtio_mmio_vq_info *info;
+	unsigned long status;
+	unsigned long flags;
+	irqreturn_t ret = IRQ_NONE;
 
+	/* Read the interrupt reason and reset it */
+	status = *vm_dev->isr_mem;
+	*vm_dev->isr_mem = 0x0;
+
+	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
+		virtio_config_changed(&vm_dev->vdev);
+		ret = IRQ_HANDLED;
+	}
+
+	spin_lock_irqsave(&vm_dev->lock, flags);
+	list_for_each_entry(info, &vm_dev->virtqueues, node)
+		ret |= vring_interrupt(irq, info->vq);
+	spin_unlock_irqrestore(&vm_dev->lock, flags);
+
+	return ret;
+}
 
 static void vm_del_vq(struct virtqueue *vq)
 {
@@ -391,6 +415,7 @@ error_available:
 	return ERR_PTR(err);
 }
 
+#define VIRTIO_MMIO_F_IRQFD        (1 << 7)
 static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct virtqueue *vqs[],
 		       vq_callback_t *callbacks[],
@@ -400,8 +425,13 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
 	int i, err;
 
-	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
-			dev_name(&vdev->dev), vm_dev);
+	if (*vm_dev->isr_mem & VIRTIO_MMIO_F_IRQFD) {
+		err = request_irq(irq, vm_interrupt_irqfd, IRQF_SHARED,
+				  dev_name(&vdev->dev), vm_dev);
+	} else {
+		err = request_irq(irq, vm_interrupt, IRQF_SHARED,
+				  dev_name(&vdev->dev), vm_dev);
+	}
 	if (err)
 		return err;
 
-- 
1.7.9.5
