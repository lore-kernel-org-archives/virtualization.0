From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH for-2.6.35] virtio_net: fix oom handling on tx
Date: Thu, 10 Jun 2010 10:46:53 -0700
Message-ID: <20100610104653.1aed2ecc__6797.40640703148$1276192088$gmane$org@nehalam>
References: <20100610152041.GA3480@redhat.com>
	<1276190227.22064.19.camel@w-sridhar.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1276190227.22064.19.camel@w-sridhar.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Shirley Ma <xma@us.ibm.com>, Jiri Pirko <jpirko@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 Jun 2010 10:17:07 -0700
Sridhar Samudrala <sri@us.ibm.com> wrote:

> On Thu, 2010-06-10 at 18:20 +0300, Michael S. Tsirkin wrote:
> > virtio net will never try to overflow the TX ring, so the only reason
> > add_buf may fail is out of memory. Thus, we can not stop the
> > device until some request completes - there's no guarantee anything
> > at all is outstanding.
> > 
> > Make the error message clearer as well: error here does not
> > indicate queue full.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c |   15 ++++++++-------
> >  1 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 85615a3..e48a06f 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -563,7 +563,6 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	struct virtnet_info *vi = netdev_priv(dev);
> >  	int capacity;
> > 
> > -again:
> >  	/* Free up any pending old buffers before queueing new ones. */
> >  	free_old_xmit_skbs(vi);
> > 
> > @@ -572,12 +571,14 @@ again:
> > 
> >  	/* This can happen with OOM and indirect buffers. */
> >  	if (unlikely(capacity < 0)) {
> > -		netif_stop_queue(dev);
> > -		dev_warn(&dev->dev, "Unexpected full queue\n");
> > -		if (unlikely(!virtqueue_enable_cb(vi->svq))) {
> > -			virtqueue_disable_cb(vi->svq);
> > -			netif_start_queue(dev);
> > -			goto again;
> > +		if (net_ratelimit()) {
> > +			if (likely(capacity == -ENOMEM))
> > +				dev_warn(&dev->dev,
> > +					 "TX queue failure: out of memory\n");
> > +			else
> > +				dev_warn(&dev->dev,
> > +					 "Unexpected TX queue failure: %d\n",
> > +					 capacity);
> >  		}
> >  		return NETDEV_TX_BUSY;
> >  	}
> 
> It is not clear to me how xmit_skb() can return -ENOMEM.
> xmit_skb() calls virtqueue_add_buf_gfp() which can return -ENOSPC.
> Even vring_add_indirect() doesn't return -ENOMEM on kmalloc failure.

It makes more sense to have the device increment tx_droppped, 
and return NETDEV_TX_OK. Skip the message (or make it a pr_debug()). 
Network devices do not guarantee packet delivery, and if out of
resources then holding more data in the
queue is going to hurt not help the situation.

-- 
