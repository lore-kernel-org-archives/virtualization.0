From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/5] virtio net: Allow receiving SG packets
Date: Mon, 14 Jul 2008 22:41:38 -0500
Message-ID: <200807151341.39337.rusty__7657.62589076093$1216093681$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Herbert Xu <herbert@gondor.apana.org.au>

Finally this patch lets virtio_net receive GSO packets in addition
to sending them.  This can definitely be optimised for the non-GSO
case.  For comparison the Xen approach stores one page in each skb
and uses subsequent skb's pages to construct an SG skb instead of
preallocating the maximum amount of pages per skb.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (added feature bits)
---
 drivers/net/virtio_net.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -89,6 +89,7 @@ static void receive_skb(struct net_devic
 			unsigned len)
 {
 	struct virtio_net_hdr *hdr = skb_vnet_hdr(skb);
+	int err;
 
 	if (unlikely(len < sizeof(struct virtio_net_hdr) + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -96,10 +97,14 @@ static void receive_skb(struct net_devic
 		goto drop;
 	}
 	len -= sizeof(struct virtio_net_hdr);
-	BUG_ON(len > MAX_PACKET_LEN);
 
-	skb_trim(skb, len);
-
+	err = pskb_trim(skb, len);
+	if (err) {
+		pr_debug("%s: pskb_trim failed %i %d\n", dev->name, len, err);
+		dev->stats.rx_dropped++;
+		goto drop;
+	}
+	skb->truesize += skb->data_len;
 	dev->stats.rx_bytes += skb->len;
 	dev->stats.rx_packets++;
 
@@ -161,7 +166,7 @@ static void try_fill_recv(struct virtnet
 {
 	struct sk_buff *skb;
 	struct scatterlist sg[2+MAX_SKB_FRAGS];
-	int num, err;
+	int num, err, i;
 
 	sg_init_table(sg, 2+MAX_SKB_FRAGS);
 	for (;;) {
@@ -171,6 +176,24 @@ static void try_fill_recv(struct virtnet
 
 		skb_put(skb, MAX_PACKET_LEN);
 		vnet_hdr_to_sg(sg, skb);
+
+		if (vi->dev->features & NETIF_F_LRO) {
+			for (i = 0; i < MAX_SKB_FRAGS; i++) {
+				skb_frag_t *f = &skb_shinfo(skb)->frags[i];
+				f->page = alloc_page(GFP_ATOMIC);
+				if (!f->page)
+					break;
+
+				f->page_offset = 0;
+				f->size = PAGE_SIZE;
+
+				skb->data_len += PAGE_SIZE;
+				skb->len += PAGE_SIZE;
+
+				skb_shinfo(skb)->nr_frags++;
+			}
+		}
+
 		num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
 		skb_queue_head(&vi->recv, skb);
 
@@ -466,6 +489,12 @@ static int virtnet_probe(struct virtio_d
 			dev->features |= NETIF_F_UFO;
 	}
 
+	/* If we can receive ANY GSO packets, we must allocate large ones. */
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4)
+	    || virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6)
+	    || virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN))
+		dev->features |= NETIF_F_LRO;
+
 	/* Configuration may specify what MAC to use.  Otherwise random. */
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
 		vdev->config->get(vdev,
@@ -571,7 +600,9 @@ static unsigned int features[] = {
 	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GSO, VIRTIO_NET_F_MAC,
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6,
-	VIRTIO_NET_F_HOST_ECN, VIRTIO_F_NOTIFY_ON_EMPTY,
+	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
+	VIRTIO_NET_F_GUEST_ECN, /* We don't yet handle UFO input. */
+	VIRTIO_F_NOTIFY_ON_EMPTY,
 };
 
 static struct virtio_driver virtio_net = {
