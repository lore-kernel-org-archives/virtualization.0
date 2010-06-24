From: Ryan Harper <ryanh@us.ibm.com>
Subject: [PATCH 1/2] v2 Add 'serial' attribute to virtio-blk devices
Date: Wed, 23 Jun 2010 22:19:57 -0500
Message-ID: <1277349598-24559-2-git-send-email-ryanh__16096.689788583$1277349870$gmane$org@us.ibm.com>
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

Create a new attribute for virtio-blk devices that will fetch the serial number
of the block device.  This attribute can be used by udev to create disk/by-id
symlinks for devices that don't have a UUID (filesystem) associated with them.

ATA_IDENTIFY strings are special in that they can be up to 20 chars long
and aren't required to be nul-terminated.  The buffer is also zero-padded
meaning that if the serial is 19 chars or less that we get a nul-terminated
string.  When copying this value into a string buffer, we must be careful to
copy up to the nul (if it present) and only 20 if it is longer and not to
attempt to nul terminate; this isn't needed.

Changes since v1:
- Added BUILD_BUG_ON() for PAGE_SIZE check
- Removed min() since BUILD_BUG_ON() handles the check
- Replaced serial_sysfs() by copying id directly to buffer

Signed-off-by: Ryan Harper <ryanh@us.ibm.com>
Signed-off-by: john cooper <john.cooper@redhat.com>
---
 drivers/block/virtio_blk.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 258bc2a..34411ff 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -281,6 +281,27 @@ static int index_to_minor(int index)
 	return index << PART_BITS;
 }
 
+static ssize_t virtblk_serial_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	int err;
+
+	/* sysfs gives us a PAGE_SIZE buffer */
+	BUILD_BUG_ON(PAGE_SIZE < VIRTIO_BLK_ID_BYTES);
+
+	buf[VIRTIO_BLK_ID_BYTES] = '\0';
+	err = virtblk_get_id(disk, buf);
+	if (!err)
+		return strlen(buf);
+
+	if (err == -EIO) /* Unsupported? Make it empty. */
+		return 0;
+
+	return err;
+}
+DEVICE_ATTR(serial, S_IRUGO, virtblk_serial_show, NULL);
+
 static int __devinit virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -445,8 +466,15 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
 
 
 	add_disk(vblk->disk);
+	err = device_create_file(disk_to_dev(vblk->disk), &dev_attr_serial);
+	if (err)
+		goto out_del_disk;
+
 	return 0;
 
+out_del_disk:
+	del_gendisk(vblk->disk);
+	blk_cleanup_queue(vblk->disk->queue);
 out_put_disk:
 	put_disk(vblk->disk);
 out_mempool:
-- 
1.6.3.3
