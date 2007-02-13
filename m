From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 5/8] lguest: trivial guest network driver
Date: Wed, 14 Feb 2007 01:06:00 +1100
Message-ID: <20070213140600.GA24711@gondor.apana.org.au>
References: <1171251578.10409.17.camel@localhost.localdomain> <1171251698.10409.20.camel@localhost.localdomain> <1171251770.10409.23.camel@localhost.localdomain> <1171251894.10409.26.camel@localhost.localdomain> <1171251965.10409.28.camel@localhost.localdomain> <1171252113.10409.30.camel@localhost.localdomain> <1171252219.10409.33.camel@localhost.localdomain> <1171252321.10409.36.camel@localhost.localdomain> <20070212155553.GA15627@gondor.apana.org.au> <1171332919.19842.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750718AbXBMOG5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1171332919.19842.74.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, jgarzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 13, 2007 at 01:15:18PM +1100, Rusty Russell wrote:
> 
> Good spotting!  This function needs to be passed skb_headlen(skb),
> rather than skb->len.  Patch is below (I renamed the parameter as well,
> for clarity).

How about just dropping that parameter and using skb_headlen(skb)
directly?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
