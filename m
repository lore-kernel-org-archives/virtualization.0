From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v6 07/11] virtio: net: Move vq initialization into separate
	function
Date: Thu, 22 Dec 2011 16:58:31 +0530
Message-ID: <e6161695ce252f328d7616b5f3d2bf88edcf60b6.1324553223.git.amit.shah@redhat.com>
References: <cover.1324553223.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1324553223.git.amit.shah@redhat.com>
In-Reply-To: <cover.1324553223.git.amit.shah@redhat.com>
References: <cover.1324553223.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The probe and PM restore functions will share this code.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/net/virtio_net.c |   47 +++++++++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1b67e8a..ec8c400 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -966,15 +966,38 @@ static void virtnet_config_changed(struct virtio_device *vdev)
 	virtnet_update_status(vi);
 }
 
+static int init_vqs(struct virtnet_info *vi)
+{
+	struct virtqueue *vqs[3];
+	vq_callback_t *callbacks[] = { skb_recv_done, skb_xmit_done, NULL};
+	const char *names[] = { "input", "output", "control" };
+	int nvqs, err;
+
+	/* We expect two virtqueues, receive then send,
+	 * and optionally control. */
+	nvqs = virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ) ? 3 : 2;
+
+	err = vi->vdev->config->find_vqs(vi->vdev, nvqs, vqs, callbacks, names);
+	if (err)
+		return err;
+
+	vi->rvq = vqs[0];
+	vi->svq = vqs[1];
+
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
+		vi->cvq = vqs[2];
+
+		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
+			vi->dev->features |= NETIF_F_HW_VLAN_FILTER;
+	}
+	return 0;
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int err;
 	struct net_device *dev;
 	struct virtnet_info *vi;
-	struct virtqueue *vqs[3];
-	vq_callback_t *callbacks[] = { skb_recv_done, skb_xmit_done, NULL};
-	const char *names[] = { "input", "output", "control" };
-	int nvqs;
 
 	/* Allocate ourselves a network device with room for our info */
 	dev = alloc_etherdev(sizeof(struct virtnet_info));
@@ -1046,24 +1069,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi->mergeable_rx_bufs = true;
 
-	/* We expect two virtqueues, receive then send,
-	 * and optionally control. */
-	nvqs = virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ) ? 3 : 2;
-
-	err = vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names);
+	err = init_vqs(vi);
 	if (err)
 		goto free_stats;
 
-	vi->rvq = vqs[0];
-	vi->svq = vqs[1];
-
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
-		vi->cvq = vqs[2];
-
-		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
-			dev->features |= NETIF_F_HW_VLAN_FILTER;
-	}
-
 	err = register_netdev(dev);
 	if (err) {
 		pr_debug("virtio_net: registering device failed\n");
-- 
1.7.7.4
