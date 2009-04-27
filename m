From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 7/8] virtio_pci: split up vp_interrupt
Date: Mon, 27 Apr 2009 15:33:13 +0300
Message-ID: <20090427123313.GA1191__2015.55961180038$1240856335$gmane$org@redhat.com>
References: <cover.1240832196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1240832196.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This reorganizes virtio-pci code in vp_interrupt slightly, so that
it's easier to add per-vq MSI support on top.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |   45 +++++++++++++++++++++++++++++++++---------
 1 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 330aacb..151538c 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -164,6 +164,37 @@ static void vp_notify(struct virtqueue *vq)
 	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
 }
 
+/* Handle a configuration change: Tell driver if it wants to know. */
+static irqreturn_t vp_config_changed(int irq, void *opaque)
+{
+	struct virtio_pci_device *vp_dev = opaque;
+	struct virtio_driver *drv;
+	drv = container_of(vp_dev->vdev.dev.driver,
+			   struct virtio_driver, driver);
+
+	if (drv && drv->config_changed)
+		drv->config_changed(&vp_dev->vdev);
+	return IRQ_HANDLED;
+}
+
+/* Notify all virtqueues on an interrupt. */
+static irqreturn_t vp_vring_interrupt(int irq, void *opaque)
+{
+	struct virtio_pci_device *vp_dev = opaque;
+	struct virtio_pci_vq_info *info;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vp_dev->lock, flags);
+	list_for_each_entry(info, &vp_dev->virtqueues, node) {
+		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
+			ret = IRQ_HANDLED;
+	}
+	spin_unlock_irqrestore(&vp_dev->lock, flags);
+
+	return ret;
+}
+
 /* A small wrapper to also acknowledge the interrupt when it's handled.
  * I really need an EIO hook for the vring so I can ack the interrupt once we
  * know that we'll be handling the IRQ but before we invoke the callback since
@@ -173,9 +204,6 @@ static void vp_notify(struct virtqueue *vq)
 static irqreturn_t vp_interrupt(int irq, void *opaque)
 {
 	struct virtio_pci_device *vp_dev = opaque;
-	struct virtio_pci_vq_info *info;
-	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags;
 	u8 isr;
 
 	/* reading the ISR has the effect of also clearing it so it's very
@@ -187,14 +215,11 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 		return IRQ_NONE;
 
 	/* Configuration change?  Tell driver if it wants to know. */
-	if (isr & VIRTIO_PCI_ISR_CONFIG) {
-		struct virtio_driver *drv;
-		drv = container_of(vp_dev->vdev.dev.driver,
-				   struct virtio_driver, driver);
+	if (isr & VIRTIO_PCI_ISR_CONFIG)
+		vp_config_changed(irq, opaque);
 
-		if (drv && drv->config_changed)
-			drv->config_changed(&vp_dev->vdev);
-	}
+	return vp_vring_interrupt(irq, opaque);
+}
 
 	spin_lock_irqsave(&vp_dev->lock, flags);
 	list_for_each_entry(info, &vp_dev->virtqueues, node) {
-- 
1.6.0.6
