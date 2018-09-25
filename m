From: xiangxia.m.yue@gmail.com
Subject: [REBASE PATCH net-next v9 4/4] net: vhost: add rx busy polling in tx
	path
Date: Tue, 25 Sep 2018 05:36:52 -0700
Message-ID: <1537879012-20859-5-git-send-email-xiangxia.m.yue__7704.20600097186$1537878963$gmane$org@gmail.com>
References: <1537879012-20859-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1537879012-20859-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp, davem@davemloft.net
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

This patch improves the guest receive performance.
On the handle_tx side, we poll the sock receive queue at the
same time. handle_rx do that in the same way.

We set the poll-us=100us and use the netperf to test throughput
and mean latency. When running the tests, the vhost-net kthread
of that VM, is alway 100% CPU. The commands are shown as below.

Rx performance is greatly improved by this patch. There is not
notable performance change on tx with this series though. This
patch is useful for bi-directional traffic.

netperf -H IP -t TCP_STREAM -l 20 -- -O "THROUGHPUT, THROUGHPUT_UNITS, MEAN_LATENCY"

Topology:
[Host] ->linux bridge -> tap vhost-net ->[Guest]

TCP_STREAM:
* Without the patch:  19842.95 Mbps, 6.50 us mean latency
* With the patch:     37598.20 Mbps, 3.43 us mean latency

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ac0b954..015abf3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -547,34 +547,27 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	mutex_unlock(&vq->mutex);
 }
 
-
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
-				    struct vhost_net_virtqueue *nvq,
+				    struct vhost_net_virtqueue *tnvq,
 				    unsigned int *out_num, unsigned int *in_num,
 				    struct msghdr *msghdr, bool *busyloop_intr)
 {
-	struct vhost_virtqueue *vq = &nvq->vq;
-	unsigned long uninitialized_var(endtime);
-	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
+	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
+	struct vhost_virtqueue *rvq = &rnvq->vq;
+	struct vhost_virtqueue *tvq = &tnvq->vq;
+
+	int r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
 				  out_num, in_num, NULL, NULL);
 
-	if (r == vq->num && vq->busyloop_timeout) {
+	if (r == tvq->num && tvq->busyloop_timeout) {
 		/* Flush batched packets first */
-		if (!vhost_sock_zcopy(vq->private_data))
-			vhost_tx_batch(net, nvq, vq->private_data, msghdr);
-		preempt_disable();
-		endtime = busy_clock() + vq->busyloop_timeout;
-		while (vhost_can_busy_poll(endtime)) {
-			if (vhost_has_work(vq->dev)) {
-				*busyloop_intr = true;
-				break;
-			}
-			if (!vhost_vq_avail_empty(vq->dev, vq))
-				break;
-			cpu_relax();
-		}
-		preempt_enable();
-		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
+		if (!vhost_sock_zcopy(tvq->private_data))
+			// vhost_net_signal_used(tnvq);
+			vhost_tx_batch(net, tnvq, tvq->private_data, msghdr);
+
+		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
+
+		r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
 				      out_num, in_num, NULL, NULL);
 	}
 
-- 
1.8.3.1
