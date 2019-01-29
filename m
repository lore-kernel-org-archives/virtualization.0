From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net 5/7] virtio_net: Don't process redirected XDP frames
	when XDP is disabled
Date: Tue, 29 Jan 2019 09:45:57 +0900
Message-ID: <1548722759-2470-6-git-send-email-makita.toshiaki__24456.3010682882$1548742703$gmane$org@lab.ntt.co.jp>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Commit 8dcc5b0ab0ec ("virtio_net: fix ndo_xdp_xmit crash towards dev not
ready for XDP") tried to avoid access to unexpected sq while XDP is
disabled, but was not complete.

There was a small window which causes out of bounds sq access in
virtnet_xdp_xmit() while disabling XDP.

An example case of
 - curr_queue_pairs = 6 (2 for SKB and 4 for XDP)
 - online_cpu_num = xdp_queue_paris = 4
when XDP is enabled:

CPU 0                         CPU 1
(Disabling XDP)               (Processing redirected XDP frames)

                              virtnet_xdp_xmit()
virtnet_xdp_set()
 _virtnet_set_queues()
  set curr_queue_pairs (2)
                               check if rq->xdp_prog is not NULL
                               virtnet_xdp_sq(vi)
                                qp = curr_queue_pairs -
                                     xdp_queue_pairs +
                                     smp_processor_id()
                                   = 2 - 4 + 1 = -1
                                sq = &vi->sq[qp] // out of bounds access
  set xdp_queue_pairs (0)
  rq->xdp_prog = NULL

Basically we should not change curr_queue_pairs and xdp_queue_pairs
while someone can read the values. Thus, when disabling XDP, assign NULL
to rq->xdp_prog first, and wait for RCU grace period, then change
xxx_queue_pairs.
Note that we need to keep the current order when enabling XDP though.

- v2: Make rcu_assign_pointer/synchronize_net conditional instead of
      _virtnet_set_queues.

Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/virtio_net.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 669b65c..cea52e4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2410,6 +2410,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		return -ENOMEM;
 	}
 
+	old_prog = rtnl_dereference(vi->rq[0].xdp_prog);
+	if (!prog && !old_prog)
+		return 0;
+
 	if (prog) {
 		prog = bpf_prog_add(prog, vi->max_queue_pairs - 1);
 		if (IS_ERR(prog))
@@ -2424,21 +2428,30 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 	}
 
+	if (!prog) {
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
+			if (i == 0)
+				virtnet_restore_guest_offloads(vi);
+		}
+		synchronize_net();
+	}
+
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	vi->xdp_queue_pairs = xdp_qp;
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		old_prog = rtnl_dereference(vi->rq[i].xdp_prog);
-		rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
-		if (i == 0) {
-			if (!old_prog)
+	if (prog) {
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
+			if (i == 0 && !old_prog)
 				virtnet_clear_guest_offloads(vi);
-			if (!prog)
-				virtnet_restore_guest_offloads(vi);
 		}
+	}
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
@@ -2451,6 +2464,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	return 0;
 
 err:
+	if (!prog) {
+		virtnet_clear_guest_offloads(vi);
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
+	}
+
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
 			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-- 
1.8.3.1
