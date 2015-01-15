From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_blk: coding style fixes
Date: Thu, 15 Jan 2015 13:43:26 +0200
Message-ID: <1421322201-21203-1-git-send-email-mst@redhat.com>
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

Most of our code has
struct foo {
}

Fix two instances where blk is inconsistent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7164da8..c5730d3 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -28,8 +28,7 @@ struct virtio_blk_vq {
 	char name[VQ_NAME_LEN];
 } ____cacheline_aligned_in_smp;
 
-struct virtio_blk
-{
+struct virtio_blk {
 	struct virtio_device *vdev;
 
 	/* The disk structure for the kernel. */
@@ -52,8 +51,7 @@ struct virtio_blk
 	struct virtio_blk_vq *vqs;
 };
 
-struct virtblk_req
-{
+struct virtblk_req {
 	struct request *req;
 	struct virtio_blk_outhdr out_hdr;
 	struct virtio_scsi_inhdr in_hdr;
-- 
MST
