From: Sasha Levin <levinsasha928@gmail.com>
Subject: [PATCH 3/3] virtio-net: Use virtio_config_val() for retrieving config
Date: Sun, 14 Aug 2011 17:52:33 +0300
Message-ID: <1313333553-23086-3-git-send-email-levinsasha928__44038.5032831275$1313345725$gmane$org@gmail.com>
References: <1313333553-23086-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313333553-23086-1-git-send-email-levinsasha928@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch modifies virtio-net to use virtio_config_val() instead
of a 'if(virtio_has_feature()) vdev->config->get()' construct to retrieve
optional values from the config space.

Cc: Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 drivers/net/virtio_net.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0c7321c..878db50 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -902,12 +902,10 @@ static void virtnet_update_status(struct virtnet_info *vi)
 {
 	u16 v;
 
-	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS))
-		return;
-
-	vi->vdev->config->get(vi->vdev,
+	if (virtio_config_val(vi->vdev, VIRTIO_NET_F_STATUS,
 			      offsetof(struct virtio_net_config, status),
-			      &v, sizeof(v));
+			      &v) < 0)
+		return;
 
 	/* Ignore unknown (future) status bits */
 	v &= VIRTIO_NET_S_LINK_UP;
@@ -982,11 +980,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 
 	/* Configuration may specify what MAC to use.  Otherwise random. */
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
-		vdev->config->get(vdev,
+	if (virtio_config_val_len(vdev, VIRTIO_NET_F_MAC,
 				  offsetof(struct virtio_net_config, mac),
-				  dev->dev_addr, dev->addr_len);
-	} else
+				  dev->dev_addr, dev->addr_len) < 0)
 		random_ether_addr(dev->dev_addr);
 
 	/* Set up our device-specific information */
-- 
1.7.6
