From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private data
Date: Tue, 24 Apr 2007 11:45:28 +1000
Message-ID: <20070424014528.GA27789@gondor.apana.org.au>
References: <20070423215638.563901986@goop.org> <20070423215713.550883195@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754552AbXDXBqP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070423215713.550883195@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 23, 2007 at 02:57:00PM -0700, Jeremy Fitzhardinge wrote:
> Netfront's use of nh.raw and h.raw for storing page+offset is a bit
> hinky, and it breaks with upcoming network stack updates which reduce
> these fields to sub-pointer sizes.  Fortunately, skb offers the "cb"
> field specifically for stashing this kind of info, so use it.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Cc: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>

Thanks Jeremy.  The patch looks good.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
