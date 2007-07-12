From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Virtio draft IV: the net driver
Date: Thu, 12 Jul 2007 12:21:33 +1000
Message-ID: <1184206893.6005.669.camel@localhost.localdomain>
References: <1183522765.6110.40.camel@localhost.localdomain>
	<1183524053.6110.45.camel@localhost.localdomain>
	<200707111245.40717.borntraeger@de.ibm.com>
	<20070711.134447.39159166.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070711.134447.39159166.davem@davemloft.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: borntraeger@de.ibm.com, cotte@de.ibm.com, herbert@gondor.apana.org.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-11 at 13:44 -0700, David Miller wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> Date: Wed, 11 Jul 2007 12:45:40 +0200
> 
> > Am Mittwoch, 4. Juli 2007 schrieb Rusty Russell:
> > > +static void receive_skb(struct net_device *dev, struct sk_buff *skb,
> > [...]
> > > +	netif_rx(skb);
> > 
> > In the NAPI case, we should use netif_receive_skb, no?
> 
> NAPI doesn't make sense for virtual devices, my Sun LDOM nework
> driver won't use NAPI either.
> 
> It's also too cumbersome to use NAPI with the way virtualized
> network drivers work (multiple ports, each with an interrupt
> source, not just one) until the NAPI split patches are ported
> and applied upstream and that won't be for a while.

Dave, I think you're the only one (so far?) with multiple irqs.

It's not clear that guest-controlled interrupt mitigation is the best
approach for virtual devices, but at the moment it doesn't hurt.

Cheers,
Rusty.
