From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [PATCH 1/3] virtio: fix virtio_net xmit of freed skb bug
Date: Fri, 13 Jun 2008 15:14:00 +0100
Message-ID: <1213366440.9507.0.camel__9327.06084936417$1213367152$gmane$org@muff>
References: <200805261742.43215.rusty@rustcorp.com.au>
	<1211886386.3637.48.camel@muff>
	<200805291634.18224.rusty@rustcorp.com.au>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805291634.18224.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-05-29 at 16:34 +1000, Rusty Russell wrote:
> On Tuesday 27 May 2008 21:06:26 Mark McLoughlin wrote:
> > On Mon, 2008-05-26 at 17:42 +1000, Rusty Russell wrote:
> > > If we fail to transmit a packet, we assume the queue is full and put
> > > the skb into last_xmit_skb.  However, if more space frees up before we
> > > xmit it, we loop, and the result can be transmitting the same skb twice.
> > >
> > > Fix is simple: set skb to NULL if we've used it in some way, and check
> > > before sending.
> 
> Great! It's a corner case, but it's no more complicated to do it your way.
> 
> Minor mod, I find it clearer to have the vi->last_xmit_skb = NULL; under
> the branch:
> 
> Subject: [PATCH] virtio_net: Delay dropping tx skbs
> Date: Tue, 27 May 2008 12:06:26 +0100
> From: Mark McLoughlin <markmc@redhat.com>
> 
> Currently we drop the skb in start_xmit() if we have a
> queued buffer and fail to transmit it.
> 
> However, if we delay dropping it until we've stopped the
> queue and enabled the tx notification callback, then there
> is a chance space might become available for it.

Hmm, we lost this one somewhere along the way ...

Cheers,
Mark.
