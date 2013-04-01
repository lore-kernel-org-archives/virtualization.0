From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH-v2 3/3] vhost: Skip uninitialized VQs in
	vhost_virtqueue_[start, stop]
Date: Mon,  1 Apr 2013 23:58:24 +0000
Message-ID: <1364860704-11896-4-git-send-email-nab__9399.90156698531$1364861429$gmane$org@linux-iscsi.org>
References: <1364860704-11896-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364860704-11896-1-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch adds virtio_queue_valid() checks in vhost_virtqueue_start()
and vhost_virtqueue_stop() to avoid uninitialized VQs during vhost-scsi-pci
seabios operation, where we currently expect only the request VQ to have
been initialized before virtio-scsi LLD guest hand-off.

Also, go ahead and skip the same uninitialized VQs during sanity checks
within vhost_verify_ring_mappings() by checking vq->ring_[phys,size]
directly.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Asias He <asias@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/vhost.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/hw/vhost.c b/hw/vhost.c
index 4d6aee3..832cc89 100644
--- a/hw/vhost.c
+++ b/hw/vhost.c
@@ -314,6 +314,9 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
         hwaddr l;
         void *p;
 
+        if (!vq->ring_phys || !vq->ring_size) {
+            continue;
+        }
         if (!ranges_overlap(start_addr, size, vq->ring_phys, vq->ring_size)) {
             continue;
         }
@@ -645,6 +648,10 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
 
+    if (!virtio_queue_valid(vdev, idx)) {
+        return 0;
+    }
+
     vq->num = state.num = virtio_queue_get_num(vdev, idx);
     r = ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
     if (r) {
@@ -732,6 +739,11 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
     };
     int r;
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
+
+    if (!virtio_queue_valid(vdev, idx)) {
+        return;
+    }
+
     r = ioctl(dev->control, VHOST_GET_VRING_BASE, &state);
     if (r < 0) {
         fprintf(stderr, "vhost VQ %d ring restore failed: %d\n", idx, r);
-- 
1.7.2.5
