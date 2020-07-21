From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 02/10] block: virtio-blk: check logical block size
Date: Tue, 21 Jul 2020 13:52:31 +0300
Message-ID: <20200721105239.8270-3-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
Sender: linux-block-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

Linux kernel only supports logical block sizes which are power of two,
at least 512 bytes and no more that PAGE_SIZE.

Check this instead of crashing later on.

Note that there is no need to check physical block size since it is
only a hint, and virtio-blk already only supports power of two values.

Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/block/virtio_blk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 980df853ee497..b5ee87cba00ed 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -809,10 +809,18 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err) {
+		if (!blk_is_valid_logical_block_size(blk_size)) {
+			dev_err(&vdev->dev,
+				"%s failure: invalid logical block size %d\n",
+				__func__, blk_size);
+			err = -EINVAL;
+			goto out_cleanup_queue;
+		}
 		blk_queue_logical_block_size(q, blk_size);
-	else
+	} else {
 		blk_size = queue_logical_block_size(q);
+	}
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
@@ -872,6 +880,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	return 0;
 
+out_cleanup_queue:
+	blk_cleanup_queue(vblk->disk->queue);
+	vblk->disk->queue = NULL;
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_put_disk:
-- 
2.26.2
