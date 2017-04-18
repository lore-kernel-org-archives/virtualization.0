From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v2 5/5] virtio-net: keep tx interrupts disabled
	unless kick
Date: Tue, 18 Apr 2017 16:21:08 -0400
Message-ID: <20170418202108.61920-6-willemdebruijn.kernel__14287.5849771828$1493077053$gmane$org@gmail.com>
References: <20170418202108.61920-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170418202108.61920-1-willemdebruijn.kernel@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, virtualization@lists.linux-foundation.org, davem@davemloft.net, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Willem de Bruijn <willemb@google.com>

Tx napi mode increases the rate of transmit interrupts. Suppress some
by masking interrupts while more packets are expected. The interrupts
will be reenabled before the last packet is sent.

This optimization reduces the througput drop with tx napi for
unidirectional flows such as UDP_STREAM that do not benefit from
cleaning tx completions in the the receive napi handler.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b14c82ce0032..b107ae011632 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1196,8 +1196,14 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool use_napi = sq->napi.weight;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	if (!use_napi)
+	if (use_napi) {
+		if (kick)
+			virtqueue_enable_cb_delayed(sq->vq);
+		else
+			virtqueue_disable_cb(sq->vq);
+	} else {
 		free_old_xmit_skbs(sq);
+	}
 
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
-- 
2.12.2.816.g2cccc81164-goog
