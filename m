From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 17/25] virtio_blk: enable VQs early on restore
Date: Mon, 13 Oct 2014 10:51:09 +0300
Message-ID: <1413114332-626-18-git-send-email-mst-v4__36432.5055772953$1413186560$gmane$org@redhat.com>
References: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit.shah@redhat.com>, v9fs-developer@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

virtio spec requires drivers to set DRIVER_OK before using VQs.
This is set automatically after restore returns, virtio block violated
this rule on restore by restarting queues, which might in theory
cause the VQ to be used directly within restore.

To fix, call virtio_device_ready before using starting queues.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 46b04bf..1c95af5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -804,10 +804,13 @@ static int virtblk_restore(struct virtio_device *vdev)
 	int ret;
 
 	ret = init_vq(vdev->priv);
-	if (!ret)
-		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
+	if (ret)
+		return ret;
+
+	virtio_device_ready(vdev);
 
-	return ret;
+	blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
+	return 0;
 }
 #endif
 
-- 
MST
