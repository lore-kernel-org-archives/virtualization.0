From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 07/22] virtio_pci: Use request_threaded_irq() instead of request_irq()
Date: Thu, 2 Jul 2020 13:51:28 +0530
Message-ID: <20200702082143.25259-8-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Some of the virtio drivers (like virtio_rpmsg_bus.c) use sleeping
functions like mutex_*() in the virtqueue callback. Use
request_threaded_irq() instead of request_irq() in order for
the virtqueue callbacks to be executed in thread context instead
of interrupt context.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/virtio/virtio_pci_common.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 222d630c41fc..60998b4f1f30 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -140,9 +140,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	v = vp_dev->msix_used_vectors;
 	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 		 "%s-config", name);
-	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-			  vp_config_changed, 0, vp_dev->msix_names[v],
-			  vp_dev);
+	err = request_threaded_irq(pci_irq_vector(vp_dev->pci_dev, v), 0,
+				   vp_config_changed, 0, vp_dev->msix_names[v],
+				   vp_dev);
 	if (err)
 		goto error;
 	++vp_dev->msix_used_vectors;
@@ -159,9 +159,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		v = vp_dev->msix_used_vectors;
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 			 "%s-virtqueues", name);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
-				  vp_dev);
+		err = request_threaded_irq(pci_irq_vector(vp_dev->pci_dev, v),
+					   0, vp_vring_interrupt, 0,
+					   vp_dev->msix_names[v], vp_dev);
 		if (err)
 			goto error;
 		++vp_dev->msix_used_vectors;
@@ -336,10 +336,11 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			 sizeof *vp_dev->msix_names,
 			 "%s-%s",
 			 dev_name(&vp_dev->vdev.dev), names[i]);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
+		err = request_threaded_irq(pci_irq_vector(vp_dev->pci_dev,
+							  msix_vec),
+					   0, vring_interrupt, 0,
+					   vp_dev->msix_names[msix_vec],
+					   vqs[i]);
 		if (err)
 			goto error_find;
 	}
@@ -361,8 +362,8 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
-	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
-			dev_name(&vdev->dev), vp_dev);
+	err = request_threaded_irq(vp_dev->pci_dev->irq, 0, vp_interrupt,
+				   IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
 	if (err)
 		goto out_del_vqs;
 
-- 
2.17.1
