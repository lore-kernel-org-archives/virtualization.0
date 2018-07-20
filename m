From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 7/9] vhost_net: rename vhost_rx_signal_used() to
	vhost_net_signal_used()
Date: Fri, 20 Jul 2018 08:15:19 +0800
Message-ID: <1532045721-4958-8-git-send-email-jasowang__12334.8542875194$1532046033$gmane$org@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rename for reusing this for TX.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 9cef0b2..53d305b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -741,7 +741,7 @@ static int sk_has_rx_data(struct sock *sk)
 	return skb_queue_empty(&sk->sk_receive_queue);
 }
 
-static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
+static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
 {
 	struct vhost_virtqueue *vq = &nvq->vq;
 	struct vhost_dev *dev = vq->dev;
@@ -765,7 +765,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 
 	if (!len && tvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_rx_signal_used(rnvq);
+		vhost_net_signal_used(rnvq);
 		/* Both tx vq and rx socket were polled here */
 		mutex_lock_nested(&tvq->mutex, 1);
 		vhost_disable_notify(&net->dev, tvq);
@@ -1008,7 +1008,7 @@ static void handle_rx(struct vhost_net *net)
 		}
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_RX_BATCH)
-			vhost_rx_signal_used(nvq);
+			vhost_net_signal_used(nvq);
 		if (unlikely(vq_log))
 			vhost_log_write(vq, vq_log, log, vhost_len);
 		total_len += vhost_len;
@@ -1022,7 +1022,7 @@ static void handle_rx(struct vhost_net *net)
 	else
 		vhost_net_enable_vq(net, vq);
 out:
-	vhost_rx_signal_used(nvq);
+	vhost_net_signal_used(nvq);
 	mutex_unlock(&vq->mutex);
 }
 
-- 
2.7.4
