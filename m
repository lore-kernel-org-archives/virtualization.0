From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [Patch] virtio_blk: implement naming for vda-vdz, vdaa-vdzz,
	vdaaa-vdzzz
Date: Fri, 1 Feb 2008 09:05:00 +0100
Message-ID: <200802010905.00336.borntraeger__29677.0465247848$1201853290$gmane$org@de.ibm.com>
References: <200801311553.53653.borntraeger__25311.9055800655$1201791369$gmane$org@de.ibm.com>
	<47A242B1.40709@codemonkey.ws>
	<200802010833.51809.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200802010833.51809.borntraeger@de.ibm.com>
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
To: Anthony Liguori <anthony@codemonkey.ws>, Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag, 1. Februar 2008 schrieb Christian Borntraeger:
> Right. I will fix that with an additional patch.

This patch goes on top of the minor number patch. Please let me know if
you want a merged patch:

Currently virtio_blk creates the disk name combinging "vd"  with 'a'++.
This will give strange names after vdz. I have implemented names up to 
vdzzz - inspired by the sd.c code. That should be sufficient for now.

There is one driver in the kernel (driver/s390/block/dasd_genhd.c) that
implements names from dasda-dasdzzzz allowing even more disks. Maybe 
a janitor can come up with a common implementation usable for all kind
of block device drivers.

I have tested this patch with 100 disks - seems to work.


Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 drivers/block/virtio_blk.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

Index: kvm/drivers/block/virtio_blk.c
===================================================================
--- kvm.orig/drivers/block/virtio_blk.c
+++ kvm/drivers/block/virtio_blk.c
@@ -11,8 +11,7 @@
 
 MODULE_LICENSE("GPL");
 
-static unsigned char virtblk_index = 'a';
-static int major, minor;
+static int major, index;
 
 struct virtio_blk
 {
@@ -173,6 +172,11 @@ static struct block_device_operations vi
 	.getgeo = virtblk_getgeo,
 };
 
+static int index_to_minor(int index)
+{
+	return index << PART_BITS;
+}
+
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -180,7 +184,7 @@ static int virtblk_probe(struct virtio_d
 	u64 cap;
 	u32 v;
 
-	if (minor >= 1 << MINORBITS)
+	if (index_to_minor(index) >= 1 << MINORBITS)
 		return -ENOSPC;
 
 	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
@@ -219,13 +223,24 @@ static int virtblk_probe(struct virtio_d
 		goto out_put_disk;
 	}
 
-	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
+	if (index < 26) {
+		sprintf(vblk->disk->disk_name, "vd%c", 'a' + index % 26);
+	} else if (index < (26 + 1) * 26) {
+		sprintf(vblk->disk->disk_name, "vd%c%c",
+			'a' + index / 26 - 1, 'a' + index % 26);
+	} else {
+		const unsigned int m1 = (index / 26 - 1) / 26 - 1;
+		const unsigned int m2 = (index / 26 - 1) % 26;
+		const unsigned int m3 =  index % 26;
+		sprintf(vblk->disk->disk_name, "vd%c%c%c",
+			'a' + m1, 'a' + m2, 'a' + m3);
+	}
+
 	vblk->disk->major = major;
-	vblk->disk->first_minor = minor;
+	vblk->disk->first_minor = index_to_minor(index);
 	vblk->disk->private_data = vblk;
 	vblk->disk->fops = &virtblk_fops;
-
-	minor += 1 << PART_BITS;
+	index++;
 
 	/* If barriers are supported, tell block layer that queue is ordered */
 	if (vdev->config->feature(vdev, VIRTIO_BLK_F_BARRIER))
