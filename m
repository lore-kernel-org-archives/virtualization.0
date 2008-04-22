From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [5/6] [VIRTIO] net: Add ethtool ops for SG/GSO
Date: Tue, 22 Apr 2008 12:44:47 +1000
Message-ID: <200804221244.47596.rusty@rustcorp.com.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<200804220501.46945.rusty@rustcorp.com.au>
	<20080422011502.GC14994@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080422011502.GC14994@gondor.apana.org.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 22 April 2008 11:15:02 Herbert Xu wrote:
> On Tue, Apr 22, 2008 at 05:01:46AM +1000, Rusty Russell wrote:
> > On Friday 18 April 2008 13:21:42 Herbert Xu wrote:
> > > +static int virtnet_change_mtu(struct net_device *dev, int mtu)
> > > +{
> > > +	int max = 65535 - ETH_HLEN;
> > > +
> > > +	if (mtu > max)
> > > +		return -EINVAL;
> > > +	dev->mtu = mtu;
> > > +	return 0;
> > > +}
> >
> > Hi Herbert!
> >
> >     I removed this part; useful for testing, but we need a feature bit
> > for MTU size in general.  And to change it on the fly either requires a
> > reset & re-init, or some protocol (and feature bit!) for renegotiating
> > MTU.
>
> BTW Rusty this was just a work-in-progress.  When I submit them I
> will add sign-offs.

OK.  Meanwhile I stole it for my own testing :)

> However, the MTU part should be fine as long as the other end supports
> SG.  The operative word in MTU is T :)

I hadn't really thought about it; you're right, MTU is merely a formality.  If 
the other end has big enough receive buffers, we might as well use them.

I still feel oddly nervous about surprising the other end tho...

Thanks,
Rusty.
