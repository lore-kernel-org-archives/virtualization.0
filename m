From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v3 RFC 3/4] virtio_blk: avoid calling blk_cleanup_queue() on
	device loss
Date: Wed, 27 Nov 2013 11:32:39 +0100
Message-ID: <1385548360-31943-4-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Code is added to avoid calling blk_cleanup_queue() when the surprize_removal
flag is set due to a disappeared device. It avoid hangs due to incomplete
requests (e.g. in-flight requests). Such requests must be considered as lost.

If the current remove callback was triggered due to an unregister driver,
and the surprize_removal is not already set (although the actual device
is already gone, e.g. virsh detach), blk_cleanup_queue() would be triggered
resulting in a possible hang. This hang is caused by e.g. 'in-flight' requests
that will never complete. This is a weird situation, and most likely not
'serializable'.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0f64282..8c05001 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -892,7 +892,8 @@ static void virtblk_remove(struct virtio_device *vdev)
 	}
 
 	del_gendisk(vblk->disk);
-	blk_cleanup_queue(vblk->disk->queue);
+	if (!vdev->surprize_removal)
+		blk_cleanup_queue(vblk->disk->queue);
 
 	/* Stop all the virtqueues. */
 	vdev->config->reset(vdev);
-- 
1.8.3.1
