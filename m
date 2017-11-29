From: wexu@redhat.com
Subject: [PATCH net,stable v2] vhost: fix skb leak in handle_rx()
Date: Wed, 29 Nov 2017 09:23:24 -0500
Message-ID: <1511965404-23289-1-git-send-email-wexu__1982.29166348955$1512195450$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.vnet.ibm.com, wexu@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Xu <wexu@redhat.com>

Matthew found a roughly 40% tcp throughput regression with commit
c67df11f(vhost_net: try batch dequing from skb array) as discussed
in the following thread:
https://www.mail-archive.com/netdev@vger.kernel.org/msg187936.html

Eventually we figured out that it was a skb leak in handle_rx()
when sending packets to the VM. This usually happens when a guest
can not drain out vq as fast as vhost fills in, afterwards it sets
off the traffic jam and leaks skb(s) which occurs as no headcount
to send on the vq from vhost side.

This can be avoided by making sure we have got enough headcount
before actually consuming a skb from the batched rx array while
transmitting, which is simply done by moving checking the zero
headcount a bit ahead.

Also strengthen the small possibility of leak in case of recvmsg()
fails by freeing the skb.

Signed-off-by: Wei Xu <wexu@redhat.com>
Reported-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
---
 drivers/vhost/net.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

v2:
- add Matthew as the reporter, thanks matthew.
- moving zero headcount check ahead instead of defer consuming skb
  due to jason and mst's comment.
- add freeing skb in favor of recvmsg() fails.

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8d626d7..e302e08 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -778,16 +778,6 @@ static void handle_rx(struct vhost_net *net)
 		/* On error, stop handling until the next kick. */
 		if (unlikely(headcount < 0))
 			goto out;
-		if (nvq->rx_array)
-			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
-		/* On overrun, truncate and discard */
-		if (unlikely(headcount > UIO_MAXIOV)) {
-			iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
-			err = sock->ops->recvmsg(sock, &msg,
-						 1, MSG_DONTWAIT | MSG_TRUNC);
-			pr_debug("Discarded rx packet: len %zd\n", sock_len);
-			continue;
-		}
 		/* OK, now we need to know about added descriptors. */
 		if (!headcount) {
 			if (unlikely(vhost_enable_notify(&net->dev, vq))) {
@@ -800,6 +790,18 @@ static void handle_rx(struct vhost_net *net)
 			 * they refilled. */
 			goto out;
 		}
+		if (nvq->rx_array)
+			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
+		/* On overrun, truncate and discard */
+		if (unlikely(headcount > UIO_MAXIOV)) {
+			iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
+			err = sock->ops->recvmsg(sock, &msg,
+						 1, MSG_DONTWAIT | MSG_TRUNC);
+			if (unlikely(err != 1))
+				kfree_skb((struct sk_buff *)msg.msg_control);
+			pr_debug("Discarded rx packet: len %zd\n", sock_len);
+			continue;
+		}
 		/* We don't need to be notified again. */
 		iov_iter_init(&msg.msg_iter, READ, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
@@ -818,6 +820,7 @@ static void handle_rx(struct vhost_net *net)
 			pr_debug("Discarded rx packet: "
 				 " len %d, expected %zd\n", err, sock_len);
 			vhost_discard_vq_desc(vq, headcount);
+			kfree_skb((struct sk_buff *)msg.msg_control);
 			continue;
 		}
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
-- 
1.8.3.1
