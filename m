From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 2/2] virtio_net: bulk free tx skbs
Date: Wed, 5 Dec 2018 17:54:24 -0500
Message-ID: <20181205225323.12555-3-mst__45531.4067811289$1544050369$gmane$org@redhat.com>
References: <20181205225323.12555-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181205225323.12555-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Use napi_consume_skb() to get bulk free.  Note that napi_consume_skb is
safe to call in a non-napi context as long as the napi_budget flag is
correct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b657bde6b94b..18c06322be40 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1339,7 +1339,7 @@ static void free_old_xmit_skbs(struct send_queue *sq, struct netdev_queue *txq,
 		bytes += skb->len;
 		packets++;
 
-		dev_consume_skb_any(skb);
+		napi_consume_skb(skb, use_napi);
 	}
 
 	/* Avoid overhead when no packets have been processed
-- 
MST
