From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private
	data
Date: Sun, 29 Apr 2007 18:05:15 +1000
Message-ID: <20070429080515.GA16942@gondor.apana.org.au>
References: <20070423215638.563901986@goop.org>
	<20070423215713.550883195@goop.org>
	<20070424014528.GA27789@gondor.apana.org.au>
	<462D88EF.9030007@goop.org>
	<20070424055731.GA30018@gondor.apana.org.au>
	<46327706.80508@goop.org>
	<20070427223742.GA2742@gondor.apana.org.au>
	<463286D9.7090609@goop.org>
	<20070428062839.GA6535@gondor.apana.org.au>
	<46344CA5.6000900@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46344CA5.6000900@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Apr 29, 2007 at 12:43:33AM -0700, Jeremy Fitzhardinge wrote:
> Herbert Xu wrote:
> > BTW, the version I posted to you is missing the following line.
> >   
> > --- linux-2.6.20.i386/drivers/xen/core/skbuff.c	2007-04-28 15:30:16.000000000 +1000
> > +++ build-2.6.20.i386/drivers/xen/core/skbuff.c	2007-04-28 15:30:52.000000000 +1000
> > @@ -89,6 +89,7 @@
> >  	skb->h.raw = (unsigned char *)skb->nh.iph + 4*skb->nh.iph->ihl;
> >  	if (skb->h.raw >= skb->tail)
> >  		goto out;
> > +	skb->csum_start = skb->h.raw - skb->head;
> >  	switch (skb->nh.iph->protocol) {
> >  	case IPPROTO_TCP:
> >  		skb->csum_offset = offsetof(struct tcphdr, check);
> >   
> 
> drivers/xen/core/skbuff.c?  What's that?

It's part of the skb_checksum_setup function which we still need
for this because the current netback protocol doesn't pass the
csum_start and csum_offset values along.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
