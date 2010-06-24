From: Ryan Harper <ryanh@us.ibm.com>
Subject: [PATCH 2/2] Remove virtio_blk VBID ioctl
Date: Wed, 23 Jun 2010 22:19:58 -0500
Message-ID: <1277349598-24559-3-git-send-email-ryanh__11067.048731684$1277349802$gmane$org@us.ibm.com>
References: <1277349598-24559-1-git-send-email-ryanh@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1277349598-24559-1-git-send-email-ryanh@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: john cooper <john.cooper@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

With the availablility of a sysfs device attribute for examining disk serial
numbers the ioctl is no longer needed.  The user-space changes for this aren't
upstream yet so we don't have any users to worry about.

Signed-off-by: Ryan Harper <ryanh@us.ibm.com>
---
 drivers/block/virtio_blk.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 34411ff..04458cd 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -225,16 +225,6 @@ static int virtblk_ioctl(struct block_device *bdev, fmode_t mode,
 	struct gendisk *disk = bdev->bd_disk;
 	struct virtio_blk *vblk = disk->private_data;
 
-	if (cmd == 0x56424944) { /* 'VBID' */
-		void __user *usr_data = (void __user *)data;
-		char id_str[VIRTIO_BLK_ID_BYTES];
-		int err;
-
-		err = virtblk_get_id(disk, id_str);
-		if (!err && copy_to_user(usr_data, id_str, VIRTIO_BLK_ID_BYTES))
-			err = -EFAULT;
-		return err;
-	}
 	/*
 	 * Only allow the generic SCSI ioctls if the host can support it.
 	 */
-- 
1.6.3.3
