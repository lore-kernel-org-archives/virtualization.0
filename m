From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Wed, 14 May 2008 16:07:25 +1000
Message-ID: <200805141607.26306.rusty__17388.8437137522$1210745388$gmane$org@rustcorp.com.au>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<1210624663.14409.20.camel@muff> <48294776.3010504@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48294776.3010504@qumranet.com>
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

On Tuesday 13 May 2008 17:47:02 Avi Kivity wrote:
> Mark McLoughlin wrote:
> > virtio_net currently only frees old transmit skbs just
> > before queueing new ones. If the queue is full, it then
> > enables interrupts and waits for notification that more
> > work has been performed.
> >
> > However, a side-effect of this scheme is that there are
> > always xmit skbs left dangling when no new packets are
> > sent, against the Documentation/networking/driver.txt
> > guideline:
> >
> >   "... it is not allowed for your TX mitigation scheme
> >    to let TX packets "hang out" in the TX ring unreclaimed
> >    forever if no new TX packets are sent."
> >
> > Add a timer to ensure that any time we queue new TX
> > skbs, we will shortly free them again.
> >
> > This fixes an easily reproduced hang at shutdown where
> > iptables attempts to unload nf_conntrack and nf_conntrack
> > waits for an skb it is tracking to be freed, but virtio_net
> > never frees it.
>
> Sorry to barge in late, but IMO the timer should be on the host, which
> is cheaper than on the guest (well, a 100ms timer is likely zero cost,
> but  I still don't like it).
>
> the host should fire a tx completion interrupt whenever the completion
> queue has "enough" entries, where we can define "enough" now as the
> halfway mark or a timer expiry, whichever comes earlier.
>
> We can later improve "enough" to be "just enough so the timer never
> triggers" and adjust it dynamically.  It probably doesn't matter for
> Linux, but I don't want to punish guests that can do true async
> networking and depend on timely completion notification.

This implies that we should not be supressing notifications in the guest at 
all (unless we're sure there are more packets to come, which currently we 
never are: that needs new net infrastructure).

But that means we'd get a notification on every xmit at the moment.  
Benchmarks anyone?

Rusty.
