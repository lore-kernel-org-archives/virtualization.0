From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_net: fix lockdep warning on 32 bit
Date: Tue, 5 May 2020 20:01:31 -0400
Message-ID: <20200506000006.196646-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

When we fill up a receive VQ, try_fill_recv currently tries to count
kicks using a 64 bit stats counter. Turns out, on a 32 bit kernel that
uses a seqcount. sequence counts are "lock" constructs where you need to
make sure that writers are serialized.

In turn, this means that we mustn't run two try_fill_recv concurrently.
Which of course we don't. We do run try_fill_recv sometimes from a fully
preemptible context and sometimes from a softirq (napi) context.

However, when it comes to the seqcount, lockdep is trying to enforce
the rule that the same lock isn't accessed from preemptible
and softirq context. This causes a false-positive warning:

WARNING: inconsistent lock state
...
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.

As a work around, shut down the warning by switching
to u64_stats_update_begin_irqsave - that works by disabling
interrupts on 32 bit only, is a NOP on 64 bit.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I'm not thrilled about this but this seems the best we can do for now.

Completely untested.


Thomas, can you pls let me know the config I need to trigger the warning
in question?


 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6594aab4910e..95393b61187f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1243,9 +1243,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 			break;
 	} while (rq->vq->num_free);
 	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
-		u64_stats_update_begin(&rq->stats.syncp);
+		unsigned long flags;
+
+		flags = u64_stats_update_begin_irqsave(&rq->stats.syncp);
 		rq->stats.kicks++;
-		u64_stats_update_end(&rq->stats.syncp);
+		u64_stats_update_end_irqrestore(&rq->stats.syncp);
 	}
 
 	return !oom;
-- 
MST
