From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Thu, 18 Oct 2018 10:43:13 +0200
Message-ID: <20181018084313.oopu34iwfwgkcwwc__37629.9595846378$1539852095$gmane$org@linutronix.de>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<20181016110114.73e2b248@xeon-e3>
	<20181016184206.coukhtgmlr32hyl7@linutronix.de>
	<20181016114414.23ea73c3@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181016114414.23ea73c3@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

on 32bit, lockdep notices that virtnet_open() and refill_work() invoke
try_fill_recv() from process context while virtnet_receive() invokes the
same function from BH context. The problem that the seqcounter within
u64_stats_update_begin() may deadlock if it is interrupted by BH and
then acquired again.

Introduce u64_stats_update_begin_bh() which disables BH on 32bit
architectures. Since the BH might interrupt the worker, this new
function should not limited to SMP like the others which are expected
to be used in softirq.

With this change we might lose increments but this is okay. The
important part that the two 32bit parts of the 64bit counter are not
corrupted.

Fixes: 461f03dc99cf6 ("virtio_net: Add kick stats").
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/virtio_net.c       |  4 ++--
 include/linux/u64_stats_sync.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dab504ec5e502..fbcfb4d272336 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1206,9 +1206,9 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 			break;
 	} while (rq->vq->num_free);
 	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
-		u64_stats_update_begin(&rq->stats.syncp);
+		u64_stats_update_begin_bh(&rq->stats.syncp);
 		rq->stats.kicks++;
-		u64_stats_update_end(&rq->stats.syncp);
+		u64_stats_update_end_bh(&rq->stats.syncp);
 	}
 
 	return !oom;
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index a27604f99ed04..46b6ad6175628 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -90,6 +90,22 @@ static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
 #endif
 }
 
+static inline void u64_stats_update_begin_bh(struct u64_stats_sync *syncp)
+{
+#if BITS_PER_LONG==32
+	local_bh_disable();
+	write_seqcount_begin(&syncp->seq);
+#endif
+}
+
+static inline void u64_stats_update_end_bh(struct u64_stats_sync *syncp)
+{
+#if BITS_PER_LONG==32
+	write_seqcount_end(&syncp->seq);
+	local_bh_enable();
+#endif
+}
+
 static inline unsigned long
 u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
 {
-- 
2.19.1
