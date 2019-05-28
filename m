From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 4/4] vsock/virtio: free used buffers during the .remove()
Date: Tue, 28 May 2019 12:56:23 +0200
Message-ID: <20190528105623.27983-5-sgarzare__20441.2932785758$1559041127$gmane$org@redhat.com>
References: <20190528105623.27983-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190528105623.27983-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Before this patch, we only freed unused buffers, but there may
still be used buffers to be freed.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index ad093ce96693..6a2afb989562 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -669,6 +669,18 @@ static void virtio_vsock_flush_works(struct virtio_vsock *vsock)
 	flush_work(&vsock->send_pkt_work);
 }
 
+static void virtio_vsock_free_buf(struct virtqueue *vq)
+{
+	struct virtio_vsock_pkt *pkt;
+	unsigned int len;
+
+	while ((pkt = virtqueue_detach_unused_buf(vq)))
+		virtio_transport_free_pkt(pkt);
+
+	while ((pkt = virtqueue_get_buf(vq, &len)))
+		virtio_transport_free_pkt(pkt);
+}
+
 static void virtio_vsock_remove(struct virtio_device *vdev)
 {
 	struct virtio_vsock *vsock = vdev->priv;
@@ -702,13 +714,11 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	vdev->config->reset(vdev);
 
 	mutex_lock(&vsock->rx_lock);
-	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
-		virtio_transport_free_pkt(pkt);
+	virtio_vsock_free_buf(vsock->vqs[VSOCK_VQ_RX]);
 	mutex_unlock(&vsock->rx_lock);
 
 	mutex_lock(&vsock->tx_lock);
-	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_TX])))
-		virtio_transport_free_pkt(pkt);
+	virtio_vsock_free_buf(vsock->vqs[VSOCK_VQ_TX]);
 	mutex_unlock(&vsock->tx_lock);
 
 	spin_lock_bh(&vsock->send_pkt_list_lock);
-- 
2.20.1
