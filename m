From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 02/12] vhost_net: introduce vhost_exceeds_weight()
Date: Mon, 21 May 2018 17:04:23 +0800
Message-ID: <1526893473-20128-3-git-send-email-jasowang__33213.4843607948$1526893470$gmane$org@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 15d191a..de544ee 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -479,6 +479,12 @@ static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
 	return len;
 }
 
+static bool vhost_exceeds_weight(int pkts, int total_len)
+{
+	return unlikely(total_len >= VHOST_NET_WEIGHT) ||
+	       unlikely(pkts >= VHOST_NET_PKT_WEIGHT);
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -570,7 +576,6 @@ static void handle_tx(struct vhost_net *net)
 			msg.msg_control = NULL;
 			ubufs = NULL;
 		}
-
 		total_len += len;
 		if (total_len < VHOST_NET_WEIGHT &&
 		    !vhost_vq_avail_empty(&net->dev, vq) &&
@@ -600,8 +605,7 @@ static void handle_tx(struct vhost_net *net)
 		else
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
-		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
-		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT)) {
+		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
@@ -887,8 +891,7 @@ static void handle_rx(struct vhost_net *net)
 		if (unlikely(vq_log))
 			vhost_log_write(vq, vq_log, log, vhost_len);
 		total_len += vhost_len;
-		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
-		    unlikely(++recv_pkts >= VHOST_NET_PKT_WEIGHT)) {
+		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
 			vhost_poll_queue(&vq->poll);
 			goto out;
 		}
-- 
2.7.4
