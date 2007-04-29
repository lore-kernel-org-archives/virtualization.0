From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 30/32] xen: diddle netfront
Date: Sun, 29 Apr 2007 10:29:05 -0700
Message-ID: <20070429172916.655120000@goop.org>
References: <20070429172835.284784000@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754372AbXD2Ref@vger.kernel.org>
Content-Disposition: inline; filename=xen-netfront-diddle.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Move things around a bit to match xen-unstable netfront.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 drivers/net/xen-netfront.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

===================================================================
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -750,19 +750,6 @@ no_skb:
 		notify_remote_via_irq(np->irq);
 }
 
-static void xennet_move_rx_slot(struct netfront_info *np, struct sk_buff *skb,
-				grant_ref_t ref)
-{
-	int new = xennet_rxidx(np->rx.req_prod_pvt);
-
-	BUG_ON(np->rx_skbs[new]);
-	np->rx_skbs[new] = skb;
-	np->grant_rx_ref[new] = ref;
-	RING_GET_REQUEST(&np->rx, np->rx.req_prod_pvt)->id = new;
-	RING_GET_REQUEST(&np->rx, np->rx.req_prod_pvt)->gref = ref;
-	np->rx.req_prod_pvt++;
-}
-
 static void xennet_make_frags(struct sk_buff *skb, struct net_device *dev,
 			      struct netif_tx_request *tx)
 {
@@ -944,6 +931,19 @@ static irqreturn_t netif_int(int irq, vo
 	spin_unlock_irqrestore(&np->tx_lock, flags);
 
 	return IRQ_HANDLED;
+}
+
+static void xennet_move_rx_slot(struct netfront_info *np, struct sk_buff *skb,
+				grant_ref_t ref)
+{
+	int new = xennet_rxidx(np->rx.req_prod_pvt);
+
+	BUG_ON(np->rx_skbs[new]);
+	np->rx_skbs[new] = skb;
+	np->grant_rx_ref[new] = ref;
+	RING_GET_REQUEST(&np->rx, np->rx.req_prod_pvt)->id = new;
+	RING_GET_REQUEST(&np->rx, np->rx.req_prod_pvt)->gref = ref;
+	np->rx.req_prod_pvt++;
 }
 
 static void handle_incoming_queue(struct net_device *dev, struct sk_buff_head *rxq)
@@ -1169,7 +1169,8 @@ static RING_IDX xennet_fill_frags(struct
 	return cons;
 }
 
-static int xennet_set_skb_gso(struct sk_buff *skb, struct netif_extra_info *gso)
+static int xennet_set_skb_gso(struct sk_buff *skb,
+			      struct netif_extra_info *gso)
 {
 	if (!gso->u.gso.size) {
 		if (net_ratelimit())
@@ -1456,11 +1457,8 @@ static void netif_release_rx_bufs(struct
 
 		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
 			/* Do all the remapping work and M2P updates. */
-			mcl->op = __HYPERVISOR_mmu_update;
-			mcl->args[0] = (unsigned long)np->rx_mmu;
-			mcl->args[1] = mmu - np->rx_mmu;
-			mcl->args[2] = 0;
-			mcl->args[3] = DOMID_SELF;
+			MULTI_mmu_update(mcl, np->rx_mmu, mmu - np->rx_mmu,
+					 0, DOMID_SELF);
 			mcl++;
 			HYPERVISOR_multicall(np->rx_mcl, mcl - np->rx_mcl);
 		}

-- 
