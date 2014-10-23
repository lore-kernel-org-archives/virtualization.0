From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] virtio_blk: WCE is assumed on under VIRTIO 1.0
Date: Fri, 24 Oct 2014 00:46:32 +0300
Message-ID: <1414100763-546-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index adfba9f..1f8b111 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -478,7 +478,8 @@ static int virtblk_get_cache_mode(struct virtio_device *vdev)
 				   struct virtio_blk_config, wce,
 				   &writeback);
 	if (err)
-		writeback = virtio_has_feature(vdev, VIRTIO_BLK_F_WCE);
+		writeback = virtio_has_feature(vdev, VIRTIO_BLK_F_WCE) ||
+		            virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
 
 	return writeback;
 }
-- 
MST
