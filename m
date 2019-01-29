From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net 1/7] virtio_net: Don't enable NAPI when interface is
	down
Date: Tue, 29 Jan 2019 09:45:53 +0900
Message-ID: <1548722759-2470-2-git-send-email-makita.toshiaki__14800.5589888029$1548742648$gmane$org@lab.ntt.co.jp>
References: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Commit 4e09ff536284 ("virtio-net: disable NAPI only when enabled during
XDP set") tried to fix inappropriate NAPI enabling/disabling when
!netif_running(), but was not complete.

On error path virtio_net could enable NAPI even when !netif_running().
This can cause enabling NAPI twice on virtnet_open(), which would
trigger BUG_ON() in napi_enable().

Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8fadd8e..8e4c5d4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2430,8 +2430,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	return 0;
 
 err:
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+	if (netif_running(dev)) {
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
 	return err;
-- 
1.8.3.1
