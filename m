From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_blk: allow read-only disks
Date: Fri, 16 May 2008 11:17:03 +0200
Message-ID: <200805161117.03439.borntraeger__2180.3748714321$1210929642$gmane$org@de.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, kvm-devel@lists.sourceforge.net
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

sometimes it is useful to share a disk (e.g. usr). To avoid file system 
corruption, the disk should be mounted read-only in that case. This patch 
adds a new feature flag, that allows the host to specify, if the disk should 
be considered read-only.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/block/virtio_blk.c |    6 +++++-
 include/linux/virtio_blk.h |    1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

Index: kvm/drivers/block/virtio_blk.c
===================================================================
--- kvm.orig/drivers/block/virtio_blk.c
+++ kvm/drivers/block/virtio_blk.c
@@ -260,6 +260,10 @@ static int virtblk_probe(struct virtio_d
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_BARRIER))
 		blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
 
+	/* If disk is read-only in the host, the guest should obey */
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
+		set_disk_ro(vblk->disk, 1);
+
 	/* Host must always specify the capacity. */
 	vdev->config->get(vdev, offsetof(struct virtio_blk_config, capacity),
 			  &cap, sizeof(cap));
@@ -325,7 +329,7 @@ static struct virtio_device_id id_table[
 
 static unsigned int features[] = {
 	VIRTIO_BLK_F_BARRIER, VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX,
-	VIRTIO_BLK_F_GEOMETRY,
+	VIRTIO_BLK_F_GEOMETRY, VIRTIO_BLK_F_RO,
 };
 
 static struct virtio_driver virtio_blk = {
Index: kvm/include/linux/virtio_blk.h
===================================================================
--- kvm.orig/include/linux/virtio_blk.h
+++ kvm/include/linux/virtio_blk.h
@@ -10,6 +10,7 @@
 #define VIRTIO_BLK_F_SIZE_MAX	1	/* Indicates maximum segment size */
 #define VIRTIO_BLK_F_SEG_MAX	2	/* Indicates maximum # of segments */
 #define VIRTIO_BLK_F_GEOMETRY	4	/* Legacy geometry available  */
+#define VIRTIO_BLK_F_RO		5	/* Disk is read-only */
 
 struct virtio_blk_config
 {
