From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH 3/6] virtio net driver
Date: Fri, 21 Sep 2007 14:36:43 +0200
Message-ID: <200709211436.43964.borntraeger__46086.5333713174$1190385885$gmane$org@de.ibm.com>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211248.11783.borntraeger@de.ibm.com>
	<1190375615.27805.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190375615.27805.9.camel@localhost.localdomain>
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
Cc: kvm-devel@lists.sourceforge.net, lguest <lguest@ozlabs.org>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag, 21. September 2007 schrieb Rusty Russell:
> Can't we just re-use the default xmit lock?

yes we can.

This patch is untested but is basically an refresh of an ealier version. I 
currently have no code testable with the latest virtio version from this mail 
thread, so if you could apply this (It still has the ndev name) and test the 
patch? Thanks

Christian
---

Use the sent interrupt for xmit reclaim.

---
 drivers/net/virtio_net.c |   43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

Index: virtio/drivers/net/virtio_net.c
===================================================================
--- virtio.orig/drivers/net/virtio_net.c
+++ virtio/drivers/net/virtio_net.c
@@ -52,10 +52,29 @@ static inline void vnet_hdr_to_sg(struct
 	sg_init_one(sg, skb_vnet_hdr(skb), sizeof(struct virtio_net_hdr));
 }
 
+static void free_old_xmit_skbs(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct sk_buff *skb;
+	unsigned int len;
+
+	netif_tx_lock(dev);
+	while ((skb = vi->vq_ops->get_buf(vi->vq_send, &len)) != NULL) {
+		pr_debug("Sent skb %p\n", skb);
+		__skb_unlink(skb, &vi->send);
+		dev->stats.tx_bytes += len;
+		dev->stats.tx_packets++;
+		dev_kfree_skb_irq(skb);
+	}
+	netif_tx_unlock(dev);
+}
+
 static bool skb_xmit_done(void *ndev)
 {
 	/* In case we were waiting for output buffers. */
 	netif_wake_queue(ndev);
+	/* reclaim sent skbs */
+	fre_old_xmit_skbs(ndev);
 	return true;
 }
 
@@ -209,20 +228,6 @@ again:
 	return 0;
 }
 
-static void free_old_xmit_skbs(struct virtnet_info *vi)
-{
-	struct sk_buff *skb;
-	unsigned int len;
-
-	while ((skb = vi->vq_ops->get_buf(vi->vq_send, &len)) != NULL) {
-		pr_debug("Sent skb %p\n", skb);
-		__skb_unlink(skb, &vi->send);
-		vi->ndev->stats.tx_bytes += len;
-		vi->ndev->stats.tx_packets++;
-		kfree_skb(skb);
-	}
-}
-
 static int start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -235,8 +240,6 @@ static int start_xmit(struct sk_buff *sk
 		 dev->name, skb,
 		 dest[0], dest[1], dest[2], dest[3], dest[4], dest[5]);
 
-	free_old_xmit_skbs(vi);
-
 	/* Encode metadata header at front. */
 	hdr = skb_vnet_hdr(skb);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -267,15 +270,21 @@ static int start_xmit(struct sk_buff *sk
 
 	vnet_hdr_to_sg(sg, skb);
 	num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
+	local_irq_disable();
+	netif_tx_lock(dev);
 	__skb_queue_head(&vi->send, skb);
 	err = vi->vq_ops->add_buf(vi->vq_send, sg, num, 0, skb);
 	if (err) {
 		pr_debug("%s: virtio not prepared to send\n", dev->name);
 		skb_unlink(skb, &vi->send);
 		netif_stop_queue(dev);
+		netif_tx_unlock(dev);
+		local_irq_enable();
 		return NETDEV_TX_BUSY;
 	}
 	vi->vq_ops->kick(vi->vq_send);
+	netif_tx_unlock(dev);
+	local_irq_enable();
 
 	return 0;
 }
@@ -335,7 +344,7 @@ static void *virtnet_probe(struct device
 	dev->poll = virtnet_poll;
 	dev->hard_start_xmit = start_xmit;
 	dev->weight = 16;
-	dev->features = NETIF_F_HIGHDMA;
+	dev->features = NETIF_F_HIGHDMA | NETIF_F_LLTX;
 	SET_NETDEV_DEV(dev, device);
 
 	/* Do we support "hardware" checksums? */
