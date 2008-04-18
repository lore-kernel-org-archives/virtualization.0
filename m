From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [6/6] [VIRTIO] net: Allow receiving SG packets
Date: Fri, 18 Apr 2008 22:30:20 +0800
Message-ID: <20080418143020.GA21623@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418032142.GD18071@gondor.apana.org.au>
	<20080418032427.GE18071@gondor.apana.org.au>
	<200804190008.04357.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804190008.04357.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 19, 2008 at 12:08:04AM +1000, Rusty Russell wrote:
> On Friday 18 April 2008 13:24:27 Herbert Xu wrote:
> > Finally this patch lets virtio_net receive GSO packets in addition
> > to sending them.  This can definitely be optimised for the non-GSO
> > case.  For comparison the Xen approach stores one page in each skb
> > and uses subsequent skb's pages to construct an SG skb instead of
> > preallocating the maximum amount of pages per skb.
> 
> Well, this ends up freeing the unused pages immediately which is actually 
> quite nice.  We can cache them ourselves if we want, but we'd have to see if 
> the page allocation/free overhead is measurable...

I was thinking of the case of a large number of these interfaces
but yeah for one interface it's no biggie :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
