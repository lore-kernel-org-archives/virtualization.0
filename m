From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 09/11] virtio: net: Add freeze,
	restore handlers to support S4
Date: Thu, 17 Nov 2011 17:27:40 +0530
Message-ID: <85eca44fe83d2deabfdf402bfed72531ebad6026.1321530505.git.amit.shah@redhat.com>
References: <cover.1321530505.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1321530505.git.amit.shah@redhat.com>
In-Reply-To: <cover.1321530505.git.amit.shah@redhat.com>
References: <cover.1321530505.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Remove all the vqs and detach from the netdev on hibernation.

Re-create vqs after restoring from a hibernated image and re-attach the
netdev.  This keeps networking working across hibernation.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/net/virtio_net.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fbff37a..167b555 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1127,6 +1127,9 @@ static void remove_vq_common(struct virtnet_info *vi)
 {
 	cancel_delayed_work_sync(&vi->refill);
 
+	/* Stop all the virtqueues. */
+	vi->vdev->config->reset(vi->vdev);
+
 	/* Free unused buffers in both send and recv, if any. */
 	free_unused_bufs(vi);
 
@@ -1140,9 +1143,6 @@ static void __devexit virtnet_remove(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
 
-	/* Stop all the virtqueues. */
-	vdev->config->reset(vdev);
-
 	unregister_netdev(vi->dev);
 
 	remove_vq_common(vi);
@@ -1151,6 +1151,33 @@ static void __devexit virtnet_remove(struct virtio_device *vdev)
 	free_netdev(vi->dev);
 }
 
+#ifdef CONFIG_PM
+static int virtnet_freeze(struct virtio_device *vdev)
+{
+	struct virtnet_info *vi = vdev->priv;
+
+	netif_device_detach(vi->dev);
+	remove_vq_common(vi);
+
+	return 0;
+}
+
+static int virtnet_restore(struct virtio_device *vdev)
+{
+	struct virtnet_info *vi = vdev->priv;
+	int err;
+
+	err = init_vqs(vi);
+	if (err)
+		return err;
+
+	try_fill_recv(vi, GFP_KERNEL);
+
+	netif_device_attach(vi->dev);
+	return 0;
+}
+#endif
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -1175,6 +1202,10 @@ static struct virtio_driver virtio_net_driver = {
 	.probe =	virtnet_probe,
 	.remove =	__devexit_p(virtnet_remove),
 	.config_changed = virtnet_config_changed,
+#ifdef CONFIG_PM
+	.freeze =	virtnet_freeze,
+	.restore =	virtnet_restore,
+#endif
 };
 
 static int __init init(void)
-- 
1.7.7.1
