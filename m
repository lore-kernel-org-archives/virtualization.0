From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v2 08/16] virtio: allow transports to get avail/used
	addresses
Date: Wed, 22 Oct 2014 18:50:44 +0300
Message-ID: <1413992894-22976-9-git-send-email-mst__43011.3960559995$1413992893$gmane$org@redhat.com>
References: <1413992894-22976-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1413992894-22976-1-git-send-email-mst@redhat.com>
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
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

For virtio-1, we can theoretically have a more complex virtqueue
layout with avail and used buffers not on a contiguous memory area
with the descriptor table. For now, it's fine for a transport driver
to stay with the old layout: It needs, however, a way to access
the locations of the avail/used rings so it can register them with
the host.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h       |  3 +++
 drivers/virtio/virtio_ring.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 149284e..d6359a5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -75,6 +75,9 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
 
 bool virtqueue_is_broken(struct virtqueue *vq);
 
+void *virtqueue_get_avail(struct virtqueue *vq);
+void *virtqueue_get_used(struct virtqueue *vq);
+
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9f5dfe3..1db44ba 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -829,4 +829,20 @@ void virtio_break_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
 
+void *virtqueue_get_avail(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->vring.avail;
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_avail);
+
+void *virtqueue_get_used(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->vring.used;
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_used);
+
 MODULE_LICENSE("GPL");
-- 
MST
