From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-ppc-devel] virtio network traffic issues
Date: Wed, 26 Mar 2008 19:03:03 +0200
Message-ID: <1206550984.26326.51.camel@localhost.localdomain>
References: <47E9020B.3080705@linux.vnet.ibm.com>
	<1206453127.1022.1.camel@basalt> <47EA74C8.7090103@linux.vnet.ibm.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47EA74C8.7090103@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 2008-03-26 at 17:07 +0100, Christian Ehrhardt wrote:
> Hollis Blanchard wrote:
> > On Tue, 2008-03-25 at 14:45 +0100, Christian Ehrhardt wrote:
> >> => from one not yet defined point our guest seems to receive absolutely nothing
> >> => when the guest is hanging it sends nfs requests which are seen externally, but it does not seem to get the respones
> >> => the arp requests for the guest are repeated - maybe we can add some very verbose debug in the guest virtio code and activate it when we see that it is already hanging
> >> => ideas:
> >>   - maybe some buffer/memory runs out and so incoming packets won't be received anymore 
> >>   - we break something in virtio / incoming interrupts (or maybe a lock) and from that point no receive is possible
> >>
> > Could we be missing interrupts? Can you add a guest kernel timer that
> > calls virtio_poll() regularly?
> 
> 
> Working but not the final solution.
> Preliminary workaround patch attached
> 
> Atm I think we might disable interrupts and polling at the same time.

For disabled interrupts you mean that the VRING_AVAIL_F_NO_INTERRUPT
flag is set or really your s390 replacement to cli?

If it's just the flag you can ignore it in the host (virtio-net.c).


btw: I didn't see any VRING_USED_F_NO_NOTIFY on the guest side.
It is only for optimizations so just put it on your todo list.

> 
> Good message: it was slow, but I saw a login prompt ;-)
> here a guest "cat /proc/cpuinfo"
> cat /proc/cpuinfo
> processor       : 0
> cpu             : unknown (00000000)
> clock           : 666.666660MHz
> revision        : 0.0 (pvr 0000 0000)
> bogomips        : 2490.36
> timebase        : 666666660
> platform        : Bamboo
> 
> That means once we found the reason for that staving virto-net device we should have a basic working linux guest.
> 
> P.S. added virtualization@lists.linux-foundation.org (this time) to get any virtio-net related suggestions from there too
> 
> plain text document attachment (virtio-net-poll-on-timer)
> Subject: [PATCH] kvmppc virtio-net: workaround for lost interrupt/polling
> 
> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> 
> This patch is (atm) just a debug workaround. The issue is that virtio-net
> works fine for a while but then "something" happens and we see neither
> vp_interrupts nor calls to virtnet_poll anymore.
> Looking at the network traffic shows that the kvm guest still sends packets
> via virtio-net and that userspace tries to deliver things to the guest, but
> the guest receives nothing.
> Somehow it loks loke polling and interrupts are disables (more debugging
> needed).
> For now anyone can continue with that workaround patch (which is
> very slow, I had no time to tune the polling interval yet).
> There's an ugly fixme, but I don't yet know what exactly causes this BUG()
> to trigger so thats the way to get it out for now.
> I'll update the patch once I have an improved version.
> 
> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> ---
> 
> [diffstat]
>  virtio_net.c |   36 ++++++++++++++++++++++++++++++------
>  1 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -194,17 +194,22 @@ again:
>  		received++;
>  	}
>  
> +
>  	/* FIXME: If we oom and completely run out of inbufs, we need
>  	 * to start a timer trying to fill more. */
>  	if (vi->num < vi->max / 2)
>  		try_fill_recv(vi);
>  
> -	/* Out of packets? */
> -	if (received < budget) {
> -		netif_rx_complete(vi->dev, napi);
> -		if (unlikely(!vi->rvq->vq_ops->enable_cb(vi->rvq))
> -		    && netif_rx_reschedule(vi->dev, napi))
> -			goto again;
> +	/* FIXME - fails when called by workaround timer polling (sometimes) */
> +	if (budget != 42)
> +	{
> +		/* Out of packets? */
> +		if (received < budget) {
> +				netif_rx_complete(vi->dev, napi);
> +			if (unlikely(!vi->rvq->vq_ops->enable_cb(vi->rvq))
> +			    && netif_rx_reschedule(vi->dev, napi))
> +				goto again;
> +		}
>  	}
>  
>  	return received;
> @@ -294,6 +299,17 @@ again:
>  	return 0;
>  }
>  
> +static struct timer_list viopoll_timer;
> +static void virtio_poll_wrap(unsigned long dev)
> +{
> +        struct virtnet_info *vi = netdev_priv((struct net_device *)dev);
> +	/* poll more often if polling received something */
> +	if (virtnet_poll(&vi->napi, 42))
> +		mod_timer(&viopoll_timer, get_jiffies_64() + (HZ/150));
> +	else
> +		mod_timer(&viopoll_timer, get_jiffies_64() + (HZ/25));
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -308,12 +324,20 @@ static int virtnet_open(struct net_devic
>  		vi->rvq->vq_ops->disable_cb(vi->rvq);
>  		__netif_rx_schedule(dev, &vi->napi);
>  	}
> +
> +	// DEBUG (Missing interrupts ?)
> +	setup_timer(&viopoll_timer, virtio_poll_wrap, (unsigned long)(dev));
> +	mod_timer(&viopoll_timer, get_jiffies_64() + HZ);
> +	printk("%s - set up virtnet_poll timer\n", __func__);
> +
>  	return 0;
>  }
>  
>  static int virtnet_close(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +
> +        del_timer(&viopoll_timer);
>  
>  	napi_disable(&vi->napi);
>  
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
