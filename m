From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 06/15] vhost_net: switch TX to use shadow used ring API
Date: Wed, 17 Jul 2019 06:52:46 -0400
Message-ID: <20190717105255.63488-7-jasowang__11054.1442803637$1563360863$gmane$org@redhat.com>
References: <20190717105255.63488-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717105255.63488-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch switch to use shadow used ring API for transmission. This
will help to hide used ring layout from device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ac31983d2d77..cf47e6e348f4 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -361,22 +361,22 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 {
 	struct vhost_net_virtqueue *nvq =
 		container_of(vq, struct vhost_net_virtqueue, vq);
-	int i, add;
+	int i, add, len;
 	int j = 0;
 
 	for (i = nvq->done_idx; i != nvq->upend_idx; i = (i + 1) % UIO_MAXIOV) {
-		if (vq->heads[i].len == VHOST_DMA_FAILED_LEN)
+		len = vhost_get_zc_used_len(vq, i);
+		if (len == VHOST_DMA_FAILED_LEN)
 			vhost_net_tx_err(net);
-		if (VHOST_DMA_IS_DONE(vq->heads[i].len)) {
-			vq->heads[i].len = VHOST_DMA_CLEAR_LEN;
+		if (VHOST_DMA_IS_DONE(len)) {
+			vhost_set_zc_used_len(vq, i, VHOST_DMA_CLEAR_LEN);
 			++j;
 		} else
 			break;
 	}
 	while (j) {
 		add = min(UIO_MAXIOV - nvq->done_idx, j);
-		vhost_add_used_and_signal_n(vq->dev, vq,
-					    &vq->heads[nvq->done_idx], add);
+		vhost_flush_zc_used_and_signal(vq, nvq->done_idx, add);
 		nvq->done_idx = (nvq->done_idx + add) % UIO_MAXIOV;
 		j -= add;
 	}
@@ -391,8 +391,8 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 	rcu_read_lock_bh();
 
 	/* set len to mark this desc buffers done DMA */
-	vq->heads[ubuf->desc].len = success ?
-		VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
+	vhost_set_zc_used_len(vq, ubuf->desc, success ?
+			      VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN);
 	cnt = vhost_net_ubuf_put(ubufs);
 
 	/*
@@ -480,7 +480,7 @@ static void vhost_tx_batch(struct vhost_net *net,
 	}
 
 signal_used:
-	vhost_net_signal_used(nvq);
+	vhost_flush_shadow_used_and_signal(&nvq->vq);
 	nvq->batched_xdp = 0;
 }
 
@@ -776,7 +776,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	do {
 		bool busyloop_intr = false;
 
-		if (nvq->done_idx == VHOST_NET_BATCH)
+		if (vhost_get_shadow_used_count(vq) == VHOST_NET_BATCH)
 			vhost_tx_batch(net, nvq, sock, &msg);
 
 		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
@@ -835,9 +835,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			pr_debug("Truncated TX packet: len %d != %zd\n",
 				 err, len);
 done:
-		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
-		vq->heads[nvq->done_idx].len = 0;
-		++nvq->done_idx;
+		vhost_add_shadow_used(vq, cpu_to_vhost32(vq, head), 0);
 	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
 
 	vhost_tx_batch(net, nvq, sock, &msg);
@@ -908,9 +906,10 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 			msg.msg_control = NULL;
 			ubufs = NULL;
 		}
-		vq->heads[nvq->upend_idx].id = cpu_to_vhost32(vq, head);
-		vq->heads[nvq->upend_idx].len = zcopy_used ?
-			 VHOST_DMA_IN_PROGRESS : VHOST_DMA_DONE_LEN;
+		vhost_set_zc_used(vq, nvq->upend_idx,
+				  cpu_to_vhost32(vq, head),
+				  zcopy_used ? VHOST_DMA_IN_PROGRESS :
+				  VHOST_DMA_DONE_LEN);
 		nvq->upend_idx = (nvq->upend_idx + 1) % UIO_MAXIOV;
 		total_len += len;
 		if (tx_can_batch(vq, total_len) &&
-- 
2.18.1
