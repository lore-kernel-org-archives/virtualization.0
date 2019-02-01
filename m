From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 1/2] vsock/virtio: fix kernel panic after device hot-unplug
Date: Fri,  1 Feb 2019 12:42:06 +0100
Message-ID: <20190201114207.97217-2-sgarzare__31837.393895124$1555717103$gmane$org@redhat.com>
References: <20190201114207.97217-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190201114207.97217-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_vsock_remove() invokes the vsock_core_exit() also if there
are opened sockets for the AF_VSOCK protocol family. In this way
the vsock "transport" pointer is set to NULL, triggering the
kernel panic at the first socket activity.

This patch move the vsock_core_init()/vsock_core_exit() in the
virtio_vsock respectively in module_init and module_exit functions,
that cannot be invoked until there are open sockets.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1609699
Reported-by: Yan Fu <yafu@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5d3cce9e8744..9dae54698737 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -75,6 +75,9 @@ static u32 virtio_transport_get_local_cid(void)
 {
 	struct virtio_vsock *vsock = virtio_vsock_get();
 
+	if (!vsock)
+		return VMADDR_CID_ANY;
+
 	return vsock->guest_cid;
 }
 
@@ -584,10 +587,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	virtio_vsock_update_guest_cid(vsock);
 
-	ret = vsock_core_init(&virtio_transport.transport);
-	if (ret < 0)
-		goto out_vqs;
-
 	vsock->rx_buf_nr = 0;
 	vsock->rx_buf_max_nr = 0;
 	atomic_set(&vsock->queued_replies, 0);
@@ -618,8 +617,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	mutex_unlock(&the_virtio_vsock_mutex);
 	return 0;
 
-out_vqs:
-	vsock->vdev->config->del_vqs(vsock->vdev);
 out:
 	kfree(vsock);
 	mutex_unlock(&the_virtio_vsock_mutex);
@@ -669,7 +666,6 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 
 	mutex_lock(&the_virtio_vsock_mutex);
 	the_virtio_vsock = NULL;
-	vsock_core_exit();
 	mutex_unlock(&the_virtio_vsock_mutex);
 
 	vdev->config->del_vqs(vdev);
@@ -702,14 +698,28 @@ static int __init virtio_vsock_init(void)
 	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", 0, 0);
 	if (!virtio_vsock_workqueue)
 		return -ENOMEM;
+
 	ret = register_virtio_driver(&virtio_vsock_driver);
 	if (ret)
-		destroy_workqueue(virtio_vsock_workqueue);
+		goto out_wq;
+
+	ret = vsock_core_init(&virtio_transport.transport);
+	if (ret)
+		goto out_vdr;
+
+	return 0;
+
+out_vdr:
+	unregister_virtio_driver(&virtio_vsock_driver);
+out_wq:
+	destroy_workqueue(virtio_vsock_workqueue);
 	return ret;
+
 }
 
 static void __exit virtio_vsock_exit(void)
 {
+	vsock_core_exit();
 	unregister_virtio_driver(&virtio_vsock_driver);
 	destroy_workqueue(virtio_vsock_workqueue);
 }
-- 
2.20.1
