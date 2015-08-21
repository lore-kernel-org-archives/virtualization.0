From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] virtio-blk: use VIRTIO_BLK_F_WCE and VIRTIO_BLK_F_CONFIG_WCE
	in virtio1
Date: Fri, 21 Aug 2015 15:53:55 -0700
Message-ID: <1440197635-5170-1-git-send-email-pbonzini@redhat.com>
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
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

VIRTIO_BLK_F_CONFIG_WCE is important in order to achieve good performance
(up to 2x, though more realistically +30-40%) in latency-bound workloads.
However, it was removed by mistake together with VIRTIO_BLK_F_FLUSH.

It will be restored in the next revision of the virtio 1.0 standard, so
do the same in Linux.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/block/virtio_blk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d4d05f064d39..ea2c17c66dfb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -478,8 +478,7 @@ static int virtblk_get_cache_mode(struct virtio_device *vdev)
 				   struct virtio_blk_config, wce,
 				   &writeback);
 	if (err)
-		writeback = virtio_has_feature(vdev, VIRTIO_BLK_F_WCE) ||
-		            virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
+		writeback = virtio_has_feature(vdev, VIRTIO_BLK_F_WCE);
 
 	return writeback;
 }
@@ -840,7 +839,7 @@ static unsigned int features_legacy[] = {
 static unsigned int features[] = {
 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
-	VIRTIO_BLK_F_TOPOLOGY,
+	VIRTIO_BLK_F_WCE, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ,
 };
 
-- 
2.4.3
