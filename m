From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 17/22] caif_virtio: use simplified virtqueue accessors.
Date: Mon, 18 Mar 2013 20:04:48 +1030
Message-ID: <1363599293-23065-18-git-send-email-rusty@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Sjur Brendeland <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

We never add buffers with input and output parts, so use the new accessors.

Cc: Sjur Brendeland <sjur.brandeland@stericsson.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/caif/caif_virtio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 8308dee..36d9af5 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -573,8 +573,7 @@ static int cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
 		goto err;
 	}
 
-	ret = virtqueue_add_buf(cfv->vq_tx, &sg, 1, 0,
-				buf_info, GFP_ATOMIC);
+	ret = virtqueue_add_outbuf(cfv->vq_tx, &sg, 1, buf_info, GFP_ATOMIC);
 	if (unlikely((ret < 0))) {
 		/* If flow control works, this shouldn't happen */
 		netdev_warn(cfv->ndev, "Failed adding buffer to TX vring:%d\n",
-- 
1.7.10.4
