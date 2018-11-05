From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [PATCH 5/5] VSOCK: batch sending rx buffer to increase bandwidth
Date: Mon, 5 Nov 2018 15:48:38 +0800
Message-ID: <5BDFF5D6.2030802__21725.4449883059$1541404001$gmane$org@huawei.com>
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
To: stefanha@redhat.com, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Batch sending rx buffer can improve total bandwidth.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 drivers/vhost/vsock.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 648be39..a587ddc 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -148,10 +148,12 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			    struct vhost_virtqueue *vq)
 {
 	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
-	bool added = false;
 	bool restart_tx = false;
 	int mergeable;
 	size_t vsock_hlen;
+	int batch_count = 0;
+
+#define VHOST_VSOCK_BATCH 16

 	mutex_lock(&vq->mutex);

@@ -191,8 +193,9 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 		list_del_init(&pkt->list);
 		spin_unlock_bh(&vsock->send_pkt_list_lock);

-		headcount = get_rx_bufs(vq, vq->heads, vsock_hlen + pkt->len,
-				&in, likely(mergeable) ? UIO_MAXIOV : 1);
+		headcount = get_rx_bufs(vq, vq->heads + batch_count,
+				vsock_hlen + pkt->len, &in,
+				likely(mergeable) ? UIO_MAXIOV : 1);
 		if (headcount <= 0) {
 			spin_lock_bh(&vsock->send_pkt_list_lock);
 			list_add(&pkt->list, &vsock->send_pkt_list);
@@ -238,8 +241,12 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			break;
 		}

-		vhost_add_used_n(vq, vq->heads, headcount);
-		added = true;
+		batch_count += headcount;
+		if (batch_count > VHOST_VSOCK_BATCH) {
+			vhost_add_used_and_signal_n(&vsock->dev, vq,
+					vq->heads, batch_count);
+			batch_count = 0;
+		}

 		if (pkt->reply) {
 			int val;
@@ -258,8 +265,11 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,

 		virtio_transport_free_pkt(pkt);
 	}
-	if (added)
-		vhost_signal(&vsock->dev, vq);
+
+	if (batch_count) {
+		vhost_add_used_and_signal_n(&vsock->dev, vq,
+				vq->heads, batch_count);
+	}

 out:
 	mutex_unlock(&vq->mutex);
-- 
1.8.3.1
