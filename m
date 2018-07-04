From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v5 4/4] net: vhost: add rx busy polling in tx path
Date: Tue,  3 Jul 2018 21:31:38 -0700
Message-ID: <1530678698-33427-5-git-send-email-xiangxia.m.yue__38912.2194996618$1530678838$gmane$org@gmail.com>
References: <1530678698-33427-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1530678698-33427-1-git-send-email-xiangxia.m.yue@gmail.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Tonghao Zhang <zhangtonghao@didichuxing.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

This patch improves the guest receive and transmit performance.
On the handle_tx side, we poll the sock receive queue at the
same time. handle_rx do that in the same way.

We set the poll-us=100us and use the iperf3 to test
its bandwidth, use the netperf to test throughput and mean
latency. When running the tests, the vhost-net kthread of
that VM, is alway 100% CPU. The commands are shown as below.

iperf3  -s -D
iperf3  -c IP -i 1 -P 1 -t 20 -M 1400

or
netserver
netperf -H IP -t TCP_RR -l 20 -- -O "THROUGHPUT,MEAN_LATENCY"

host -> guest:
iperf3:
* With the patch:     27.0 Gbits/sec
* Without the patch:  14.4 Gbits/sec

netperf (TCP_RR):
* With the patch:     48039.56 trans/s, 20.64us mean latency
* Without the patch:  46027.07 trans/s, 21.58us mean latency

This patch also improves the guest transmit performance.

guest -> host:
iperf3:
* With the patch:     27.2 Gbits/sec
* Without the patch:  24.4 Gbits/sec

netperf (TCP_RR):
* With the patch:     47963.25 trans/s, 20.71us mean latency
* Without the patch:  45796.70 trans/s, 21.68us mean latency

Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>
---
 drivers/vhost/net.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 2790959..3f26547 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -480,17 +480,13 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct iovec iov[], unsigned int iov_size,
 				    unsigned int *out_num, unsigned int *in_num)
 {
-	unsigned long uninitialized_var(endtime);
+	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				  out_num, in_num, NULL, NULL);
 
 	if (r == vq->num && vq->busyloop_timeout) {
-		preempt_disable();
-		endtime = busy_clock() + vq->busyloop_timeout;
-		while (vhost_can_busy_poll(vq->dev, endtime) &&
-		       vhost_vq_avail_empty(vq->dev, vq))
-			cpu_relax();
-		preempt_enable();
+		vhost_net_busy_poll(net, &rnvq->vq, vq, false);
+
 		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				      out_num, in_num, NULL, NULL);
 	}
-- 
1.8.3.1
