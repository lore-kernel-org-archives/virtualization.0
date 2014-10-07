From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 06/11] virtio: allow virtio-1 queue layout
Date: Tue,  7 Oct 2014 16:40:02 +0200
Message-ID: <1412692807-12398-7-git-send-email-cornelia.huck@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

For virtio-1 devices, we allow a more complex queue layout that doesn't
require descriptor table and rings on a physically-contigous memory area:
add virtio_queue_set_rings() to allow transports to set this up.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/virtio/virtio.c         |   16 ++++++++++++++++
 include/hw/virtio/virtio.h |    2 ++
 2 files changed, 18 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e6ae3a0..147d227 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -96,6 +96,13 @@ static void virtqueue_init(VirtQueue *vq)
 {
     hwaddr pa = vq->pa;
 
+    if (pa == -1ULL) {
+        /*
+         * This is a virtio-1 style vq that has already been setup
+         * in virtio_queue_set.
+         */
+        return;
+    }
     vq->vring.desc = pa;
     vq->vring.avail = pa + vq->vring.num * sizeof(VRingDesc);
     vq->vring.used = vring_align(vq->vring.avail +
@@ -719,6 +726,15 @@ hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
     return vdev->vq[n].pa;
 }
 
+void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
+                            hwaddr avail, hwaddr used)
+{
+    vdev->vq[n].pa = -1ULL;
+    vdev->vq[n].vring.desc = desc;
+    vdev->vq[n].vring.avail = avail;
+    vdev->vq[n].vring.used = used;
+}
+
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
 {
     /* Don't allow guest to flip queue between existent and
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 40e567c..f840320 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -227,6 +227,8 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num);
 int virtio_queue_get_num(VirtIODevice *vdev, int n);
+void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
+                            hwaddr avail, hwaddr used);
 void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
-- 
1.7.9.5
