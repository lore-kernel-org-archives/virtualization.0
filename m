From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] virtio_blk: typo fix
Date: Sun, 1 Mar 2015 08:39:14 +0100
Message-ID: <1425192883-5930-2-git-send-email-mst@redhat.com>
References: <1425192883-5930-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1425192883-5930-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Now that QEmu reuses linux virtio headers, we noticed
a typo in the exported virtio block header. Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3c53eec..b695ba9 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -60,7 +60,7 @@ struct virtio_blk_config {
 	__u32 size_max;
 	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
 	__u32 seg_max;
-	/* geometry the device (if VIRTIO_BLK_F_GEOMETRY) */
+	/* geometry of the device (if VIRTIO_BLK_F_GEOMETRY) */
 	struct virtio_blk_geometry {
 		__u16 cylinders;
 		__u8 heads;
-- 
MST
