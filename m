From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ 03/82] virtio-blk: Use block layer provided spinlock
Date: Mon, 13 Aug 2012 13:18:39 -0700
Message-ID: <20120813201746.757026394@linuxfoundation.org>
References: <20120813201746.448504360@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120813201746.448504360@linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

From: Greg KH <gregkh@linuxfoundation.org>

3.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Asias He <asias@redhat.com>

commit 2c95a3290919541b846bee3e0fbaa75860929f53 upstream.

Block layer will allocate a spinlock for the queue if the driver does
not provide one in blk_init_queue().

The reason to use the internal spinlock is that blk_cleanup_queue() will
switch to use the internal spinlock in the cleanup code path.

        if (q->queue_lock != &q->__queue_lock)
                q->queue_lock = &q->__queue_lock;

However, processes which are in D state might have taken the driver
provided spinlock, when the processes wake up, they would release the
block provided spinlock.

=====================================
[ BUG: bad unlock balance detected! ]
3.4.0-rc7+ #238 Not tainted
-------------------------------------
fio/3587 is trying to release lock (&(&q->__queue_lock)->rlock) at:
[<ffffffff813274d2>] blk_queue_bio+0x2a2/0x380
but there are no more locks to release!

other info that might help us debug this:
1 lock held by fio/3587:
 #0:  (&(&vblk->lock)->rlock){......}, at:
[<ffffffff8132661a>] get_request_wait+0x19a/0x250

Other drivers use block layer provided spinlock as well, e.g. SCSI.

Switching to the block layer provided spinlock saves a bit of memory and
does not increase lock contention. Performance test shows no real
difference is observed before and after this patch.

Changes in v2: Improve commit log as Michael suggested.

Signed-off-by: Asias He <asias@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/virtio_blk.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -21,8 +21,6 @@ struct workqueue_struct *virtblk_wq;
 
 struct virtio_blk
 {
-	spinlock_t lock;
-
 	struct virtio_device *vdev;
 	struct virtqueue *vq;
 
@@ -65,7 +63,7 @@ static void blk_done(struct virtqueue *v
 	unsigned int len;
 	unsigned long flags;
 
-	spin_lock_irqsave(&vblk->lock, flags);
+	spin_lock_irqsave(vblk->disk->queue->queue_lock, flags);
 	while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
 		int error;
 
@@ -99,7 +97,7 @@ static void blk_done(struct virtqueue *v
 	}
 	/* In case queue is stopped waiting for more buffers. */
 	blk_start_queue(vblk->disk->queue);
-	spin_unlock_irqrestore(&vblk->lock, flags);
+	spin_unlock_irqrestore(vblk->disk->queue->queue_lock, flags);
 }
 
 static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
@@ -431,7 +429,6 @@ static int __devinit virtblk_probe(struc
 		goto out_free_index;
 	}
 
-	spin_lock_init(&vblk->lock);
 	vblk->vdev = vdev;
 	vblk->sg_elems = sg_elems;
 	sg_init_table(vblk->sg, vblk->sg_elems);
@@ -456,7 +453,7 @@ static int __devinit virtblk_probe(struc
 		goto out_mempool;
 	}
 
-	q = vblk->disk->queue = blk_init_queue(do_virtblk_request, &vblk->lock);
+	q = vblk->disk->queue = blk_init_queue(do_virtblk_request, NULL);
 	if (!q) {
 		err = -ENOMEM;
 		goto out_put_disk;
