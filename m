From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/8] lguest: trivial guest network driver
Date: Wed, 14 Feb 2007 15:47:55 +1100
Message-ID: <1171428475.19842.102.camel@localhost.localdomain>
References: <1171251578.10409.17.camel@localhost.localdomain>
	 <1171251698.10409.20.camel@localhost.localdomain>
	 <1171251770.10409.23.camel@localhost.localdomain>
	 <1171251894.10409.26.camel@localhost.localdomain>
	 <1171251965.10409.28.camel@localhost.localdomain>
	 <1171252113.10409.30.camel@localhost.localdomain>
	 <1171252219.10409.33.camel@localhost.localdomain>
	 <1171252321.10409.36.camel@localhost.localdomain>
	 <20070212155553.GA15627@gondor.apana.org.au>
	 <1171332919.19842.74.camel@localhost.localdomain>
	 <20070213140600.GA24711@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932304AbXBNEsy@vger.kernel.org>
In-Reply-To: <20070213140600.GA24711@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, jgarzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-02-14 at 01:06 +1100, Herbert Xu wrote:
> On Tue, Feb 13, 2007 at 01:15:18PM +1100, Rusty Russell wrote:
> > 
> > Good spotting!  This function needs to be passed skb_headlen(skb),
> > rather than skb->len.  Patch is below (I renamed the parameter as well,
> > for clarity).
> 
> How about just dropping that parameter and using skb_headlen(skb)
> directly?

It's also used to generate dma structs for outgoing packets.  In that
case, skb_headlen() == 0:

static struct sk_buff *lguestnet_alloc_skb(struct net_device *dev, int gfpflags)
{
	struct sk_buff *skb;

	skb = alloc_skb(16 + ETH_HLEN + DATA_SIZE, gfpflags);
	if (!skb)
		return NULL;

	skb->dev = dev;
	skb_reserve(skb, 16);
	return skb;
}

/* Find a new skb to put in this slot in shared mem. */
static int fill_slot(struct net_device *dev, unsigned int slot)
{
	struct lguestnet_info *info = dev->priv;
	/* Try to create and register a new one. */
	info->skb[slot] = lguestnet_alloc_skb(dev, GFP_ATOMIC);
	if (!info->skb[slot]) {
		printk("%s: could not fill slot %i\n", dev->name, slot);
		return -ENOMEM;
	}

	skb_to_dma(info->skb[slot], ETH_HLEN + DATA_SIZE, &info->dma[slot]);

Cheers,
Rusty.
