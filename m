From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: [PATCH] net: vhost: improve performance when enable busyloop
Date: Wed, 20 Jun 2018 06:28:51 -0700
Message-ID: <1529501332-118823-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: netdev@vger.kernel.org, Tonghao Zhang <zhangtonghao@didichuxing.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch improves the guest receive performance from
host. On the handle_tx side, we poll the sock receive
queue at the same time. handle_rx do that in the same way.

we set the poll-us=100 us and use the iperf3 to test
its throughput. The iperf3 command is shown as below.

iperf3 -s -D
iperf3 -c 192.168.1.100 -i 1 -P 10 -t 10 -M 1400 --bandwidth 100000M

* With the patch:    21.1 Gbits/sec
* Without the patch: 12.7 Gbits/sec

Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>
---
 drivers/vhost/net.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index e7cf7d2..9364ede 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -429,22 +429,43 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 	return vhost_poll_start(poll, sock->file);
 }
 
+static int sk_has_rx_data(struct sock *sk);
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
 				    struct iovec iov[], unsigned int iov_size,
 				    unsigned int *out_num, unsigned int *in_num)
 {
 	unsigned long uninitialized_var(endtime);
+	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_RX];
+	struct vhost_virtqueue *rvq = &nvq->vq;
+	struct socket *sock = rvq->private_data;
+
 	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				  out_num, in_num, NULL, NULL);
 
 	if (r == vq->num && vq->busyloop_timeout) {
+		mutex_lock_nested(&rvq->mutex, 1);
+
+		vhost_disable_notify(&net->dev, rvq);
+
 		preempt_disable();
 		endtime = busy_clock() + vq->busyloop_timeout;
 		while (vhost_can_busy_poll(vq->dev, endtime) &&
+		       !(sock && sk_has_rx_data(sock->sk)) &&
 		       vhost_vq_avail_empty(vq->dev, vq))
 			cpu_relax();
 		preempt_enable();
+
+		if (sock && sk_has_rx_data(sock->sk))
+			vhost_poll_queue(&rvq->poll);
+		else if (unlikely(vhost_enable_notify(&net->dev, rvq))) {
+			vhost_disable_notify(&net->dev, rvq);
+			vhost_poll_queue(&rvq->poll);
+		}
+
+		mutex_unlock(&rvq->mutex);
+
 		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				      out_num, in_num, NULL, NULL);
 	}
-- 
1.8.3.1
