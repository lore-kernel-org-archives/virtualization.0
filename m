From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] virtio_blk: merge S/G list entries by default
Date: Sat,  6 Sep 2014 16:09:54 -0700
Message-ID: <1410044994-14943-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Most virtio setups have a fairly limited number of ring entries available.
Enable S/G entry merging by default to fit into less of them.  This restores
the behavior at time of the virtio-blk blk-mq conversion, which was changed
by commit "block: add queue flag for disabling SG merging" which made the
behavior optional, but didn't update the existing drivers to keep their
previous behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0a58140..311b857 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -634,7 +634,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->tag_set.ops = &virtio_mq_ops;
 	vblk->tag_set.queue_depth = virtblk_queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * sg_elems;
-- 
1.9.1
