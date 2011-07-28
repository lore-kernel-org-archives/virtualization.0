From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 8/8] virtio: net: Add freeze,
	restore handlers to support S4
Date: Thu, 28 Jul 2011 20:05:13 +0530
Message-ID: <3d2fd91237cfb3ff1e05e464e305df2711b45885.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Remove all the vqs on hibernation and re-create them after restoring
from a hibernated image.  This keeps networking working across
hibernation.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/net/virtio_net.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0c7321c..c9aaa8f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1117,6 +1117,53 @@ static void __devexit virtnet_remove(struct virtio_device *vdev)
 	free_netdev(vi->dev);
 }
 
+#ifdef CONFIG_PM
+static int virtnet_freeze(struct virtio_device *vdev)
+{
+	struct virtnet_info *vi = vdev->priv;
+
+	cancel_delayed_work_sync(&vi->refill);
+
+	/* Free unused buffers in both send and recv, if any. */
+	free_unused_bufs(vi);
+
+	vdev->config->del_vqs(vi->vdev);
+
+	while (vi->pages)
+		__free_pages(get_a_page(vi, GFP_KERNEL), 0);
+
+	return 0;
+}
+
+static int virtnet_restore(struct virtio_device *vdev)
+{
+	struct virtnet_info *vi = vdev->priv;
+	struct virtqueue *vqs[3];
+	vq_callback_t *callbacks[] = { skb_recv_done, skb_xmit_done, NULL};
+	const char *names[] = { "input", "output", "control" };
+	int nvqs, err;
+
+	/* We expect two virtqueues, receive then send,
+	 * and optionally control. */
+	nvqs = virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ) ? 3 : 2;
+
+	err = vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names);
+	if (err)
+		return err;
+
+	vi->rvq = vqs[0];
+	vi->svq = vqs[1];
+
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
+		vi->cvq = vqs[2];
+	}
+
+	/* Last of all, set up some receive buffers. */
+	try_fill_recv(vi, GFP_KERNEL);
+	return 0;
+}
+#endif
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -1141,6 +1188,10 @@ static struct virtio_driver virtio_net_driver = {
 	.probe =	virtnet_probe,
 	.remove =	__devexit_p(virtnet_remove),
 	.config_changed = virtnet_config_changed,
+#ifdef CONFIG_PM
+	.freeze = 	virtnet_freeze,
+	.restore =	virtnet_restore,
+#endif
 };
 
 static int __init init(void)
-- 
1.7.6
