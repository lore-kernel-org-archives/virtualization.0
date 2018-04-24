From: Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] vhost_net: use packet weight for rx handler, too
Date: Tue, 24 Apr 2018 10:34:36 +0200
Message-ID: <11f2a27cee0c660a611af381ac1b68d9526095e3.1524556673.git.pabeni__1010.58758232302$1524558795$gmane$org@redhat.com>
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
To: kvm@vger.kernel.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, haibinzhang <haibinzhang@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Similar to commit a2ac99905f1e ("vhost-net: set packet weight of
tx polling to 2 * vq size"), we need a packet-based limit for
handler_rx, too - elsewhere, under rx flood with small packets,
tx can be delayed for a very long time, even without busypolling.

The pkt limit applied to handle_rx must be the same applied by
handle_tx, or we will get unfair scheduling between rx and tx.
Tying such limit to the queue length makes it less effective for
large queue length values and can introduce large process
scheduler latencies, so a constant valued is used - likewise
the existing bytes limit.

The selected limit has been validated with PVP[1] performance
test with different queue sizes:

queue size		256	512	1024

baseline		366	354	362
weight 128		715	723	670
weight 256		740	745	733
weight 512		600	460	583
weight 1024		423	427	418

A packet weight of 256 gives peek performances in under all the
tested scenarios.

No measurable regression in unidirectional performance tests has
been detected.

[1] https://developers.redhat.com/blog/2017/06/05/measuring-and-comparing-open-vswitch-performance/

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/vhost/net.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index bbf38befefb2..c4b49fca4871 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -46,8 +46,10 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 #define VHOST_NET_WEIGHT 0x80000
 
 /* Max number of packets transferred before requeueing the job.
- * Using this limit prevents one virtqueue from starving rx. */
-#define VHOST_NET_PKT_WEIGHT(vq) ((vq)->num * 2)
+ * Using this limit prevents one virtqueue from starving others with small
+ * pkts.
+ */
+#define VHOST_NET_PKT_WEIGHT 256
 
 /* MAX number of TX used buffers for outstanding zerocopy */
 #define VHOST_MAX_PEND 128
@@ -587,7 +589,7 @@ static void handle_tx(struct vhost_net *net)
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
 		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
-		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT(vq))) {
+		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT)) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
@@ -769,6 +771,7 @@ static void handle_rx(struct vhost_net *net)
 	struct socket *sock;
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
+	int recv_pkts = 0;
 
 	mutex_lock_nested(&vq->mutex, 0);
 	sock = vq->private_data;
@@ -872,7 +875,8 @@ static void handle_rx(struct vhost_net *net)
 		if (unlikely(vq_log))
 			vhost_log_write(vq, vq_log, log, vhost_len);
 		total_len += vhost_len;
-		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
+		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
+		    unlikely(++recv_pkts >= VHOST_NET_PKT_WEIGHT)) {
 			vhost_poll_queue(&vq->poll);
 			goto out;
 		}
-- 
2.14.3
