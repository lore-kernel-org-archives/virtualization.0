From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 09/14] virtio_net: fix TX capacity checks using new API
Date: Sat, 21 May 2011 11:43:19 +0930
Message-ID: <878vu0vm0w.fsf__28861.8234139451$1305945647$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<42ca2494c92f572388e3ab4c6f613dd4f038361b.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42ca2494c92f572388e3ab4c6f613dd4f038361b.1305846412.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 20 May 2011 02:11:47 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> virtio net uses the number of sg entries to
> check for TX ring capacity freed. But this
> gives incorrect results when indirect buffers
> are used. Use the new capacity API instead.

OK, but this explanation needs enhancement, such as noting the actual
results of that miscalculation.  Something like:

 virtio_net uses the number of sg entries in the skb it frees to
 calculate how many descriptors in the ring have just been made
 available.  But this value is an overestimate: with indirect buffers
 each skb only uses one descriptor entry, meaning we may wake the queue
 only to find we still can't transmit anything.

 Using the new virtqueue_get_capacity() call, we can exactly determine
 the remaining capacity, so we should use that instead.

But, here's the side effect:
>  			/* More just got used, free them then recheck. */
> -			capacity += free_old_xmit_skbs(vi);
> +			free_old_xmit_skbs(vi);
> +			capacity = virtqueue_get_capacity(vi->svq);
>  			if (capacity >= 2+MAX_SKB_FRAGS) {

That capacity >= 2+MAX_SKB_FRAGS is too much for indirect buffers.  This
means we waste 20 entries in the ring, but OTOH if we hit OOM we fall
back to direct buffers and we *will* need this.

Which means this comment in the driver is now wrong:

	/* This can happen with OOM and indirect buffers. */
	if (unlikely(capacity < 0)) {
		if (net_ratelimit()) {
			if (likely(capacity == -ENOMEM)) {
				dev_warn(&dev->dev,
					 "TX queue failure: out of memory\n");
			} else {
				dev->stats.tx_fifo_errors++;
				dev_warn(&dev->dev,
					 "Unexpected TX queue failure: %d\n",
					 capacity);
			}
		}
		dev->stats.tx_dropped++;
		kfree_skb(skb);
		return NETDEV_TX_OK;
	}
	virtqueue_kick(vi->svq);

So I'm not applying this patch (nor the virtqueue_get_capacity
predeccessor) for the moment.

Thanks,
Rusty.
