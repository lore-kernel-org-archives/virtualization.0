From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 10/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:26:08 +0200
Message-ID: <476BDB10.7090006__22621.5250826955$1198250905$gmane$org@qumranet.com>
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

 From 7354db58f496b06369e57d9be87e9c84db087690 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Wed, 12 Dec 2007 14:52:00 +0200
Subject: [PATCH] Don't arm tx hrtimer with a constant 500us each transmit

The current start_xmit sets 500us hrtimer to kick the host.
The problem is that if another xmit happens before the timer was fired then
the first xmit will have to wait additional 500us.
This patch does not re-arm the timer if there is existing one.
This will shorten the latency for tx.
It improves tx throughput by 20%

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 drivers/net/virtio_net.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 538cc37..0403d65 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -392,10 +392,10 @@ again:
         vi->stats.sendq_kicks++;
         vi->svq->vq_ops->kick(vi->svq);
         vi->out_num = 0;
-    } else {
-        vi->stats.hrtimer_starts++;
-        hrtimer_start(&vi->tx_timer, ktime_set(0,500000),
-                  HRTIMER_MODE_REL);
+    } else if (!hrtimer_is_queued(&vi->tx_timer)) {
+                  vi->stats.hrtimer_starts++;
+                  hrtimer_start(&vi->tx_timer, ktime_set(0,500000),
+                                HRTIMER_MODE_REL);
     }
     return 0;
 }
-- 
1.5.3.3
