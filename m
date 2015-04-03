From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net-next] netdevice: document NETDEV_TX_BUSY deprecation.
Date: Fri, 03 Apr 2015 22:17:17 +1030
Message-ID: <87pp7l5t8a.fsf__38940.4590045617$1428061671$gmane$org@rustcorp.com.au>
References: <20150402125743-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150402125743-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This paraphrases DaveM (and steals some of his words) explaining why
a device shouldn't return NETDEV_TX_BUSY, even though it looks so inviting
to driver authors.

See http://www.spinics.net/lists/netdev/msg322350.html

Inspired-by: David Miller <davem@davemloft.net>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dcf6ec27739b..a2cad44b8630 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -795,7 +795,10 @@ typedef u16 (*select_queue_fallback_t)(struct net_device *dev,
  * netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb,
  *                               struct net_device *dev);
  *	Called when a packet needs to be transmitted.
- *	Must return NETDEV_TX_OK , NETDEV_TX_BUSY.
+ *	Returns NETDEV_TX_OK.  Can return NETDEV_TX_BUSY, but you should stop
+ *	the queue before that can happen; it's for obsolete devices and weird
+ *	corner cases, but the stack really does a non-trivial amount
+ *	of useless work if you return NETDEV_TX_BUSY.
  *        (can also return NETDEV_TX_LOCKED iff NETIF_F_LLTX)
  *	Required can not be NULL.
  *
