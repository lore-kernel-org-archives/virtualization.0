From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/4] vsock/virtio: fix flush of works during the .remove()
Date: Tue, 28 May 2019 12:56:22 +0200
Message-ID: <20190528105623.27983-4-sgarzare__14075.7496048295$1559041113$gmane$org@redhat.com>
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

We flush all pending works before to call vdev->config->reset(vdev),
but other works can be queued before the vdev->config->del_vqs(vdev),
so we add another flush after it, to avoid use after free.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index e694df10ab61..ad093ce96693 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -660,6 +660,15 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	return ret;
 }
 
+static void virtio_vsock_flush_works(struct virtio_vsock *vsock)
+{
+	flush_work(&vsock->loopback_work);
+	flush_work(&vsock->rx_work);
+	flush_work(&vsock->tx_work);
+	flush_work(&vsock->event_work);
+	flush_work(&vsock->send_pkt_work);
+}
+
 static void virtio_vsock_remove(struct virtio_device *vdev)
 {
 	struct virtio_vsock *vsock = vdev->priv;
@@ -668,12 +677,6 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	mutex_lock(&the_virtio_vsock_mutex);
 	the_virtio_vsock = NULL;
 
-	flush_work(&vsock->loopback_work);
-	flush_work(&vsock->rx_work);
-	flush_work(&vsock->tx_work);
-	flush_work(&vsock->event_work);
-	flush_work(&vsock->send_pkt_work);
-
 	/* Reset all connected sockets when the device disappear */
 	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
 
@@ -690,6 +693,9 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	vsock->event_run = false;
 	mutex_unlock(&vsock->event_lock);
 
+	/* Flush all pending works */
+	virtio_vsock_flush_works(vsock);
+
 	/* Flush all device writes and interrupts, device will not use any
 	 * more buffers.
 	 */
@@ -726,6 +732,11 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
 
+	/* Other works can be queued before 'config->del_vqs()', so we flush
+	 * all works before to free the vsock object to avoid use after free.
+	 */
+	virtio_vsock_flush_works(vsock);
+
 	kfree(vsock);
 	mutex_unlock(&the_virtio_vsock_mutex);
 }
-- 
2.20.1
