From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private
 data
Date: Sun, 29 Apr 2007 00:43:33 -0700
Message-ID: <46344CA5.6000900@goop.org>
References: <20070423215638.563901986@goop.org> <20070423215713.550883195@goop.org> <20070424014528.GA27789@gondor.apana.org.au> <462D88EF.9030007@goop.org> <20070424055731.GA30018@gondor.apana.org.au> <46327706.80508@goop.org> <20070427223742.GA2742@gondor.apana.org.au> <463286D9.7090609@goop.org> <20070428062839.GA6535@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755029AbXD2HnZ@vger.kernel.org>
In-Reply-To: <20070428062839.GA6535@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Herbert Xu wrote:
> BTW, the version I posted to you is missing the following line.
>   
> --- linux-2.6.20.i386/drivers/xen/core/skbuff.c	2007-04-28 15:30:16.000000000 +1000
> +++ build-2.6.20.i386/drivers/xen/core/skbuff.c	2007-04-28 15:30:52.000000000 +1000
> @@ -89,6 +89,7 @@
>  	skb->h.raw = (unsigned char *)skb->nh.iph + 4*skb->nh.iph->ihl;
>  	if (skb->h.raw >= skb->tail)
>  		goto out;
> +	skb->csum_start = skb->h.raw - skb->head;
>  	switch (skb->nh.iph->protocol) {
>  	case IPPROTO_TCP:
>  		skb->csum_offset = offsetof(struct tcphdr, check);
>   

drivers/xen/core/skbuff.c?  What's that?

    J
