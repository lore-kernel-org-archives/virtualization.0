From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next RFC 4/5] vhost_net: rename VHOST_RX_BATCH to
	VHOST_NET_BATCH
Date: Fri, 22 Sep 2017 16:02:34 +0800
Message-ID: <1506067355-5771-5-git-send-email-jasowang__38683.7729871788$1506067427$gmane$org@redhat.com>
References: <1506067355-5771-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506067355-5771-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 58585ec..c89640e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -87,7 +87,7 @@ struct vhost_net_ubuf_ref {
 	struct vhost_virtqueue *vq;
 };
 
-#define VHOST_RX_BATCH 64
+#define VHOST_NET_BATCH 64
 struct vhost_net_buf {
 	struct sk_buff **queue;
 	int tail;
@@ -159,7 +159,7 @@ static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
 
 	rxq->head = 0;
 	rxq->tail = skb_array_consume_batched(nvq->rx_array, rxq->queue,
-					      VHOST_RX_BATCH);
+					      VHOST_NET_BATCH);
 	return rxq->tail;
 }
 
@@ -912,7 +912,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		return -ENOMEM;
 	}
 
-	queue = kmalloc_array(VHOST_RX_BATCH, sizeof(struct sk_buff *),
+	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(struct sk_buff *),
 			      GFP_KERNEL);
 	if (!queue) {
 		kfree(vqs);
-- 
2.7.4
