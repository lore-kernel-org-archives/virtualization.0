From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH resent] virtio_net: Fix stalled inbound
	trafficon early packets
Date: Tue, 18 Dec 2007 17:54:15 +1100
Message-ID: <200712181754.16632.rusty__10964.1679133803$1197961065$gmane$org@rustcorp.com.au>
References: <200712111242.28843.borntraeger@de.ibm.com>
	<47613277.3060403@qumranet.com>
	<200712131930.31602.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712131930.31602.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, dor.laor@qumranet.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 14 December 2007 05:30:31 Christian Borntraeger wrote:
> Rusty, if you decide to apply my patch, there is one downside: The
> debugging code in virtio_ring sometimes triggers with a false positive:
>
> try_fill_recv calls vring_kick. Here we do a notify to the host. This might
> cause an immediate interrupt, triggering the poll routine before vring_kick
> can run END_USE. This is no real problem, as we dont touch the vq after
> notify.

Hmm, how about we just do something like this?  (needs previous enable_cb
patch)

> Christian, facing 64 guest cpus unconvering all kind of races

Heroic is the word which comes to mind... :)

Cheers,
Rusty.
---
virtio: flush buffers on open

Fix bug found by Christian Borntraeger: if the other side fills all
the registered network buffers before we enable NAPI, we will never
get an interrupt.  The simplest fix is to process the input queue once
on open.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 1dd61213039c drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Tue Dec 18 17:34:18 2007 +1100
+++ b/drivers/net/virtio_net.c	Tue Dec 18 17:47:39 2007 +1100
@@ -326,6 +326,13 @@ static int virtnet_open(struct net_devic
 		return -ENOMEM;
 
 	napi_enable(&vi->napi);
+
+	/* If all buffers were filled by other side before we napi_enabled, we
+	 * won't get another interrupt, so process any outstanding packets
+	 * now.  virtnet_poll wants re-enable the queue, so we disable here. */
+	vi->rvq->vq_ops->disable_cb(vi->rvq);
+	netif_rx_schedule(vi->dev, &vi->napi);
+
 	return 0;
 }
