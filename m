From: wexu@redhat.com
Subject: [PATCH 1/3] vhost: fix skb leak in handle_rx()
Date: Fri,  1 Dec 2017 05:10:36 -0500
Message-ID: <1512123038-15773-2-git-send-email-wexu__30384.5777213157$1512195599$gmane$org@redhat.com>
References: <1512123038-15773-1-git-send-email-wexu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1512123038-15773-1-git-send-email-wexu@redhat.com>
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

Signed-off-by: Wei Xu <wexu@redhat.com>
Reported-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
---
 drivers/vhost/net.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8d626d7..c7bdeb6 100644
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
@@ -800,6 +790,16 @@ static void handle_rx(struct vhost_net *net)
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
+			pr_debug("Discarded rx packet: len %zd\n", sock_len);
+			continue;
+		}
 		/* We don't need to be notified again. */
 		iov_iter_init(&msg.msg_iter, READ, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
-- 
1.8.3.1
