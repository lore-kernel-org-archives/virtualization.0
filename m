From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v7 4/4] net: vhost: add rx busy polling in tx path
Date: Tue, 31 Jul 2018 20:00:54 -0700
Message-ID: <1533092454-37196-5-git-send-email-xiangxia.m.yue__40094.6092828692$1533092544$gmane$org@gmail.com>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
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
* With the patch:     38570.00 Mbps, 3.43 us mean latency

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 5b45463..b56db65 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -530,31 +530,24 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 }
 
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
-				    struct vhost_net_virtqueue *nvq,
+				    struct vhost_net_virtqueue *tnvq,
 				    unsigned int *out_num, unsigned int *in_num,
 				    bool *busyloop_intr)
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
-		if (!vhost_sock_zcopy(vq->private_data))
-			vhost_net_signal_used(nvq);
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
+	if (r == tvq->num && tvq->busyloop_timeout) {
+		if (!vhost_sock_zcopy(tvq->private_data))
+			vhost_net_signal_used(tnvq);
+
+		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
+
+		r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
 				      out_num, in_num, NULL, NULL);
 	}
 
-- 
1.8.3.1
