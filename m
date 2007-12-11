From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH resent] virtio_net: Fix stalled inbound traffic on early
	packets
Date: Tue, 11 Dec 2007 12:42:28 +0100
Message-ID: <200712111242.28843.borntraeger__2104.4414992959$1197373486$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

while implementing and testing virtio on s390 I found a problem in
virtio_net: The current virtio_net driver has a startup race, which
prevents any incoming traffic:

If try_fill_recv submits buffers to the host system data might be
filled in and an interrupt is sent, before napi_enable finishes.
In that case the interrupt will kick skb_recv_done which will then
call netif_rx_schedule. netif_rx_schedule checks, if NAPI_STATE_SCHED
is set - which is not as we did not run napi_enable. No poll routine
is scheduled. Furthermore, skb_recv_done returns false, we disables
interrupts for this device.

One solution is the enable napi before inbound buffer are available.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/net/virtio_net.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: kvm/drivers/net/virtio_net.c
===================================================================
--- kvm.orig/drivers/net/virtio_net.c
+++ kvm/drivers/net/virtio_net.c
@@ -285,13 +285,15 @@ static int virtnet_open(struct net_devic
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
+	napi_enable(&vi->napi);
 	try_fill_recv(vi);
 
 	/* If we didn't even get one input buffer, we're useless. */
-	if (vi->num == 0)
+	if (vi->num == 0) {
+		napi_disable(&vi->napi);
 		return -ENOMEM;
+	}
 
-	napi_enable(&vi->napi);
 	return 0;
 }
