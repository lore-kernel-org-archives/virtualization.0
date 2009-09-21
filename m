From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/6] virtio_blk: set QUEUE_ORDERED_DRAIN by default
Date: Mon, 21 Sep 2009 16:28:31 +0930
Message-ID: <200909211628.31791.rusty@rustcorp.com.au>
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
To: virtualization@lists.osdl.org
Cc: Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Christoph Hellwig <hch@lst.de>

Currently virtio-blk doesn't set any QUEUE_ORDERED_ flag by default, which
means it does not allow filesystems to use barriers.  But the typical use
case for virtio-blk is to use a backed that uses synchronous I/O, and in
that case we can simply set QUEUE_ORDERED_DRAIN to make the block layer
drain the request queue around barrier I/O and provide the semantics that
the filesystems need.  This is what the SCSI disk driver does for disks
that have the write cache disabled.

With this patch we incorrectly advertise barrier support if someone
configure qemu with write back caching.  While this displays wrong
information in the guest there is nothing that guest could have done
even if we rightfully told it that we do not support any barriers.

(Christoph further explains:
 "Really, enabling volatile write caches without advertising a cache flush
 command is a bug in the storage, where in our case qemu is the storage."
 Actual write cache feature is coming in successive patch. --RR )

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/virtio_blk.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/block/virtio_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/virtio_blk.c	2009-08-20 17:41:37.019718433 -0300
+++ linux-2.6/drivers/block/virtio_blk.c	2009-08-20 17:45:40.511747922 -0300
@@ -336,9 +336,16 @@ static int __devinit virtblk_probe(struc
 	vblk->disk->driverfs_dev = &vdev->dev;
 	index++;
 
-	/* If barriers are supported, tell block layer that queue is ordered */
+	/*
+	 * If barriers are supported, tell block layer that queue is ordered.
+	 *
+	 * If no barriers are supported assume the host uses synchronous
+	 * writes and just drain the the queue before and after the barrier.
+	 */
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_BARRIER))
 		blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
+	else
+		blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_DRAIN, NULL);
 
 	/* If disk is read-only in the host, the guest should obey */
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
