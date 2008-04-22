From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [5/6] [VIRTIO] net: Add ethtool ops for SG/GSO
Date: Tue, 22 Apr 2008 09:15:02 +0800
Message-ID: <20080422011502.GC14994@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031939.GC18071@gondor.apana.org.au>
	<20080418032142.GD18071@gondor.apana.org.au>
	<200804220501.46945.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804220501.46945.rusty@rustcorp.com.au>
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

On Tue, Apr 22, 2008 at 05:01:46AM +1000, Rusty Russell wrote:
> On Friday 18 April 2008 13:21:42 Herbert Xu wrote:
> > +static int virtnet_change_mtu(struct net_device *dev, int mtu)
> > +{
> > +	int max = 65535 - ETH_HLEN;
> > +
> > +	if (mtu > max)
> > +		return -EINVAL;
> > +	dev->mtu = mtu;
> > +	return 0;
> > +}
> 
> Hi Herbert!
> 
>     I removed this part; useful for testing, but we need a feature bit for MTU 
> size in general.  And to change it on the fly either requires a reset & 
> re-init, or some protocol (and feature bit!) for renegotiating MTU.

BTW Rusty this was just a work-in-progress.  When I submit them I
will add sign-offs.

However, the MTU part should be fine as long as the other end supports
SG.  The operative word in MTU is T :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
