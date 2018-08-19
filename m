From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v8 6/7] net: vhost: disable rx wakeup during tx
	busypoll
Date: Sun, 19 Aug 2018 05:11:25 -0700
Message-ID: <1534680686-3108-7-git-send-email-xiangxia.m.yue__4214.49628561295$1534680981$gmane$org@gmail.com>
References: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

In the handle_tx, the busypoll will vhost_net_disable/enable_vq
because we have poll the sock. This can improve performance.

This is suggested by Toshiaki Makita and Jason Wang.

If the rx handle is scheduled, we will not enable vq, because it's
not necessary. We do it not in last 'else' because if we receive
the data, but can't queue the rx handle(rx vring is full), then we
enable the vq to avoid case: guest receives the data, vring is not
full then guest can get more data, but vq is disabled, rx vq can't
be wakeup to receive more data.

Topology:
[Host] ->linux bridge -> tap vhost-net ->[Guest]

TCP_STREAM (netperf):
* Without the patch:  37598.20 Mbps, 3.43 us mean latency
* With the patch:     38035.39 Mbps, 3.37 us mean latency

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 23d7ffc..db63ae2 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -480,6 +480,9 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
 				     tvq->busyloop_timeout;
 
+	if (!poll_rx)
+		vhost_net_disable_vq(net, rvq);
+
 	preempt_disable();
 	endtime = busy_clock() + busyloop_timeout;
 
@@ -506,6 +509,10 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	else /* On tx here, sock has no rx data. */
 		vhost_enable_notify(&net->dev, rvq);
 
+	if (!poll_rx &&
+	    !vhost_has_work_pending(&net->dev, VHOST_NET_VQ_RX))
+		vhost_net_enable_vq(net, rvq);
+
 	mutex_unlock(&vq->mutex);
 }
 
-- 
1.8.3.1
