From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 13/22] rpmsg: virtio_rpmsg_bus: Use virtio_alloc_buffer() and virtio_free_buffer()
Date: Thu, 2 Jul 2020 13:51:34 +0530
Message-ID: <20200702082143.25259-14-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Use virtio_alloc_buffer() and virtio_free_buffer() to allocate and free
memory buffer respectively. Only if buffer allocation using
virtio_alloc_buffer() try using dma_alloc_coherent(). This is required
for devices like NTB to use rpmsg for communicating with other host.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index f91143b25af7..2b25a8ae1539 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -882,13 +882,16 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 	total_buf_space = vrp->num_bufs * vrp->buf_size;
 
-	/* allocate coherent memory for the buffers */
-	bufs_va = dma_alloc_coherent(vdev->dev.parent,
-				     total_buf_space, &vrp->bufs_dma,
-				     GFP_KERNEL);
+	bufs_va = virtio_alloc_buffer(vdev, total_buf_space);
 	if (!bufs_va) {
-		err = -ENOMEM;
-		goto vqs_del;
+		/* allocate coherent memory for the buffers */
+		bufs_va = dma_alloc_coherent(vdev->dev.parent,
+					     total_buf_space, &vrp->bufs_dma,
+					     GFP_KERNEL);
+		if (!bufs_va) {
+			err = -ENOMEM;
+			goto vqs_del;
+		}
 	}
 
 	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
@@ -951,8 +954,13 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	return 0;
 
 free_coherent:
-	dma_free_coherent(vdev->dev.parent, total_buf_space,
-			  bufs_va, vrp->bufs_dma);
+	if (!vrp->bufs_dma) {
+		virtio_free_buffer(vdev, bufs_va, total_buf_space);
+	} else {
+		dma_free_coherent(vdev->dev.parent, total_buf_space,
+				  bufs_va, vrp->bufs_dma);
+	}
+
 vqs_del:
 	vdev->config->del_vqs(vrp->vdev);
 free_vrp:
@@ -986,8 +994,12 @@ static void rpmsg_remove(struct virtio_device *vdev)
 
 	vdev->config->del_vqs(vrp->vdev);
 
-	dma_free_coherent(vdev->dev.parent, total_buf_space,
-			  vrp->rbufs, vrp->bufs_dma);
+	if (!vrp->bufs_dma) {
+		virtio_free_buffer(vdev, vrp->rbufs, total_buf_space);
+	} else {
+		dma_free_coherent(vdev->dev.parent, total_buf_space,
+				  vrp->rbufs, vrp->bufs_dma);
+	}
 
 	kfree(vrp);
 }
-- 
2.17.1
