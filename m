From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC] virtio: orphan skbs if we're relying on timer to free them
Date: Mon, 18 May 2009 22:18:47 +0930
Message-ID: <200905182218.47975.rusty__36139.5138818354$1242651084$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We check for finished xmit skbs on every xmit, or on a timer (unless
the host promises to force an interrupt when the xmit ring is empty).
This can penalize userspace tasks which fill their sockbuf.  Not much
difference with TSO, but measurable with large numbers of packets.

There are a finite number of packets which can be in the transmission
queue.  We could fire the timer more than every 100ms, but that would
just hurt performance for a corner case.  This seems neatest.

With interrupt when Tx ring empty:
				Seconds	TxPkts	TxIRQs
 1G TCP Guest->Host:		3.76	32833	32758
 1M normal pings:		111	1000008	997463
 1M 1k pings (-l 120):		55	1000007	488920

Without interrupt, without orphaning:
 1G TCP Guest->Host:		3.64	32806	1
 1M normal pings:		106	1000008	1
 1M 1k pings (-l 120):		68	1000005	1

With orphaning:
 1G TCP Guest->Host:		3.86	32821	1
 1M normal pings:		102	1000007	1
 1M 1k pings (-l 120):		43	1000005	1

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -522,6 +522,11 @@ static int start_xmit(struct sk_buff *sk
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
+	/* We queue a limited number; don't let that delay writers if
+	 * we are slow in getting tx interrupt. */
+	if (!vi->free_in_tasklet)
+		skb_orphan(skb);
+
 again:
 	/* Free up any pending old buffers before queueing new ones. */
 	free_old_xmit_skbs(vi);
