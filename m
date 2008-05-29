From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_blk: fix endianess annotations
Date: Thu, 29 May 2008 11:10:01 +0200
Message-ID: <200805291110.01588.borntraeger__24256.6688605168$1212052495$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Since commit 72e61eb40b55dd57031ec5971e810649f82b0259 (virtio: change config
to guest endian) config space is no longer fixed endian.

Lets change the virtio_blk_config variables.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 include/linux/virtio_blk.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: kvm/include/linux/virtio_blk.h
===================================================================
--- kvm.orig/include/linux/virtio_blk.h
+++ kvm/include/linux/virtio_blk.h
@@ -16,14 +16,14 @@
 struct virtio_blk_config
 {
 	/* The capacity (in 512-byte sectors). */
-	__le64 capacity;
+	__u64 capacity;
 	/* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
-	__le32 size_max;
+	__u32 size_max;
 	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
-	__le32 seg_max;
+	__u32 seg_max;
 	/* geometry the device (if VIRTIO_BLK_F_GEOMETRY) */
 	struct virtio_blk_geometry {
-		__le16 cylinders;
+		__u16 cylinders;
 		__u8 heads;
 		__u8 sectors;
 	} geometry;
