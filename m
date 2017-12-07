From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH net-next] virtio_net: Disable interrupts if napi_complete_done
	rescheduled napi
Date: Thu,  7 Dec 2017 13:15:15 +0900
Message-ID: <1512620115-7569-1-git-send-email-makita.toshiaki__9434.95551259748$1512620234$gmane$org@lab.ntt.co.jp>
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
To: "David S . Miller" <davem@davemloft.net>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Since commit 39e6c8208d7b ("net: solve a NAPI race") napi has been able
to be rescheduled within napi_complete_done() even in non-busypoll case,
but virtnet_poll() always enabled interrupts before complete, and when
napi was rescheduled within napi_complete_done() it did not disable
interrupts.
This caused more interrupts when event idx is disabled.

According to commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
processing") we cannot place virtqueue_enable_cb_prepare() after
NAPI_STATE_SCHED is cleared, so disable interrupts again if
napi_complete_done() returned false.

Tested with vhost-user of OVS 2.7 on host, which does not have the event
idx feature.

* Before patch:

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.150.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32763206      0    6430.32
212992           60.00     23384299           4589.56

Interrupts on guest: 9872369
Packets/interrupt:   2.37

* After patch

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.150.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32794646      0    6436.49
212992           60.00     32793501           6436.27

Interrupts on guest: 4941299
Packets/interrupt:   6.64

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/virtio_net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 19a985e..c0db48d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -261,9 +261,12 @@ static void virtqueue_napi_complete(struct napi_struct *napi,
 	int opaque;
 
 	opaque = virtqueue_enable_cb_prepare(vq);
-	if (napi_complete_done(napi, processed) &&
-	    unlikely(virtqueue_poll(vq, opaque)))
-		virtqueue_napi_schedule(napi, vq);
+	if (napi_complete_done(napi, processed)) {
+		if (unlikely(virtqueue_poll(vq, opaque)))
+			virtqueue_napi_schedule(napi, vq);
+	} else {
+		virtqueue_disable_cb(vq);
+	}
 }
 
 static void skb_xmit_done(struct virtqueue *vq)
-- 
1.8.3.1
