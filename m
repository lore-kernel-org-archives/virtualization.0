From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: BUG_ON in virtio-ring.c
Date: Mon, 27 May 2013 15:08:25 +0930
Message-ID: <87li71oucu.fsf@rustcorp.com.au>
References: <CAPM=9tyLrJ8VAdGCw_1guRS-ogCPE1Qp7faE_nrx_dAm2gvHLQ@mail.gmail.com>
	<87vc65p5a7.fsf@rustcorp.com.au>
	<CAPM=9tzw8jEv8yoLr7ktjO2DHCDzA+mURmJ-DXby_nsWUUNoyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9tzw8jEv8yoLr7ktjO2DHCDzA+mURmJ-DXby_nsWUUNoyg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Dave Airlie <airlied@gmail.com> writes:
>>> correct.
>>>
>>> If I have an indirect ring and I'm adding sgs to it and the host is
>>> delayed (say I've got a thread consuming things from the vring and its
>>> off doing something interesting),
>>> I'd really like to get ENOSPC back from virtqueue_add. However if the
>>> indirect addition fails due to free_sg being 0, we hit the BUG_ON
>>> before we ever get to the ENOSPC check.
>>
>> It is correct for the moment: drivers can't assume indirect buffer
>> support in the transport.
>>
>> BUT for a new device, we could say "this depends on indirect descriptor
>> support", put the appropriate check in the device init, and then remove
>> the BUG_ON().
>
> But if the transport has indirect buffer support, can it change its
> mind at runtime?

It's a layering violation.  The current rule is simple:

        A driver should never submit a buffer which can't fit in the
        ring.

This has the nice property that OOM (ie. indirect buffer alloction
fail) just slows things down, doesn't break things.

> In this case we have vq->indirect set, but the device has run out of
> free buffers,
> but it isn't a case that in+out would overflow it if it had free
> buffers since it would use
> an indirect and succeed.

OK, but when do you re-xmit?  What if the ring is empty, and you
submitted a buffer that needs indirect?  You won't get interrupted
again, because the device has consumed all the buffers.  You need to
have your own timer or something equally hackish.

> Getting -ENOSPC is definitely what should happen from what I can see,
> not a BUG_ON,
> I should get a BUG_ON only if the device reports no indirect support.

I think we should return -ENOMEM if we can't indirect because of failed
allocation and it doesn't fit in the ring, ie:

This:
	BUG_ON(total_sg > vq->vring.num);
	BUG_ON(total_sg == 0);

	if (vq->vq.num_free < total_sg) {
		pr_debug("Can't add buf len %i - avail = %i\n",
			 total_sg, vq->vq.num_free);
		/* FIXME: for historical reasons, we force a notify here if
		 * there are outgoing parts to the buffer.  Presumably the
		 * host should service the ring ASAP. */
		if (out_sgs)
			vq->notify(&vq->vq);
		END_USE(vq);
		return -ENOSPC;
	}

Becomes (untested):

	BUG_ON(total_sg == 0);

	if (vq->vq.num_free < total_sg) {
                if (total_sg > vq->vring.num) {
                        BUG_ON(!vq->indirect);
                       /* Return -ENOMEM only if we have nothing else to do */
                       if (vq->vq.num_free == vq->vring.num)
                               return -ENOMEM;
                }
		pr_debug("Can't add buf len %i - avail = %i\n",
			 total_sg, vq->vq.num_free);
		/* FIXME: for historical reasons, we force a notify here if
		 * there are outgoing parts to the buffer.  Presumably the
		 * host should service the ring ASAP. */
		if (out_sgs)
			vq->notify(&vq->vq);
		END_USE(vq);
		return -ENOSPC;
	}

Cheers,
Rusty.
