From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Use memset(0) instead of setting cb_mode explicitly
Date: Thu,  3 Jan 2008 09:57:14 -0600
Message-ID: <11993758341994-git-send-email-aliguori__5118.25970975241$1199375950$gmane$org@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel@lists.sourceforge.net, Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

hrtimer's only have a cb_mode if CONFIG_HIGH_RES_TIMER is enabled.  This patch
memset()s the tx_timer structure to 0 which has the same effect as setting
cb_mode to HRTIMER_CB_SOFTIRQ without requiring CONFIG_HIGH_RES_TIMER to be
set.  This seems to be what other drivers do.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 47e4fce..d11a670 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -434,9 +434,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	netif_napi_add(dev, &vi->napi, virtnet_poll, napi_weight);
 	vi->dev = dev;
 	vi->vdev = vdev;
+	memset(&vi->tx_timer, 0, sizeof(vi->tx_timer));
 	hrtimer_init(&vi->tx_timer, CLOCK_REALTIME, HRTIMER_MODE_REL);
 	vi->tx_timer.function = kick_xmit;
-	vi->tx_timer.cb_mode = HRTIMER_CB_SOFTIRQ;
 	vi->out_max = -1U;
 
 	tasklet_init(&vi->xmit_free, xmit_free, (unsigned long)vi);
