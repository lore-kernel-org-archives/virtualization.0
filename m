From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/9] virtio_blk: use virtio IRQ affinity
Date: Fri, 27 Jan 2017 09:16:36 +0100
Message-ID: <1485504997-17584-9-git-send-email-hch@lst.de>
References: <1485504997-17584-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1485504997-17584-1-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: axboe@kernel.dk, pbonzini@redhat.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use automatic IRQ affinity assignment in the virtio layer if available,
and build the blk-mq queues based on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c54118b..1028dfe 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -5,6 +5,7 @@
 #include <linux/hdreg.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/interrupt.h>
 #include <linux/virtio.h>
 #include <linux/virtio_blk.h>
 #include <linux/scatterlist.h>
@@ -12,6 +13,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-mq-virtio.h>
 #include <linux/numa.h>
 
 #define PART_BITS 4
@@ -385,6 +387,7 @@ static int init_vq(struct virtio_blk *vblk)
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	struct virtio_device *vdev = vblk->vdev;
+	struct irq_affinity desc = { 0, };
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
@@ -412,7 +415,7 @@ static int init_vq(struct virtio_blk *vblk)
 
 	/* Discover virtqueues and write information to configuration.  */
 	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names,
-			NULL);
+			&desc);
 	if (err)
 		goto out;
 
@@ -543,10 +546,18 @@ static int virtblk_init_request(void *data, struct request *rq,
 	return 0;
 }
 
+static int virtblk_map_queues(struct blk_mq_tag_set *set)
+{
+	struct virtio_blk *vblk = set->driver_data;
+
+	return blk_mq_virtio_map_queues(set, vblk->vdev, 0);
+}
+
 static struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
+	.map_queues	= virtblk_map_queues,
 };
 
 static unsigned int virtblk_queue_depth;
-- 
2.1.4
