From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] tun: Allow GSO using virtio_net_hdr
Date: Wed, 2 Jul 2008 17:00:35 +1000
Message-ID: <200807021700.36130.rusty__40452.2444973283$1214982257$gmane$org@rustcorp.com.au>
References: <200806260028.07883.rusty@rustcorp.com.au>
	<200806260030.38293.rusty@rustcorp.com.au>
	<486B0E97.3040303@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <486B0E97.3040303@qualcomm.com>
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
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: markmc@redhat.com, netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 02 July 2008 15:13:59 Max Krasnyansky wrote:
> Rusty Russell wrote:
> > Add a IFF_VNET_HDR flag.  This uses the same ABI as virtio_net (ie.
> > prepending struct virtio_net_hdr to packets) to indicate GSO and checksum
> > information.
> >
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > ---
> >  drivers/net/tun.c      |   90
> > ++++++++++++++++++++++++++++++++++++++++++++++++- include/linux/if_tun.h
> > |    2 +
> >  2 files changed, 91 insertions(+), 1 deletion(-)
> >
> > diff -r d94590c1550a drivers/net/tun.c
> > --- a/drivers/net/tun.c	Thu Jun 26 00:21:11 2008 +1000
> > +++ b/drivers/net/tun.c	Thu Jun 26 00:21:59 2008 +1000
> > @@ -63,6 +63,7 @@
> >  #include <linux/if_tun.h>
> >  #include <linux/crc32.h>
> >  #include <linux/nsproxy.h>
> > +#include <linux/virtio_net.h>
> >  #include <net/net_namespace.h>
> >  #include <net/netns/generic.h>
> >
> > @@ -283,12 +284,24 @@ static __inline__ ssize_t tun_get_user(s
> >  	struct tun_pi pi = { 0, __constant_htons(ETH_P_IP) };
> >  	struct sk_buff *skb;
> >  	size_t len = count, align = 0;
> > +	struct virtio_net_hdr gso = { 0 };
> >
> >  	if (!(tun->flags & TUN_NO_PI)) {
> >  		if ((len -= sizeof(pi)) > count)
> >  			return -EINVAL;
> >
> >  		if(memcpy_fromiovec((void *)&pi, iv, sizeof(pi)))
> > +			return -EFAULT;
> > +	}
> > +
> > +	if (tun->flags & TUN_VNET_HDR) {
> > +		if ((len -= sizeof(gso)) > count)
> > +			return -EINVAL;
> > +
> > +		if (gso.hdr_len > len)
> > +			return -EINVAL;
> > +
> > +		if (memcpy_fromiovec((void *)&gso, iv, sizeof(gso)))
> >  			return -EFAULT;
> >  	}
>
> Unless I'm missing something the 'if (gso.hdr_len > len)' must be after
> memcpy_fromiovec().

Yes, this was fixed in a followup... there was another bug picked up by markmc 
too in this patch.

> > +		case VIRTIO_NET_HDR_GSO_TCPV6:
> > +			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
> > +			break;
> > +		default:
> > +			tun->dev->stats.rx_dropped++;
> > +			kfree_skb(skb);
> > +			return -EINVAL;
> > +		}
>
> We should use stats.rx_frame_errors instead of stats.rx_dropped to
> indicated that we dropped it because something was wrong with the framing
> (headers, etc). Applies to both of the cases above.

OK, done (all three).  Will repost.

Thanks,
Rusty.
