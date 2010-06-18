From: Ryan Harper <ryanh@us.ibm.com>
Subject: [PATCH 1/2] Add 'serial' attribute to virtio-blk devices
Date: Fri, 18 Jun 2010 13:38:02 -0500
Message-ID: <1276886283-1571-1-git-send-email-ryanh__21394.0518013716$1276886339$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
and aren't required to be NULL-terminated.  The buffer is also zero-padded
meaning that if the serial is 19 chars or less that we get a NULL terminated
string.  When copying this value into a string buffer, we must be careful to
copy up to the NULL (if it present) and only 20 if it is longer and not to
attempt to NULL terminate; this isn't needed.

Signed-off-by: Ryan Harper <ryanh@us.ibm.com>
Signed-off-by: john cooper <john.cooper@redhat.com>
---
 drivers/block/virtio_blk.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 258bc2a..f1ef26f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -281,6 +281,31 @@ static int index_to_minor(int index)
 	return index << PART_BITS;
 }
 
+/* Copy serial number from *s to *d.  Copy operation terminates on either
+ * encountering a nul in *s or after n bytes have been copied, whichever
+ * occurs first.  *d is not forcibly nul terminated.  Return # of bytes copied.
+ */
+static inline int serial_sysfs(char *d, char *s, int n)
+{
+	char *di = d;
+
+	while (*s && n--)
+		*d++ = *s++;
+	return d - di;
+}
+
+static ssize_t virtblk_serial_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	char id_str[VIRTIO_BLK_ID_BYTES];
+
+	if (IS_ERR(virtblk_get_id(disk, id_str)))
+		return 0;
+	return serial_sysfs(buf, id_str, min(VIRTIO_BLK_ID_BYTES, PAGE_SIZE));
+}
+DEVICE_ATTR(serial, S_IRUGO, virtblk_serial_show, NULL);
+
 static int __devinit virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -445,8 +470,15 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
 
 
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
