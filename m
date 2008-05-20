From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Tue, 20 May 2008 11:37:59 +1000
Message-ID: <200805201138.00435.rusty__24274.9334466227$1211258347$gmane$org@rustcorp.com.au>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<200805192221.52072.rusty@rustcorp.com.au>
	<48317FF7.1020707@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48317FF7.1020707@qumranet.com>
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

On Monday 19 May 2008 23:26:15 Avi Kivity wrote:
> Rusty Russell wrote:
> >>> Well, we do have such a thing, in the ring suppression flags.
> >>
> >> Can you point me at this?
> >
> > Ah, sorry, I misunderstood.  No, we don't have a threshold like this, we
> > have an all-or-nothing flag in each direction.
>
> Please point me anyway?

Sure, linux/virtio_ring.h:

/* The Host uses this in used->flags to advise the Guest: don't kick me when
 * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
 * will still kick if it's out of buffers. */
#define VRING_USED_F_NO_NOTIFY  1
/* The Guest uses this in avail->flags to advise the Host: don't interrupt me
 * when you consume a buffer.  It's unreliable, so it's simply an
 * optimization.  */
#define VRING_AVAIL_F_NO_INTERRUPT      1

> > We have the ability to add new fields to the rings.  I've put it on my
> > TODO to benchmark what this does.  It may or may not help.  In this case,
> > notification when there are no more packets in xmit ring would be
> > sufficient.  We already kick the host when we fill a ring even if
> > it says it doesn't need it, perhaps this would be symmetry.
>
> Notification on ring full is too late with smp.  You need to warn the
> other side in advance.

No, you misunderstand; this is not a performance issue.  On xmit, the driver 
cleans up any old used packets before trying to send anyway.  So it doesn't 
care when xmit packets are used, and suppresses the 'used' interrupt on the 
xmit virtqueue.  Only if the xmit ring is full does it enable the xmit-used 
notification.  This is optimal.

The issue is that we *do* actually care when xmit packets are used: we're 
supposed to free them in a timely manner and if the packet flow stops, we 
don't.  By always sending a used interrupt when *all* packets are used, we 
would cover this case quite nicely without impacting the normal case of 
packet flow.

> The reason I'm interested in adjustable thresholds is that you can then
> to tx mitigation without (usually) suffering the worst-case latency when
> you aren't streaming or streaming slower than what you tuned for.

Right, this would be a threshold that the host would set, approx. "when you've 
put this many packets in the xmit ring, tell me" (the opposite direction of 
the discussion above).  Currently we will kick the host on the first packet, 
and qemu will suppress the notifications based on some timer and we'll notify 
it anyway if the ring fills (which is suboptimal).  With this technique the 
host could double the threshold up to some maximum percentage of the ring.

While I like the Xen scheme, we can do the same thing from within the guest 
with the existing scheme using an internal threshold.  We are always allowed 
to send "spurious" notifications to the host, so it can't break anything.

Added to TODO.

Thanks,
Rusty.
