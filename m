From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/2] virtio: fix net driver loop case where we fail to
	restart
Date: Mon, 19 Nov 2007 11:20:15 +1100
Message-ID: <200711191120.15596.rusty__45784.4735974961$1195432236$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest <lguest@ozlabs.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

skb is only NULL the first time around: it's more correct to test for
being under-budget.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 2a94425ac7d5 drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Thu Nov 15 13:47:28 2007 +1100
+++ b/drivers/net/virtio_net.c	Thu Nov 15 23:10:44 2007 +1100
@@ -198,8 +198,8 @@ again:
 	if (vi->num < vi->max / 2)
 		try_fill_recv(vi);
 
-	/* All done? */
-	if (!skb) {
+	/* Out of packets? */
+	if (received < budget) {
 		netif_rx_complete(vi->dev, napi);
 		if (unlikely(!vi->rvq->vq_ops->restart(vi->rvq))
 		    && netif_rx_reschedule(vi->dev, napi))
