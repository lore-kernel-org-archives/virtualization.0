From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Virtio draft IV: the net driver
Date: Wed, 11 Jul 2007 21:32:16 +1000
Message-ID: <1184153536.6005.622.camel@localhost.localdomain>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<1183522765.6110.40.camel@localhost.localdomain>
	<1183524053.6110.45.camel@localhost.localdomain>
	<200707111245.40717.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707111245.40717.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-11 at 12:45 +0200, Christian Borntraeger wrote:
> Am Mittwoch, 4. Juli 2007 schrieb Rusty Russell:
> > +static void receive_skb(struct net_device *dev, struct sk_buff *skb,
> [...]
> > +	netif_rx(skb);
> 
> In the NAPI case, we should use netif_receive_skb, no?

Oops, well spotted!

I'm working on GSO and checksum offload support at the moment, will roll
that fix into the next release.

Thanks!
Rusty.
