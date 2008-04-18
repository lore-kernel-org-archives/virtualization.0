From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [6/6] [VIRTIO] net: Allow receiving SG packets
Date: Fri, 18 Apr 2008 11:24:27 +0800
Message-ID: <20080418032427.GE18071@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031444.GA18041@gondor.apana.org.au>
	<20080418031554.GA18071@gondor.apana.org.au>
	<20080418031722.GB18071@gondor.apana.org.au>
	<20080418031939.GC18071@gondor.apana.org.au>
	<20080418032142.GD18071@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080418032142.GD18071@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Finally this patch lets virtio_net receive GSO packets in addition
to sending them.  This can definitely be optimised for the non-GSO
case.  For comparison the Xen approach stores one page in each skb
and uses subsequent skb's pages to construct an SG skb instead of
preallocating the maximum amount of pages per skb.

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b58472c..bc49057 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -73,6 +73,7 @@ static void receive_skb(struct net_device *dev, struct sk_buff *skb,
 			unsigned len)
 {
 	struct virtio_net_hdr *hdr = skb_vnet_hdr(skb);
+	int err;
 
 	if (unlikely(len < sizeof(struct virtio_net_hdr) + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -80,9 +81,15 @@ static void receive_skb(struct net_device *dev, struct sk_buff *skb,
 		goto drop;
 	}
 	len -= sizeof(struct virtio_net_hdr);
-	BUG_ON(len > MAX_PACKET_LEN);
 
-	skb_trim(skb, len);
+	err = pskb_trim(skb, len);
+	if (err) {
+		pr_debug("%s: pskb_trim failed %i %d\n", dev->name, len, err);
+		dev->stats.rx_dropped++;
+		goto drop;
+	}
+	skb->truesize += skb->data_len;
+
 	skb->protocol = eth_type_trans(skb, dev);
 	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
 		 ntohs(skb->protocol), skb->len, skb->pkt_type);
@@ -142,10 +149,11 @@ drop:
 static void try_fill_recv(struct virtnet_info *vi)
 {
 	struct sk_buff *skb;
-	struct scatterlist sg[1+MAX_SKB_FRAGS];
+	struct scatterlist sg[2+MAX_SKB_FRAGS];
 	int num, err;
+	int i;
 
-	sg_init_table(sg, 1+MAX_SKB_FRAGS);
+	sg_init_table(sg, 2+MAX_SKB_FRAGS);
 	for (;;) {
 		skb = netdev_alloc_skb(vi->dev, MAX_PACKET_LEN);
 		if (unlikely(!skb))
@@ -153,6 +161,21 @@ static void try_fill_recv(struct virtnet_info *vi)
 
 		skb_put(skb, MAX_PACKET_LEN);
 		vnet_hdr_to_sg(sg, skb);
+
+		for (i = 0; i < MAX_SKB_FRAGS; i++) {
+			skb_shinfo(skb)->frags[i].page = alloc_page(GFP_ATOMIC);
+			if (!skb_shinfo(skb)->frags[i].page)
+				break;
+
+			skb_shinfo(skb)->frags[i].page_offset = 0;
+			skb_shinfo(skb)->frags[i].size = PAGE_SIZE;
+
+			skb->data_len += PAGE_SIZE;
+			skb->len += PAGE_SIZE;
+
+			skb_shinfo(skb)->nr_frags++;
+		}
+
 		num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
 		skb_queue_head(&vi->recv, skb);
 
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
