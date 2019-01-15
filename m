From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next] virtio_net: bulk free tx skbs
Date: Mon, 14 Jan 2019 20:34:26 -0500
Message-ID: <20190115012847.14730-1-mst__45080.0437051386$1547691854$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use napi_consume_skb() to get bulk free.  Note that napi_consume_skb is
safe to call in a non-napi context as long as the napi_budget flag is
correct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

My perf testing setup is down but it works fine on my devel box and
should be fairly uncontroversial.

 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 023725086046..d76dcc68cbb6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1343,7 +1343,7 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 		bytes += skb->len;
 		packets++;
 
-		dev_consume_skb_any(skb);
+		napi_consume_skb(skb, use_napi);
 	}
 
 	/* Avoid overhead when no packets have been processed
-- 
MST
