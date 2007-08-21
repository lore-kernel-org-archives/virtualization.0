From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: bug in virtio network driver?
Date: Tue, 21 Aug 2007 18:02:04 +0200
Message-ID: <200708211802.04103.borntraeger__45834.5031984665$1187712282$gmane$org@de.ibm.com>
References: <200708211048.33534.borntraeger@de.ibm.com>
	<1187687377.19435.176.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187687377.19435.176.camel@localhost.localdomain>
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
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel@lists.sourceforge.net
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 21. August 2007 schrieb Rusty Russell:
> The only reason that we don't do it in skb_xmit_done() is because
> kfree_skb() isn't supposed to be called from an interrupt.  But there's
> dev_kfree_skb_any() which can be used.

Ok, I now hacked something that works but I really dont like the 
local_irq_disable bits. I sent this patch nevertheless, but I will look into 
Arnds suggestion.

--- linux-2.6.22.orig/drivers/net/virtio_net.c
+++ linux-2.6.22/drivers/net/virtio_net.c
@@ -53,12 +52,31 @@ static void vnet_hdr_to_sg(struct scatte
 	sg->length = sizeof(struct virtio_net_hdr);
 }
 
+static void free_old_xmit_skbs(struct virtnet_info *vi)
+{
+	struct sk_buff *skb;
+	unsigned int len;
+
+	netif_tx_lock(vi->ndev);
+	while ((skb = vi->vq_send->ops->get_buf(vi->vq_send, &len)) != NULL) {
+		/* They cannot have written to the packet. */
+		BUG_ON(len != 0);
+		pr_debug("Sent skb %p\n", skb);
+		__skb_unlink(skb, &vi->send);
+		vi->ndev->stats.tx_bytes += skb->len;
+		vi->ndev->stats.tx_packets++;
+		dev_kfree_skb_irq(skb);
+	}
+	netif_tx_unlock(vi->ndev);
+}
+
 static bool skb_xmit_done(struct virtqueue *vq)
 {
 	struct virtnet_info *vi = vq->priv;
 
 	/* In case we were waiting for output buffers. */
 	netif_wake_queue(vi->ndev);
+	free_old_xmit_skbs(vi);
 	return true;
 }
 
@@ -214,22 +232,6 @@ again:
 	return 0;
 }
 
-static void free_old_xmit_skbs(struct virtnet_info *vi)
-{
-	struct sk_buff *skb;
-	unsigned int len;
-
-	while ((skb = vi->vq_send->ops->get_buf(vi->vq_send, &len)) != NULL) {
-		/* They cannot have written to the packet. */
-		BUG_ON(len != 0);
-		pr_debug("Sent skb %p\n", skb);
-		__skb_unlink(skb, &vi->send);
-		vi->ndev->stats.tx_bytes += skb->len;
-		vi->ndev->stats.tx_packets++;
-		kfree_skb(skb);
-	}
-}
-
 static int start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -238,12 +240,12 @@ static int start_xmit(struct sk_buff *sk
 	struct virtio_net_hdr *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 
+	local_irq_disable();
+	netif_tx_lock(vi->ndev);
 	pr_debug("%s: xmit %p %02x:%02x:%02x:%02x:%02x:%02x\n",
 		 dev->name, skb,
 		 dest[0], dest[1], dest[2], dest[3], dest[4], dest[5]);
 
-	free_old_xmit_skbs(vi);
-
 	/* Encode metadata header at front. */
 	hdr = skb_vnet_hdr(skb);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -280,10 +282,13 @@ static int start_xmit(struct sk_buff *sk
 		pr_debug("%s: virtio not prepared to send\n", dev->name);
 		skb_unlink(skb, &vi->send);
 		netif_stop_queue(dev);
+		netif_tx_unlock(vi->ndev);
+		local_irq_enable();
 		return NETDEV_TX_BUSY;
 	}
 	vi->vq_send->ops->sync(vi->vq_send);
-
+	netif_tx_unlock(vi->ndev);
+	local_irq_enable();
 	return 0;
 }
 
@@ -343,7 +348,7 @@ struct net_device *virtnet_probe(struct 
 	dev->poll = virtnet_poll;
 	dev->hard_start_xmit = start_xmit;
 	dev->weight = 16;
-	dev->features = features;
+	dev->features = features | NETIF_F_LLTX;
 	SET_NETDEV_DEV(dev, device);
 
 	vi = netdev_priv(dev);
