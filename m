From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v8 7/7] net: vhost: make busyloop_intr more accurate
Date: Sun, 19 Aug 2018 05:11:26 -0700
Message-ID: <1534680686-3108-8-git-send-email-xiangxia.m.yue__20595.1114920483$1534681053$gmane$org@gmail.com>
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

The patch uses vhost_has_work_pending() to check if
the specified handler is scheduled, because in the most case,
vhost_has_work() return true when other side handler is added
to worker list. Use the vhost_has_work_pending() insead of
vhost_has_work().

Topology:
[Host] ->linux bridge -> tap vhost-net ->[Guest]

TCP_STREAM (netperf):
* Without the patch:  38035.39 Mbps, 3.37 us mean latency
* With the patch:     38409.44 Mbps, 3.34 us mean latency

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index db63ae2..b6939ef 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -487,10 +487,8 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	endtime = busy_clock() + busyloop_timeout;
 
 	while (vhost_can_busy_poll(endtime)) {
-		if (vhost_has_work(&net->dev)) {
-			*busyloop_intr = true;
+		if (vhost_has_work(&net->dev))
 			break;
-		}
 
 		if ((sock_has_rx_data(sock) &&
 		     !vhost_vq_avail_empty(&net->dev, rvq)) ||
@@ -513,6 +511,11 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	    !vhost_has_work_pending(&net->dev, VHOST_NET_VQ_RX))
 		vhost_net_enable_vq(net, rvq);
 
+	if (vhost_has_work_pending(&net->dev,
+				   poll_rx ?
+				   VHOST_NET_VQ_RX: VHOST_NET_VQ_TX))
+		*busyloop_intr = true;
+
 	mutex_unlock(&vq->mutex);
 }
 
-- 
1.8.3.1
