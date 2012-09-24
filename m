From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH 2/2] virtio_mmio: Don't attempt to create empty virtqueues
Date: Mon, 24 Sep 2012 14:33:42 +0100
Message-ID: <1348493622-26091-3-git-send-email-pawel.moll@arm.com>
References: <1348493622-26091-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1348493622-26091-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Brian Foley <brian.foley@arm.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Brian Foley <brian.foley@arm.com>

If a virtio device reports a QueueNumMax of 0, vring_new_virtqueue()
doesn't check this, and thanks to an unsigned (i < num - 1) loop
guard, scribbles over memory when initialising the free list.

Avoid by not trying to create zero-descriptor queues, as there's no
way to do any I/O with one.

Signed-off-by: Brian Foley <brian.foley@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/virtio/virtio_mmio.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 58e2d78..6979c1b 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -332,6 +332,16 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	 * and two rings (which makes it "alignment_size * 2")
 	 */
 	info->num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
+
+	/* If the device reports a 0 entry queue, we won't be able to
+	 * use it to perform I/O, and vring_new_virtqueue() can't create
+	 * empty queues anyway, so don't bother to set up the device.
+	 */
+	if (info->num == 0) {
+		err = -ENOENT;
+		goto error_alloc_pages;
+	}
+
 	while (1) {
 		size = PAGE_ALIGN(vring_size(info->num,
 				VIRTIO_MMIO_VRING_ALIGN));
-- 
1.7.9.5
