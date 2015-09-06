From: Fam Zheng <famz@redhat.com>
Subject: [PATCH v2] virtio-blk: Allow extended partitions
Date: Sun,  6 Sep 2015 17:05:42 +0800
Message-ID: <1441530342-26978-1-git-send-email-famz__22830.6100624197$1441530363$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This will allow up to DISK_MAX_PARTS (256) partitions, with for example
GPT in the guest. Otherwise, the partition scan code will only discover
the first 15 partitions.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d4d05f0..38ea01b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -657,6 +657,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->disk->private_data = vblk;
 	vblk->disk->fops = &virtblk_fops;
 	vblk->disk->driverfs_dev = &vdev->dev;
+	vblk->disk->flags |= GENHD_FL_EXT_DEVT;
 	vblk->index = index;
 
 	/* configure queue flush support */
-- 
2.4.3
