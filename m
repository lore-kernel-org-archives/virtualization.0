From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private data
Date: Sat, 28 Apr 2007 08:37:42 +1000
Message-ID: <20070427223742.GA2742@gondor.apana.org.au>
References: <20070423215638.563901986@goop.org> <20070423215713.550883195@goop.org> <20070424014528.GA27789@gondor.apana.org.au> <462D88EF.9030007@goop.org> <20070424055731.GA30018@gondor.apana.org.au> <46327706.80508@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757498AbXD0Wij@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46327706.80508@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 27, 2007 at 03:19:50PM -0700, Jeremy Fitzhardinge wrote:
> 
> OK, I've been sitting on this in the hope that I'll suddenly see the
> light and work out what you're talking about - but apparently that's not
> going to happen.  So, some questions:
> 
>    1. Does this patch change the dom0 <-> domU interface?  or does it
>       fix something that's currently broken?

No it doesn't change the interface at all.

>    2. Can just apply the netfront part to the pv_ops kernel, or does it
>       require the corresponding dom0 patch to be applied as well?

They can be applied separately so you don't need the dom0 part for your
tree.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
