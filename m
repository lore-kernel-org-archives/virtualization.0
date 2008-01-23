From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_blk: provide getgeo
Date: Wed, 23 Jan 2008 17:56:50 +0100
Message-ID: <200801231756.50224.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

I currently try to make my guest boot from an virtio root device
without having an external kernel. Some of the tools that I tried 
expect HDIO_GETGEO to work. The most interesting value is likely
the geo.start value to get the offset of a partition. This value
is filled by block/ioctl.c if fops->getgeo is set. This patch also
fills in some standard values for heads, sectors and cylinders.

Makes sense?

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/block/virtio_blk.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: kvm/drivers/block/virtio_blk.c
===================================================================
--- kvm.orig/drivers/block/virtio_blk.c
+++ kvm/drivers/block/virtio_blk.c
@@ -154,9 +154,20 @@ static int virtblk_ioctl(struct inode *i
 			      (void __user *)data);
 }
 
+/* We provide getgeo only to please some old bootloader/partitioning tools */
+static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
+{
+	/* some standard values, similar to sd */
+	geo->heads = 1 << 6;
+	geo->sectors = 1 << 5;
+	geo->cylinders = get_capacity(bd->bd_disk) >> 11;
+	return 0;
+}
+
 static struct block_device_operations virtblk_fops = {
-	.ioctl = virtblk_ioctl,
-	.owner = THIS_MODULE,
+	.ioctl  = virtblk_ioctl,
+	.owner  = THIS_MODULE,
+	.getgeo = virtblk_getgeo,
 };
 
 static int virtblk_probe(struct virtio_device *vdev)
