From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH (repost) RFC 1/2] virtio: ISR bit constants
Date: Wed, 2 Nov 2011 22:11:17 +0200
Message-ID: <e026e861596585036b766d61da28fbf01b60ce24.1320259840.git.mst@redhat.com>
References: <cover.1320259840.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1320259840.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Stefan Weil <weil@mail.berlios.de>, Avi Kivity <avi@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

Add constants for ISR bits values, and use them in virtio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio.c |    7 ++++---
 hw/virtio.h |    5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/virtio.c b/hw/virtio.c
index 7011b5b..74627e4 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -672,7 +672,7 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
 void virtio_irq(VirtQueue *vq)
 {
     trace_virtio_irq(vq);
-    vq->vdev->isr |= 0x01;
+    vq->vdev->isr |= VIRTIO_ISR_VQ;
     virtio_notify_vector(vq->vdev, vq->vector);
 }
 
@@ -717,7 +717,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
     }
 
     trace_virtio_notify(vdev, vq);
-    vdev->isr |= 0x01;
+    vdev->isr |= VIRTIO_ISR_VQ;
     virtio_notify_vector(vdev, vq->vector);
 }
 
@@ -726,7 +726,8 @@ void virtio_notify_config(VirtIODevice *vdev)
     if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
         return;
 
-    vdev->isr |= 0x03;
+    /* TODO: why do we set VIRTIO_ISR_VQ here? */
+    vdev->isr |= VIRTIO_ISR_VQ | VIRTIO_ISR_CONFIG;
     virtio_notify_vector(vdev, vdev->config_vector);
 }
 
diff --git a/hw/virtio.h b/hw/virtio.h
index 2d18209..1bb6210 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -54,6 +54,11 @@
 /* A guest should never accept this.  It implies negotiation is broken. */
 #define VIRTIO_F_BAD_FEATURE		30
 
+/* The bit of the ISR which indicates a device vq event. */
+#define VIRTIO_ISR_VQ			0x1
+/* The bit of the ISR which indicates a device configuration change. */
+#define VIRTIO_ISR_CONFIG		0x2
+
 /* from Linux's linux/virtio_ring.h */
 
 /* This marks a buffer as continuing via the next field. */
-- 
1.7.5.53.gc233e
