From: Kamal Mostafa <kamal@canonical.com>
Subject: [3.13.y.z extended stable] Patch "block: virtio_blk: don't hold spin
	lock during world switch" has been added to staging queue
Date: Tue, 15 Jul 2014 14:29:27 -0700
Message-ID: <1405459767-9649-1-git-send-email-kamal__15625.9499876343$1405520890$gmane$org@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kamal Mostafa <kamal@canonical.com>, virtualization@lists.linux-foundation.org, Jens Axboe <axboe@fb.com>, kernel-team@lists.ubuntu.com
List-Id: virtualization@lists.linuxfoundation.org

This is a note to let you know that I have just added a patch titled

    block: virtio_blk: don't hold spin lock during world switch

to the linux-3.13.y-queue branch of the 3.13.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11.5.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

From 7e3901f7d16885eed2126c03feb1ad993d86f207 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 30 May 2014 10:49:29 +0800
Subject: block: virtio_blk: don't hold spin lock during world switch

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/block/virtio_blk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b734f2..53e3db6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -159,6 +159,7 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx, struct request *req)
 	unsigned int num;
 	const bool last = (req->cmd_flags & REQ_END) != 0;
 	int err;
+	bool notify = false;

 	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);

@@ -211,10 +212,12 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx, struct request *req)
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

--
1.9.1
