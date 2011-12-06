From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v4 08/12] virtio: net: Move out vq and vq buf removal into
	separate function
Date: Wed,  7 Dec 2011 01:18:46 +0530
Message-ID: <28a1941cb8173a4633076a7646fceb4463f05175.1323199985.git.amit.shah@redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1323199985.git.amit.shah@redhat.com>
In-Reply-To: <cover.1323199985.git.amit.shah@redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, levinsasha928@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The remove and PM freeze functions will share this code.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/net/virtio_net.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6baa563..697a0fc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1123,24 +1123,29 @@ static void free_unused_bufs(struct virtnet_info *vi)
 	BUG_ON(vi->num != 0);
 }
 
-static void __devexit virtnet_remove(struct virtio_device *vdev)
+static void remove_vq_common(struct virtnet_info *vi)
 {
-	struct virtnet_info *vi = vdev->priv;
-
 	/* Stop all the virtqueues. */
-	vdev->config->reset(vdev);
-
+	vi->vdev->config->reset(vi->vdev);
 
-	unregister_netdev(vi->dev);
 	cancel_delayed_work_sync(&vi->refill);
 
 	/* Free unused buffers in both send and recv, if any. */
 	free_unused_bufs(vi);
 
-	vdev->config->del_vqs(vi->vdev);
+	vi->vdev->config->del_vqs(vi->vdev);
 
 	while (vi->pages)
 		__free_pages(get_a_page(vi, GFP_KERNEL), 0);
+}
+
+static void __devexit virtnet_remove(struct virtio_device *vdev)
+{
+	struct virtnet_info *vi = vdev->priv;
+
+	unregister_netdev(vi->dev);
+
+	remove_vq_common(vi);
 
 	free_percpu(vi->stats);
 	free_netdev(vi->dev);
-- 
1.7.7.3
