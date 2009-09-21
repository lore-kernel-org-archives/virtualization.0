From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/6] virtio_blk: revert QUEUE_FLAG_VIRT addition
Date: Mon, 21 Sep 2009 16:28:34 +0930
Message-ID: <200909211628.34834.rusty@rustcorp.com.au>
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

It seems like the addition of QUEUE_FLAG_VIRT caueses major performance
regressions for Fedora users:

	https://bugzilla.redhat.com/show_bug.cgi?id=509383
	https://bugzilla.redhat.com/show_bug.cgi?id=505695

while I can't reproduce those extreme regressions myself I think the flag
is wrong.

Rationale:

  QUEUE_FLAG_VIRT expands to QUEUE_FLAG_NONROT which casus the queue
  unplugged immediately.  This is not a good behaviour for at least
  qemu and kvm where we do have significant overhead for every
  I/O operations.  Even with all the latested speeups (native AIO,
  MSI support, zero copy) we can only get native speed for up to 128kb
  I/O requests we already are down to 66% of native performance for 4kb
  requests even on my laptop running the Intel X25-M SSD for which the
  QUEUE_FLAG_NONROT was designed.
  If we ever get virtio-blk overhead low enough that this flag makes
  sense it should only be set based on a feature flag set by the host.
	
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Index: linux-2.6/drivers/block/virtio_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/virtio_blk.c	2009-09-04 17:33:48.802523987 -0300
+++ linux-2.6/drivers/block/virtio_blk.c	2009-09-04 17:33:56.186522158 -0300
@@ -314,7 +314,6 @@ static int __devinit virtblk_probe(struc
 	}
 
 	vblk->disk->queue->queuedata = vblk;
-	queue_flag_set_unlocked(QUEUE_FLAG_VIRT, vblk->disk->queue);
 
 	if (index < 26) {
 		sprintf(vblk->disk->disk_name, "vd%c", 'a' + index % 26);
