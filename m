From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] xen/netfront: Avoid unaligned accesses to IP datagrams.
Date: Thu, 3 Jul 2008 16:06:28 +0900
Message-ID: <20080703070628.GA15683%yamahata__39498.5696454116$1215069563$gmane$org@valinux.co.jp>
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
To: jeremy@goop.org
Cc: xen-ia64-devel@lists.xensource.com, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Align ip header to a 16 byte boundary.
This patch eliminates noisy warnings on IA64.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 drivers/net/xen-netfront.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 44aed80..2724688 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -239,11 +239,14 @@ static void xennet_alloc_rx_buffers(struct net_device *dev)
 	 */
 	batch_target = np->rx_target - (req_prod - np->rx.rsp_cons);
 	for (i = skb_queue_len(&np->rx_batch); i < batch_target; i++) {
-		skb = __netdev_alloc_skb(dev, RX_COPY_THRESHOLD,
+		skb = __netdev_alloc_skb(dev, RX_COPY_THRESHOLD + NET_IP_ALIGN,
 					 GFP_ATOMIC | __GFP_NOWARN);
 		if (unlikely(!skb))
 			goto no_skb;
 
+		/* Align ip header to a 16 bytes boundary */
+		skb_reserve(skb, NET_IP_ALIGN);
+
 		page = alloc_page(GFP_ATOMIC | __GFP_NOWARN);
 		if (!page) {
 			kfree_skb(skb);
-- 
1.5.3


-- 
yamahata
