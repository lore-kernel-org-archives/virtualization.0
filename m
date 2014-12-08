From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/9] virtio_pci: use priv for vq notification
Date: Mon, 8 Dec 2014 15:06:23 +0200
Message-ID: <1418043812-25753-5-git-send-email-mst__29481.2022745193$1418044058$gmane$org@redhat.com>
References: <1418043812-25753-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418043812-25753-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

slightly reduce the amount of pointer chasing this needs to do.
More importantly, this will easily generalize to virtio 1.0.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 6a7b8bf..7b82eb5 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -204,11 +204,9 @@ static void vp_reset(struct virtio_device *vdev)
 /* the notify function used when creating a virt queue */
 static bool vp_notify(struct virtqueue *vq)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-
 	/* we write the queue's selector into the notification register to
 	 * signal the other end */
-	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
+	iowrite16(vq->index, (void __iomem *)vq->priv);
 	return true;
 }
 
@@ -437,6 +435,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 		goto out_activate_queue;
 	}
 
+	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
 	info->vq = vq;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-- 
MST
