From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private data
Date: Sat, 28 Apr 2007 16:28:39 +1000
Message-ID: <20070428062839.GA6535@gondor.apana.org.au>
References: <20070423215638.563901986@goop.org> <20070423215713.550883195@goop.org> <20070424014528.GA27789@gondor.apana.org.au> <462D88EF.9030007@goop.org> <20070424055731.GA30018@gondor.apana.org.au> <46327706.80508@goop.org> <20070427223742.GA2742@gondor.apana.org.au> <463286D9.7090609@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754747AbXD1G3F@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <463286D9.7090609@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 27, 2007 at 04:27:21PM -0700, Jeremy Fitzhardinge wrote:
> Herbert Xu wrote:
> > They can be applied separately so you don't need the dom0 part for your
> > tree.
> 
> Great, thanks.

BTW, the version I posted to you is missing the following line.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
--- linux-2.6.20.i386/drivers/xen/core/skbuff.c	2007-04-28 15:30:16.000000000 +1000
+++ build-2.6.20.i386/drivers/xen/core/skbuff.c	2007-04-28 15:30:52.000000000 +1000
@@ -89,6 +89,7 @@
 	skb->h.raw = (unsigned char *)skb->nh.iph + 4*skb->nh.iph->ihl;
 	if (skb->h.raw >= skb->tail)
 		goto out;
+	skb->csum_start = skb->h.raw - skb->head;
 	switch (skb->nh.iph->protocol) {
 	case IPPROTO_TCP:
 		skb->csum_offset = offsetof(struct tcphdr, check);
