From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.15 002/139] block: virtio_blk: dont hold spin lock during
	world switch
Date: Sat, 28 Jun 2014 10:46:03 -0700
Message-ID: <20140628174605.469557168@linuxfoundation.org>
References: <20140628174605.352098823@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140628174605.352098823@linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ming Lei <ming.lei@canonical.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Jens Axboe <axboe@fb.com>
List-Id: virtualization@lists.linuxfoundation.org

3.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@canonical.com>

commit e8edca6f7f92234202d6dd163c118ef495244d7c upstream.

Firstly, it isn't necessary to hold lock of vblk->vq_lock
when notifying hypervisor about queued I/O.

Secondly, virtqueue_notify() will cause world switch and
it may take long time on some hypervisors(such as, qemu-arm),
so it isn't good to hold the lock and block other vCPUs.

On arm64 quad core VM(qemu-kvm), the patch can increase I/O
performance a lot with VIRTIO_RING_F_EVENT_IDX enabled:
	- without the patch: 14K IOPS
	- with the patch: 34K IOPS

fio script:
	[global]
	direct=1
	bsrange=4k-4k
	timeout=10
	numjobs=4
	ioengine=libaio
	iodepth=64

	filename=/dev/vdc
	group_reporting=1

	[f1]
	rw=randread

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Ming Lei <ming.lei@canonical.com>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/virtio_blk.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -159,6 +159,7 @@ static int virtio_queue_rq(struct blk_mq
 	unsigned int num;
 	const bool last = (req->cmd_flags & REQ_END) != 0;
 	int err;
+	bool notify = false;
 
 	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
 
@@ -211,10 +212,12 @@ static int virtio_queue_rq(struct blk_mq
 		return BLK_MQ_RQ_QUEUE_ERROR;
 	}
 
-	if (last)
-		virtqueue_kick(vblk->vq);
-
+	if (last && virtqueue_kick_prepare(vblk->vq))
+		notify = true;
 	spin_unlock_irqrestore(&vblk->vq_lock, flags);
+
+	if (notify)
+		virtqueue_notify(vblk->vq);
 	return BLK_MQ_RQ_QUEUE_OK;
 }
