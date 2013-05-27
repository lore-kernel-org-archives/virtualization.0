From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: BUG_ON in virtio-ring.c
Date: Mon, 27 May 2013 11:12:24 +0930
Message-ID: <87vc65p5a7.fsf@rustcorp.com.au>
References: <CAPM=9tyLrJ8VAdGCw_1guRS-ogCPE1Qp7faE_nrx_dAm2gvHLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9tyLrJ8VAdGCw_1guRS-ogCPE1Qp7faE_nrx_dAm2gvHLQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Dave Airlie <airlied@gmail.com> writes:
> Hi Rusty,
>
> current virtio-ring.c has a BUG_ON in virtqueue_add that checks
> total_sg > vg->vring.num, however I'm not sure it really is 100%
> correct.
>
> If I have an indirect ring and I'm adding sgs to it and the host is
> delayed (say I've got a thread consuming things from the vring and its
> off doing something interesting),
> I'd really like to get ENOSPC back from virtqueue_add. However if the
> indirect addition fails due to free_sg being 0, we hit the BUG_ON
> before we ever get to the ENOSPC check.

It is correct for the moment: drivers can't assume indirect buffer
support in the transport.

BUT for a new device, we could say "this depends on indirect descriptor
support", put the appropriate check in the device init, and then remove
the BUG_ON().

> the BUG_ON is quite valid in the no indirect case, but when we have
> indirect buffers it doesn't seem like it always makes sense.
>
> Not sure best way to fix it, I'm just a virtio newbie :)

Mailing me and the list was the right thing, since this raises question
of the spec as well as the Linux implementation.

Good luck!
Rusty.
