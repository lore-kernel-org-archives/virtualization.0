From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
Date: Wed, 18 Apr 2018 13:49:54 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1804181345590.17942__39061.3336734988$1524073695$gmane$org@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
	<3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
	<alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
	<5f4e1286-b79f-0b9f-9a30-47d7654f3889@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5f4e1286-b79f-0b9f-9a30-47d7654f3889@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ben Hutchings <bhutchings@solarflare.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org



On Wed, 18 Apr 2018, Eric Dumazet wrote:

> 
> 
> On 04/18/2018 09:44 AM, Mikulas Patocka wrote:
> > 
> > 
> > On Wed, 18 Apr 2018, Eric Dumazet wrote:
> > 
> >>
> >>
> >> On 04/18/2018 07:34 AM, Mikulas Patocka wrote:
> >>> The patch 74d332c13b21 changes alloc_netdev_mqs to use vzalloc if kzalloc
> >>> fails (later patches change it to kvzalloc).
> >>>
> >>> The problem with this is that if the vzalloc function is actually used, 
> >>> virtio_net doesn't work (because it expects that the extra memory should 
> >>> be accessible with DMA-API and memory allocated with vzalloc isn't).
> >>>
> >>> This patch changes it back to kzalloc and adds a warning if the allocated
> >>> size is too large (the allocation is unreliable in this case).
> >>>
> >>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >>> Fixes: 74d332c13b21 ("net: extend net_device allocation to vmalloc()")
> >>>
> >>> ---
> >>>  net/core/dev.c |    3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> Index: linux-2.6/net/core/dev.c
> >>> ===================================================================
> >>> --- linux-2.6.orig/net/core/dev.c	2018-04-16 21:08:36.000000000 +0200
> >>> +++ linux-2.6/net/core/dev.c	2018-04-18 16:24:43.000000000 +0200
> >>> @@ -8366,7 +8366,8 @@ struct net_device *alloc_netdev_mqs(int
> >>>  	/* ensure 32-byte alignment of whole construct */
> >>>  	alloc_size += NETDEV_ALIGN - 1;
> >>>  
> >>> -	p = kvzalloc(alloc_size, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> >>> +	WARN_ON(alloc_size > PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
> >>> +	p = kzalloc(alloc_size, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> >>>  	if (!p)
> >>>  		return NULL;
> >>>  
> >>>
> >>
> >> Since when a net_device needs to be in DMA zone ???
> >>
> >> I would rather fix virtio_net, this looks very suspect to me.
> >>
> >> Each virtio_net should probably allocate the exact amount of DMA-memory it wants,
> >> instead of expecting core networking stack to have a huge chunk of DMA-memory for everything.
> > 
> > The structure net_device is followed by arbitrary driver-specific data 
> > (accessible with the function netdev_priv). And for virtio-net, these 
> > driver-specific data must be in DMA memory.
> 
> I get that, but how is the original xenvif problem will be solved ?
> 
> Your patch would add a bug in some other driver(s)
> 
> I suggest that virtio_net clearly identifies which part needs a specific allocation
> and does its itself, instead of abusing the netdev_priv storage.
> 
> Ie use a pointer to a block of memory, allocated by virtio_net, for virtio_net.

There are drivers that need to do DMA to driver-specific area.
And there are drivers that need driver-specific area larger than kmalloc 
limit.

These are conflicting requirements and one of those drivers must be 
changed.

I suggest to change the drivers that need large driver-specific area. 
That's why I added the WARN_ON, so that they can be identified.

Mikulas
