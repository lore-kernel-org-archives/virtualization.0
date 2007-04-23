From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private data
Date: Mon, 23 Apr 2007 14:57:00 -0700
Message-ID: <20070423215713.550883195@goop.org>
References: <20070423215638.563901986@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=xen-netfront-use-cb.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Netfront's use of nh.raw and h.raw for storing page+offset is a bit
hinky, and it breaks with upcoming network stack updates which reduce
these fields to sub-pointer sizes.  Fortunately, skb offers the "cb"
field specifically for stashing this kind of info, so use it.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>

---
 drivers/net/xen-netfront.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

===================================================================
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -52,6 +52,13 @@
 #include <xen/page.h>
 #include <xen/grant_table.h>
 
+struct netfront_cb {
+	struct page *page;
+	unsigned offset;
+};
+
+#define NETFRONT_SKB_CB(skb)	((struct netfront_cb *)((skb)->cb))
+
 /*
  * Mutually-exclusive module options to select receive data path:
  *  rx_copy : Packets are copied by network backend into local memory
@@ -944,10 +951,11 @@ static void handle_incoming_queue(struct
 	struct sk_buff *skb;
 
 	while ((skb = __skb_dequeue(rxq)) != NULL) {
-		struct page *page = (struct page *)skb->nh.raw;
+		struct page *page = NETFRONT_SKB_CB(skb)->page;
 		void *vaddr = page_address(page);
-
-		memcpy(skb->data, vaddr + (skb->h.raw - skb->nh.raw),
+		unsigned offset = NETFRONT_SKB_CB(skb)->offset;
+
+		memcpy(skb->data, vaddr + offset,
 		       skb_headlen(skb));
 
 		if (page != skb_shinfo(skb)->frags[0].page)
@@ -1251,8 +1259,8 @@ err:
 			}
 		}
 
-		skb->nh.raw = (void *)skb_shinfo(skb)->frags[0].page;
-		skb->h.raw = skb->nh.raw + rx->offset;
+		NETFRONT_SKB_CB(skb)->page = skb_shinfo(skb)->frags[0].page;
+		NETFRONT_SKB_CB(skb)->offset = rx->offset;
 
 		len = rx->status;
 		if (len > RX_COPY_THRESHOLD)

-- 
