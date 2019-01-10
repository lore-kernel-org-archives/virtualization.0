From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/3] virtio-blk: Consider virtio_max_dma_size() for maximum
	segment size
Date: Thu, 10 Jan 2019 14:44:33 +0100
Message-ID: <20190110134433.15672-4-joro__1691.95004641569$1547127782$gmane$org@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110134433.15672-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Joerg Roedel <jroedel@suse.de>, brijesh.singh@amd.com, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Segments can't be larger than the maximum DMA allocation
size supported by virtio on the platform. Take that into
account when setting the maximum segment size for a block
device.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/block/virtio_blk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b16a887bbd02..6062faa8d213 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -723,7 +723,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	struct request_queue *q;
 	int err, index;
 
-	u32 v, blk_size, sg_elems, opt_io_size;
+	u32 v, blk_size, seg_size, sg_elems, opt_io_size;
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 
@@ -826,14 +826,16 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
 
+	seg_size = virtio_max_dma_size(vdev);
+
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
 				   struct virtio_blk_config, size_max, &v);
 	if (!err)
-		blk_queue_max_segment_size(q, v);
-	else
-		blk_queue_max_segment_size(q, -1U);
+		seg_size = min(v, seg_size);
+
+	blk_queue_max_segment_size(q, seg_size);
 
 	/* Host can optionally specify the block size of the device */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
-- 
2.17.1
