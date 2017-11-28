From: wexu@redhat.com
Subject: [PATCH net,stable] vhost: fix skb leak in handle_rx()
Date: Tue, 28 Nov 2017 12:17:16 -0500
Message-ID: <1511889436-12876-1-git-send-email-wexu__44794.8861438364$1512195403$gmane$org@redhat.com>
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
transmitting, which is simply done by deferring it a moment later
in this patch.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 drivers/vhost/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8d626d7..e76535e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -778,8 +778,6 @@ static void handle_rx(struct vhost_net *net)
 		/* On error, stop handling until the next kick. */
 		if (unlikely(headcount < 0))
 			goto out;
-		if (nvq->rx_array)
-			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
 		/* On overrun, truncate and discard */
 		if (unlikely(headcount > UIO_MAXIOV)) {
 			iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
@@ -809,6 +807,8 @@ static void handle_rx(struct vhost_net *net)
 			 */
 			iov_iter_advance(&msg.msg_iter, vhost_hlen);
 		}
+		if (nvq->rx_array)
+			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
 		err = sock->ops->recvmsg(sock, &msg,
 					 sock_len, MSG_DONTWAIT | MSG_TRUNC);
 		/* Userspace might have consumed the packet meanwhile:
-- 
1.8.3.1
