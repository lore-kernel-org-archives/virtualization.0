From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: req->nr_phys_segments > queue_max_segments (was Re: kernel BUG
	at drivers/block/virtio_blk.c:172!)
Date: Thu, 1 Oct 2015 16:19:04 +0300
Message-ID: <20151001161812-mutt-send-email-mst@redhat.com>
References: <560C87F6.4080708@whissi.de>
	<20151001114817-mutt-send-email-mst@redhat.com>
	<20151001101604.GA24150@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151001101604.GA24150@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>
Cc: "Thomas D." <whissi@whissi.de>, Christoph Hellwig <hch@lst.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 01, 2015 at 12:16:04PM +0200, Jens Axboe wrote:
> On 10/01/2015 11:00 AM, Michael S. Tsirkin wrote:
> >On Thu, Oct 01, 2015 at 03:10:14AM +0200, Thomas D. wrote:
> >>Hi,
> >>
> >>I have a virtual machine which fails to boot linux-4.1.8 while mounting
> >>file systems:
> >>
> >>>* Mounting local filesystem ...
> >>>------------[ cut here ]------------
> >>>kernel BUG at drivers/block/virtio_blk.c:172!
> >>>invalid opcode: 000 [#1] SMP
> >>>Modules linked in: pcspkr psmouse dm_log_userspace virtio_net e1000 fuse nfs lockd grace sunrpc fscache dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log usbhid usb_storage sr_mod cdrom
> >>>CPU: 7 PIDL 2254 Comm: dmcrypt_write Not tainted 4.1.8-gentoo #1
> >>>Hardware name: Red Hat KVM, BIOS seabios-1.7.5-8.el7 04/01/2014
> >>>task: ffff88061fb70000 ti: ffff88061ff30000 task.ti: ffff88061ff30000
> >>>RIP: 0010:[<ffffffffb4557b30>] [<ffffffffb4557b30>] virtio_queue_rq+0x210/0x2b0
> >>>RSP: 0018:ffff88061ff33ba8 EFLAGS: 00010202
> >>>RAX: 00000000000000b1 RBX: ffff88061fb2fc00 RCX: ffff88061ff33c30
> >>>RDX: 0000000000000008 RSI: ffff88061ff33c50 RDI: ffff88061fb2fc00
> >>>RBP: ffff88061ff33bf8 R08: ffff88061eef3540 R09: ffff88061ff33c30
> >>>R10: 0000000000000000 R11: 00000000000000af R12: 0000000000000000
> >>>R13: ffff88061eef3540 R14: ffff88061eef3540 R15: ffff880622c7ca80
> >>>FS:  0000000000000000(0000) GS:ffff88063fdc0000(0000) knlGS:0000000000000000
> >>>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>CR2: 0000000001ffe468 CR3: 00000000bb343000 CR4: 00000000001406e0
> >>>Stack:
> >>>  ffff880622d4c478 0000000000000000 ffff88061ff33bd8 ffff88061fb2f
> >>>  0000000000000001 ffff88061fb2fc00 ffff88061ff33c30 0000000000000
> >>>  ffff88061eef3540 0000000000000000 ffff88061ff33c98 ffffffffb43eb
> >>>
> >>>Call Trace:
> >>>  [<ffffffffb43eb500>] __blk_mq_run_hw_queue+0x1d0/0x370
> >>>  [<ffffffffb43eb315>] blk_mq_run_hw_queue+0x95/0xb0
> >>>  [<ffffffffb43ec804>] blk_mq_flush_plug_list+0x129/0x140
> >>>  [<ffffffffb43e33d8>] blk_finish_plug+0x18/0x50
> >>>  [<ffffffffb45e3bea>] dmcrypt_write+0x1da/0x1f0
> >>>  [<ffffffffb4108c90>] ? wake_up_state+0x20/0x20
> >>>  [<ffffffffb45e3a10>] ? crypt_iv_lmk_dtr+0x60/0x60
> >>>  [<ffffffffb40fb789>] kthread_create_on_node+0x180/0x180
> >>>  [<ffffffffb4705e92>] ret_from_fork+0x42/0x70
> >>>  [<ffffffffb40fb6c0>] ? kthread_create_on_node+0x180/0x180
> >>>Code: 00 0000 41 c7 85 78 01 00 00 08 00 00 00 49 c7 85 80 01 00 00 00 00 00 00 41 89 85 7c 01 00 00 e9 93 fe ff ff 66 0f 1f 44 00 00 <0f> 0b 66 0f 1f 44 00 00 49 8b 87 b0 00 00 00 41 83 e6 ef 4a 8b
> >>>RIP [<ffffffffb4557b30>] virtio_queue_rq+0x210/0x2b0
> >>>  RSP: <ffff88061ff33ba8>
> >>>---[ end trace 8078357c459d5fc0 ]---
> >
> >
> >So this BUG_ON is from 1cf7e9c68fe84248174e998922b39e508375e7c1.
> >	commit 1cf7e9c68fe84248174e998922b39e508375e7c1
> >	Author: Jens Axboe <axboe@kernel.dk>
> >	Date:   Fri Nov 1 10:52:52 2013 -0600
> >
> >	    virtio_blk: blk-mq support
> >
> >
> >       BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> >
> >
> >On probe, we do
> >         /* We can handle whatever the host told us to handle. */
> >         blk_queue_max_segments(q, vblk->sg_elems-2);
> >
> >
> >To debug this,
> >maybe you can print out sg_elems at init time and when this fails,
> >to make sure some kind of memory corruption
> >does not change sg_elems after initialization?
> >
> >
> >Jens, how may we get more segments than blk_queue_max_segments?
> >Is driver expected to validate and drop such requests?
> 
> The answer is that this should not happen. If the driver informs of a limit
> on the number of segments, that should never be exceeded. If it does, then
> it's a bug in either the SG mapping, or in the building of the request -
> either the request gets built too large for some reason, or the mapping
> doesn't always coalesce segments even though it should.
> 
> The problem is that we get notified out-of-band, when we attempt to push the
> request to the driver. At this point, much of the context could be lost,
> like it is in your case.
> 
> Looking at the specific virtio_blk case, it does seem that it is
> checking the segment count before mapping. Does the below fix the
> problem, or does the BUG_ON() still trigger?

Jens, I have no idea whether this is the right thing to do,
so please merge this patch directly if it makes sense.

> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6ca35495a5be..1501701b0202 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -169,8 +169,6 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	int err;
> 	bool notify = false;
> 
> -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> -
> 	vbr->req = req;
> 	if (req->cmd_flags & REQ_FLUSH) {
> 		vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_FLUSH);
> @@ -203,6 +201,7 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> 
> 	num = blk_rq_map_sg(hctx->queue, vbr->req, vbr->sg);
> 	if (num) {
> +		BUG_ON(num + 2 > vblk->sg_elems);
> 		if (rq_data_dir(vbr->req) == WRITE)
> 			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);
> 		else
> 
> -- 
> Jens Axboe
