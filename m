From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/3] Virtio draft IV: the net driver
Date: Wed, 11 Jul 2007 13:46:07 +0200
Message-ID: <200707111346.07185.borntraeger@de.ibm.com>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<200707111228.30707.borntraeger@de.ibm.com>
	<1184153201.6005.618.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184153201.6005.618.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 11. Juli 2007 schrieb Rusty Russell:
> There will be some internal limit on how many buffers the virtio
> implementation supports, but depends on that implementation.  It could
> be a number of buffers or a total number of descriptors.

I would suggest to implement a limit in the device driver as well. Otherwise 
the network driver could allocate a huge amount of guest memory if the virtio
implementation accepts a large amount of buffers. This memory is not swappable 
and reclaimable by the memory management, so we should be careful. 

So what about something like this:

+       for (;vi->num < MAX_BUFS;) {
+               skb = netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
+               if (unlikely(!skb))
+                       break;
+
+               skb_put(skb, MAX_PACKET_LEN);
+               num = skb_to_sgvec(skb, sg, 0, skb->len);
+               skb_queue_head(&vi->recv, skb);
+
+               err = vi->vq_recv->ops->add_buf(vi->vq_recv, sg, 0, num, skb);
+               if (err) {
+                       skb_unlink(skb, &vi->recv);
+                       kfree_skb(skb);
+                       break;
+               }
+		vi->num++
+       }



Christian
