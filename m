From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/2] virtio: block: set max_segment_size and max_sectors to
	infinite.
Date: Mon, 17 Nov 2008 17:24:15 +1030
Message-ID: <200811171724.15682.rusty@rustcorp.com.au>
References: <200811141215.33950.rusty@rustcorp.com.au>
	<20081114093023.GQ26778@kernel.dk>
	<200811171722.43792.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200811171722.43792.rusty@rustcorp.com.au>
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
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Setting max_segment_size allows more than 64k per sg element, unless
the host specified a limit.  Setting max_sectors indicates that our
max_hw_segments is the only limit.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 446171198334 drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c	Mon Nov 17 08:34:57 2008 +1030
+++ b/drivers/block/virtio_blk.c	Mon Nov 17 17:16:35 2008 +1030
@@ -277,6 +277,9 @@
 	}
 	set_capacity(vblk->disk, cap);
 
+	/* No real sector limit. */
+	blk_queue_max_sectors(vblk->disk->queue, -1U);
+
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
 	err = virtio_config_val(vdev, VIRTIO_BLK_F_SIZE_MAX,
@@ -284,6 +287,8 @@
 				&v);
 	if (!err)
 		blk_queue_max_segment_size(vblk->disk->queue, v);
+	else
+		blk_queue_max_segment_size(vblk->disk->queue, -1UL);
 
 	err = virtio_config_val(vdev, VIRTIO_BLK_F_SEG_MAX,
 				offsetof(struct virtio_blk_config, seg_max),
