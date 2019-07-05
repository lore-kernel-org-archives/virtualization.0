From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 2/3] vsock/virtio: stop workers during the .remove()
Date: Fri,  5 Jul 2019 13:04:53 +0200
Message-ID: <20190705110454.95302-3-sgarzare__24471.1842316732$1562324725$gmane$org@redhat.com>
References: <20190705110454.95302-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190705110454.95302-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Before to call vdev->config->reset(vdev) we need to be sure that
no one is accessing the device, for this reason, we add new variables
in the struct virtio_vsock to stop the workers during the .remove().

This patch also add few comments before vdev->config->reset(vdev)
and vdev->config->del_vqs(vdev).

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 51 +++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 3eaec60aa64f..4dbdce7746bd 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -38,6 +38,7 @@ struct virtio_vsock {
 	 * must be accessed with tx_lock held.
 	 */
 	struct mutex tx_lock;
+	bool tx_run;
 
 	struct work_struct send_pkt_work;
 	spinlock_t send_pkt_list_lock;
@@ -53,6 +54,7 @@ struct virtio_vsock {
 	 * must be accessed with rx_lock held.
 	 */
 	struct mutex rx_lock;
+	bool rx_run;
 	int rx_buf_nr;
 	int rx_buf_max_nr;
 
@@ -60,6 +62,7 @@ struct virtio_vsock {
 	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
 	 */
 	struct mutex event_lock;
+	bool event_run;
 	struct virtio_vsock_event event_list[8];
 
 	u32 guest_cid;
@@ -94,6 +97,10 @@ static void virtio_transport_loopback_work(struct work_struct *work)
 	spin_unlock_bh(&vsock->loopback_list_lock);
 
 	mutex_lock(&vsock->rx_lock);
+
+	if (!vsock->rx_run)
+		goto out;
+
 	while (!list_empty(&pkts)) {
 		struct virtio_vsock_pkt *pkt;
 
@@ -102,6 +109,7 @@ static void virtio_transport_loopback_work(struct work_struct *work)
 
 		virtio_transport_recv_pkt(pkt);
 	}
+out:
 	mutex_unlock(&vsock->rx_lock);
 }
 
@@ -130,6 +138,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 
 	mutex_lock(&vsock->tx_lock);
 
+	if (!vsock->tx_run)
+		goto out;
+
 	vq = vsock->vqs[VSOCK_VQ_TX];
 
 	for (;;) {
@@ -188,6 +199,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 	if (added)
 		virtqueue_kick(vq);
 
+out:
 	mutex_unlock(&vsock->tx_lock);
 
 	if (restart_rx)
@@ -323,6 +335,10 @@ static void virtio_transport_tx_work(struct work_struct *work)
 
 	vq = vsock->vqs[VSOCK_VQ_TX];
 	mutex_lock(&vsock->tx_lock);
+
+	if (!vsock->tx_run)
+		goto out;
+
 	do {
 		struct virtio_vsock_pkt *pkt;
 		unsigned int len;
@@ -333,6 +349,8 @@ static void virtio_transport_tx_work(struct work_struct *work)
 			added = true;
 		}
 	} while (!virtqueue_enable_cb(vq));
+
+out:
 	mutex_unlock(&vsock->tx_lock);
 
 	if (added)
@@ -361,6 +379,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
 	mutex_lock(&vsock->rx_lock);
 
+	if (!vsock->rx_run)
+		goto out;
+
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
@@ -470,6 +491,9 @@ static void virtio_transport_event_work(struct work_struct *work)
 
 	mutex_lock(&vsock->event_lock);
 
+	if (!vsock->event_run)
+		goto out;
+
 	do {
 		struct virtio_vsock_event *event;
 		unsigned int len;
@@ -484,7 +508,7 @@ static void virtio_transport_event_work(struct work_struct *work)
 	} while (!virtqueue_enable_cb(vq));
 
 	virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
-
+out:
 	mutex_unlock(&vsock->event_lock);
 }
 
@@ -620,12 +644,18 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 	INIT_WORK(&vsock->loopback_work, virtio_transport_loopback_work);
 
+	mutex_lock(&vsock->tx_lock);
+	vsock->tx_run = true;
+	mutex_unlock(&vsock->tx_lock);
+
 	mutex_lock(&vsock->rx_lock);
 	virtio_vsock_rx_fill(vsock);
+	vsock->rx_run = true;
 	mutex_unlock(&vsock->rx_lock);
 
 	mutex_lock(&vsock->event_lock);
 	virtio_vsock_event_fill(vsock);
+	vsock->event_run = true;
 	mutex_unlock(&vsock->event_lock);
 
 	vdev->priv = vsock;
@@ -660,6 +690,24 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	/* Reset all connected sockets when the device disappear */
 	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
 
+	/* Stop all work handlers to make sure no one is accessing the device,
+	 * so we can safely call vdev->config->reset().
+	 */
+	mutex_lock(&vsock->rx_lock);
+	vsock->rx_run = false;
+	mutex_unlock(&vsock->rx_lock);
+
+	mutex_lock(&vsock->tx_lock);
+	vsock->tx_run = false;
+	mutex_unlock(&vsock->tx_lock);
+
+	mutex_lock(&vsock->event_lock);
+	vsock->event_run = false;
+	mutex_unlock(&vsock->event_lock);
+
+	/* Flush all device writes and interrupts, device will not use any
+	 * more buffers.
+	 */
 	vdev->config->reset(vdev);
 
 	mutex_lock(&vsock->rx_lock);
@@ -690,6 +738,7 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	}
 	spin_unlock_bh(&vsock->loopback_list_lock);
 
+	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
-- 
2.20.1
