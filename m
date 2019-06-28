From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 3/3] vsock/virtio: fix flush of works during the .remove()
Date: Fri, 28 Jun 2019 14:36:59 +0200
Message-ID: <20190628123659.139576-4-sgarzare__39930.0995910139$1561725478$gmane$org@redhat.com>
References: <20190628123659.139576-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190628123659.139576-1-sgarzare@redhat.com>
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

This patch moves the flush of works after vdev->config->del_vqs(vdev),
because we need to be sure that no workers run before to free the
'vsock' object.

Since we stopped the workers using the [tx|rx|event]_run flags,
we are sure no one is accessing the device while we are calling
vdev->config->reset(vdev), so we can safely move the workers' flush.

Before the vdev->config->del_vqs(vdev), workers can be scheduled
by VQ callbacks, so we must flush them after del_vqs(), to avoid
use-after-free of 'vsock' object.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 1b44ec6f3f6c..96dafa978268 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -680,12 +680,6 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	rcu_assign_pointer(the_virtio_vsock, NULL);
 	synchronize_rcu();
 
-	flush_work(&vsock->loopback_work);
-	flush_work(&vsock->rx_work);
-	flush_work(&vsock->tx_work);
-	flush_work(&vsock->event_work);
-	flush_work(&vsock->send_pkt_work);
-
 	/* Reset all connected sockets when the device disappear */
 	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
 
@@ -740,6 +734,15 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
 
+	/* Other works can be queued before 'config->del_vqs()', so we flush
+	 * all works before to free the vsock object to avoid use after free.
+	 */
+	flush_work(&vsock->loopback_work);
+	flush_work(&vsock->rx_work);
+	flush_work(&vsock->tx_work);
+	flush_work(&vsock->event_work);
+	flush_work(&vsock->send_pkt_work);
+
 	mutex_unlock(&the_virtio_vsock_mutex);
 
 	kfree(vsock);
-- 
2.20.1
