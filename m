From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Mon, 19 May 2008 22:21:51 +1000
Message-ID: <200805192221.52072.rusty__5621.08477247438$1211199952$gmane$org@rustcorp.com.au>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<200805191152.28409.rusty@rustcorp.com.au>
	<483155D4.2090700@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <483155D4.2090700@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 19 May 2008 20:26:28 Avi Kivity wrote:
> Rusty Russell wrote:
> >> We should have thought of this before, though, especially as Xen does
> >>
> >> this or something very similar:
> >>> /* Shared ring page */                            \
> >>> struct __name##_sring {                            \
> >>>     RING_IDX req_prod, req_event;                    \
> >>>     RING_IDX rsp_prod, rsp_event;                    \
> >>>     uint8_t  pad[48];                            \
> >>>     union __name##_sring_entry ring[1]; /* variable-length */        \
> >>> };                                    \
> >>
> >> req_event and rsp_event allow the other side to indicate when it wants a
> >> notification.
> >
> > Well, we do have such a thing, in the ring suppression flags.
>
> Can you point me at this?

Ah, sorry, I misunderstood.  No, we don't have a threshold like this, we
have an all-or-nothing flag in each direction.

We have the ability to add new fields to the rings.  I've put it on my
TODO to benchmark what this does.  It may or may not help.  In this case,
notification when there are no more packets in xmit ring would be
sufficient.  We already kick the host when we fill a ring even if
it says it doesn't need it, perhaps this would be symmetry.

> >   Note that DaveM
> > is talking about moving network tx queue into the net drivers themselves,
> > which will make them much more efficient (ie. drain entire queue before
> > kick), which may again change the balance of what the Right Thing is.
>
> That depends on whether Linux knows whether more packets are coming.

The current problem is that hard_start_xmit gets called with a packet, and 
has no idea if there are more in the tx queue.  By having the driver control
the queue, it can at least tell that.

The question remains whether this will be sufficient for tx mitigation.  A
program may be about to write more to the socket, and we can't know that.
But it can hardly hurt.

In turn, sending out such packet bursts will have an effect on packet reuse.  

Cheers,
Rusty.
