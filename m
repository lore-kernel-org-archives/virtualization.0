From: Dave Airlie <airlied@gmail.com>
Subject: Re: BUG_ON in virtio-ring.c
Date: Mon, 27 May 2013 13:29:50 +1000
Message-ID: <CAPM=9tzw8jEv8yoLr7ktjO2DHCDzA+mURmJ-DXby_nsWUUNoyg__18244.2203550183$1369958569$gmane$org@mail.gmail.com>
References: <CAPM=9tyLrJ8VAdGCw_1guRS-ogCPE1Qp7faE_nrx_dAm2gvHLQ@mail.gmail.com>
	<87vc65p5a7.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87vc65p5a7.fsf@rustcorp.com.au>
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
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>> correct.
>>
>> If I have an indirect ring and I'm adding sgs to it and the host is
>> delayed (say I've got a thread consuming things from the vring and its
>> off doing something interesting),
>> I'd really like to get ENOSPC back from virtqueue_add. However if the
>> indirect addition fails due to free_sg being 0, we hit the BUG_ON
>> before we ever get to the ENOSPC check.
>
> It is correct for the moment: drivers can't assume indirect buffer
> support in the transport.
>
> BUT for a new device, we could say "this depends on indirect descriptor
> support", put the appropriate check in the device init, and then remove
> the BUG_ON().

But if the transport has indirect buffer support, can it change its
mind at runtime?

In this case we have vq->indirect set, but the device has run out of
free buffers,
but it isn't a case that in+out would overflow it if it had free
buffers since it would use
an indirect and succeed.

Getting -ENOSPC is definitely what should happen from what I can see,
not a BUG_ON,
I should get a BUG_ON only if the device reports no indirect support.

Dave.
