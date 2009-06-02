From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/4] virtio_net: return NETDEV_TX_BUSY instead of queueing
	an extra skb.
Date: Tue, 2 Jun 2009 23:25:57 +0930
Message-ID: <200906022325.57961.rusty__12404.2281568565$1243951025$gmane$org@rustcorp.com.au>
References: <200905292346.04815.rusty@rustcorp.com.au>
	<20090602090552.GA26611@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090602090552.GA26611@gondor.apana.org.au>
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
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2 Jun 2009 06:35:52 pm Herbert Xu wrote:
> On Fri, May 29, 2009 at 11:46:04PM +0930, Rusty Russell wrote:
> > This effectively reverts 99ffc696d10b28580fe93441d627cf290ac4484c
> > "virtio: wean net driver off NETDEV_TX_BUSY".
> >
> > The complexity of queuing an skb (setting a tasklet to re-xmit) is
> > questionable, especially once we get rid of the other reason for the
> > tasklet in the next patch.
> >
> > If the skb won't fit in the tx queue, just return NETDEV_TX_BUSY.  It
> > might be frowned upon, but it's common and not going away any time
> > soon.
>
> This looks like a step backwards to me.  If we have to do this
> to fix a bug, sure.  But just doing it for the sake of it smells
> wrong.

I disagree.  We've introduced a third queue, inside the driver, one element 
long.  That feels terribly, terribly hacky and wrong.

What do we do if it overflows?  Discard the packet, even if we have room in the 
tx queue.   And when do we flush this queue?  Well, that's a bit messy.  
Obviously we need to enable the tx interrupt when the tx queue is full, but we 
can't just netif_wake_queue, we have to also flush the queue.  We can't do that 
in an irq handler, since we need to block the normal tx path (or introduce 
another lock and disable interrupts in our xmit routine).  So we add a tasklet 
to do this re-transmission.

Or, we could just "return NETDEV_TX_BUSY;".  I like that :)

Hope that clarifies,
Rusty.



>
> Cheers,
