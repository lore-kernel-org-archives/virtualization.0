From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 11/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:26:36 +0200
Message-ID: <476BDB2C.8070100__31617.9148540416$1198250929$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>Anthony Liguori <a>
List-Id: virtualization@lists.linuxfoundation.org

 From 867f898388bda2dccf6d0aba2a9c96abae1697ed Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Sun, 16 Dec 2007 15:19:43 +0200
Subject: [PATCH] Parametrize the napi_weight for virtio receive queue. 
It is done in order to improve performance.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 drivers/net/virtio_net.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0403d65..d35dbe7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -25,6 +25,9 @@
 #include <linux/scatterlist.h>
 #include <linux/hrtimer.h>
 
+static int napi_weight = 128;
+module_param(napi_weight, int, 0);
+
 /* FIXME: MTU in config. */
 #define MAX_PACKET_LEN (ETH_HLEN+ETH_DATA_LEN)
 
@@ -508,7 +511,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
     /* Set up our device-specific information */
     vi = netdev_priv(dev);
-    netif_napi_add(dev, &vi->napi, virtnet_poll, 16);
+    netif_napi_add(dev, &vi->napi, virtnet_poll, napi_weight);
     vi->dev = dev;
     vi->vdev = vdev;
     hrtimer_init(&vi->tx_timer, CLOCK_REALTIME, HRTIMER_MODE_REL);
-- 
1.5.3.3
