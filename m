From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/6] virtio: fix scatterlist sizing in net driver.
Date: Wed, 23 Apr 2008 23:56:47 -0500
Message-ID: <200804241456.47476.rusty__19950.3369200558$1209013679$gmane$org@rustcorp.com.au>
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
To: linux-kernel@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Herbert Xu points out (within another patch) that my scatterlists are
too short: one entry for the gso header, one for the skb->data, and
MAX_SKB_FRAGS for all the fragments.

Fix both xmit and recv sides (recv currently unused, coming in later
patch).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -r 86488a1161d2 drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Tue Apr 22 07:59:24 2008 +1000
+++ b/drivers/net/virtio_net.c	Tue Apr 22 12:56:20 2008 +1000
@@ -142,10 +142,10 @@ static void try_fill_recv(struct virtnet
 static void try_fill_recv(struct virtnet_info *vi)
 {
 	struct sk_buff *skb;
-	struct scatterlist sg[1+MAX_SKB_FRAGS];
+	struct scatterlist sg[2+MAX_SKB_FRAGS];
 	int num, err;
 
-	sg_init_table(sg, 1+MAX_SKB_FRAGS);
+	sg_init_table(sg, 2+MAX_SKB_FRAGS);
 	for (;;) {
 		skb = netdev_alloc_skb(vi->dev, MAX_PACKET_LEN);
 		if (unlikely(!skb))
@@ -231,11 +231,11 @@ static int start_xmit(struct sk_buff *sk
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	int num, err;
-	struct scatterlist sg[1+MAX_SKB_FRAGS];
+	struct scatterlist sg[2+MAX_SKB_FRAGS];
 	struct virtio_net_hdr *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 
-	sg_init_table(sg, 1+MAX_SKB_FRAGS);
+	sg_init_table(sg, 2+MAX_SKB_FRAGS);
 
 	pr_debug("%s: xmit %p " MAC_FMT "\n", dev->name, skb,
 		 dest[0], dest[1], dest[2],
