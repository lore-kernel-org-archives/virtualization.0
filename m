From: Christoph Paasch <christoph.paasch@gmail.com>
Subject: Re: Kmemleak: false-positive in vring_add_indirect ?
Date: Fri, 4 Oct 2013 09:23:34 +0200
Message-ID: <CALMXkpYyFwKtbyp2_yRfxt0_0HddfF+GJDw7y2CGArg9H+cFtQ@mail.gmail.com>
References: <20131002202047.GA7419@cpaasch-mac>
	<87d2nlykgd.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d2nlykgd.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Paasch <christoph.paasch@uclouvain.be>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 4, 2013 at 1:59 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Thanks!  Does this work?
>
> virtio_ring: plug kmemleak false positive.
>
> unreferenced object 0xffff88003d467e20 (size 32):
>   comm "softirq", pid 0, jiffies 4295197765 (age 6.364s)
>   hex dump (first 32 bytes):
>     28 19 bf 3d 00 00 00 00 0c 00 00 00 01 00 01 00  (..=............
>     02 dc 51 3c 00 00 00 00 56 00 00 00 00 00 00 00  ..Q<....V.......
>   backtrace:
>     [<ffffffff8152db19>] kmemleak_alloc+0x59/0xc0
>     [<ffffffff81102e93>] __kmalloc+0xf3/0x180
>     [<ffffffff812db5d6>] vring_add_indirect+0x36/0x280
>     [<ffffffff812dc59f>] virtqueue_add_outbuf+0xbf/0x4e0
>     [<ffffffff813a8b30>] start_xmit+0x1a0/0x3b0
>     [<ffffffff81445861>] dev_hard_start_xmit+0x2d1/0x4d0
>     [<ffffffff81460052>] sch_direct_xmit+0xf2/0x1c0
>     [<ffffffff81445c28>] dev_queue_xmit+0x1c8/0x460
>     [<ffffffff814e3187>] ip6_finish_output2+0x1d7/0x470
>     [<ffffffff814e34b0>] ip6_finish_output+0x90/0xb0
>     [<ffffffff814e3507>] ip6_output+0x37/0xb0
>     [<ffffffff815021eb>] igmp6_send+0x2db/0x470
>     [<ffffffff81502645>] igmp6_timer_handler+0x95/0xa0
>     [<ffffffff8104b57c>] call_timer_fn+0x2c/0x90
>     [<ffffffff8104b7ba>] run_timer_softirq+0x1da/0x1f0
>     [<ffffffff81045721>] __do_softirq+0xd1/0x1b0
>
> Address gets embedded in a descriptor via virt_to_phys().  See detach_buf,
> which frees it:
>
>         if (vq->vring.desc[i].flags & VRING_DESC_F_INDIRECT)
>                 kfree(phys_to_virt(vq->vring.desc[i].addr));
>
> Reported-by: Christoph Paasch <christoph.paasch@uclouvain.be>
> Fix-suggested-by: Christoph Paasch <christoph.paasch@uclouvain.be>
> Typing-done-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c

Yes, it does work.

Tested-by: Christoph Paasch <christoph.paasch@uclouvain.be>

This patch should be sent to stable.


Thanks,
Christoph

> index 6b4a4db..6547d46 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -173,6 +173,8 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
>         head = vq->free_head;
>         vq->vring.desc[head].flags = VRING_DESC_F_INDIRECT;
>         vq->vring.desc[head].addr = virt_to_phys(desc);
> +       /* kmemleak gives a false positive, as it's hidden by virt_to_phys */
> +       kmemleak_ignore(desc);
>         vq->vring.desc[head].len = i * sizeof(struct vring_desc);
>
>         /* Update free pointer */
