From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 3/9] vhost_net: introduce vhost_exceeds_weight()
Date: Fri, 20 Jul 2018 08:15:15 +0800
Message-ID: <1532045721-4958-4-git-send-email-jasowang__31195.0232754045$1532045769$gmane$org@redhat.com>
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

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index cac28fd..b9e1674 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -478,6 +478,12 @@ static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
 	return iov_iter_count(iter);
 }
 
+static bool vhost_exceeds_weight(int pkts, int total_len)
+{
+	return total_len >= VHOST_NET_WEIGHT ||
+	       pkts >= VHOST_NET_PKT_WEIGHT;
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -576,7 +582,6 @@ static void handle_tx(struct vhost_net *net)
 			msg.msg_control = NULL;
 			ubufs = NULL;
 		}
-
 		total_len += len;
 		if (total_len < VHOST_NET_WEIGHT &&
 		    !vhost_vq_avail_empty(&net->dev, vq) &&
@@ -606,8 +611,7 @@ static void handle_tx(struct vhost_net *net)
 		else
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
-		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
-		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT)) {
+		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
@@ -918,8 +922,7 @@ static void handle_rx(struct vhost_net *net)
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
