From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 8/9] vhost_net: rename VHOST_RX_BATCH to
	VHOST_NET_BATCH
Date: Fri, 20 Jul 2018 08:15:20 +0800
Message-ID: <1532045721-4958-9-git-send-email-jasowang__16553.29303253$1532046099$gmane$org@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

A more generic name which could be used for TX as well.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 53d305b..2fd2f0e3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
 	struct vhost_virtqueue *vq;
 };
 
-#define VHOST_RX_BATCH 64
+#define VHOST_NET_BATCH 64
 struct vhost_net_buf {
 	void **queue;
 	int tail;
@@ -168,7 +168,7 @@ static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
 
 	rxq->head = 0;
 	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
-					      VHOST_RX_BATCH);
+					      VHOST_NET_BATCH);
 	return rxq->tail;
 }
 
@@ -1007,7 +1007,7 @@ static void handle_rx(struct vhost_net *net)
 			goto out;
 		}
 		nvq->done_idx += headcount;
-		if (nvq->done_idx > VHOST_RX_BATCH)
+		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
 		if (unlikely(vq_log))
 			vhost_log_write(vq, vq_log, log, vhost_len);
@@ -1075,7 +1075,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		return -ENOMEM;
 	}
 
-	queue = kmalloc_array(VHOST_RX_BATCH, sizeof(void *),
+	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
 			      GFP_KERNEL);
 	if (!queue) {
 		kfree(vqs);
-- 
2.7.4
