From: Venkatesh Srinivas <venkateshs@google.com>
Subject: [PATCH] virtio-blk: Initialize blkqueue depth from virtqueue size
Date: Fri, 14 Mar 2014 16:57:25 -0700
Message-ID: <1394841445-16142-1-git-send-email-venkateshs@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3ABDD2B
	for <virtualization@lists.linuxfoundation.org>;
	Fri, 14 Mar 2014 23:57:30 +0000 (UTC)
Received: from mail-pb0-f74.google.com (mail-pb0-f74.google.com
	[209.85.160.74])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EA5762014B
	for <virtualization@lists.linuxfoundation.org>;
	Fri, 14 Mar 2014 23:57:29 +0000 (UTC)
Received: by mail-pb0-f74.google.com with SMTP id md12so413763pbc.3
	for <virtualization@lists.linuxfoundation.org>;
	Fri, 14 Mar 2014 16:57:29 -0700 (PDT)
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tytso@mit.edu, rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linuxfoundation.org, fes@google.com
List-Id: virtualization@lists.linuxfoundation.org

virtio-blk set the default queue depth to 64 requests, which was
insufficient for high-IOPS devices. Instead set the blk-queue depth to
the device's virtqueue depth divided by two (each I/O requires at least
two VQ entries).

Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1cb3f4..863ab02 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -485,7 +485,6 @@ static struct blk_mq_ops virtio_mq_ops = {
 static struct blk_mq_reg virtio_mq_reg = {
 	.ops		= &virtio_mq_ops,
 	.nr_hw_queues	= 1,
-	.queue_depth	= 64,
 	.numa_node	= NUMA_NO_NODE,
 	.flags		= BLK_MQ_F_SHOULD_MERGE,
 };
@@ -555,6 +554,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtio_mq_reg.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * sg_elems;
+	virtio_mq_reg.queue_depth = vblk->vq->num_free / 2;
 
 	q = vblk->disk->queue = blk_mq_init_queue(&virtio_mq_reg, vblk);
 	if (!q) {
-- 
1.9.0.279.gdc9e3eb
