From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5/8] virtio_net: add request_vqs/free_vqs calls
Date: Mon, 27 Apr 2009 15:32:50 +0300
Message-ID: <20090427123250.GA1183__3696.31358557871$1240856100$gmane$org@redhat.com>
References: <cover.1240832196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1240832196.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add request_vqs/free_vqs calls to virtio_net.
These will be required for MSI support.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9c82a39..fbe8a70 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -841,6 +841,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	int err;
 	struct net_device *dev;
 	struct virtnet_info *vi;
+	bool control_vq;
 
 	/* Allocate ourselves a network device with room for our info */
 	dev = alloc_etherdev(sizeof(struct virtnet_info));
@@ -901,11 +902,17 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi->mergeable_rx_bufs = true;
 
-	/* We expect two virtqueues, receive then send. */
+	/* We expect either two or three virtqueues: receive, send and
+	 * optionally control. */
+	control_vq = virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ);
+	err = virtio_request_vqs(vdev, control_vq ? 3 : 2);
+	if (err)
+		goto free;
+
 	vi->rvq = vdev->config->find_vq(vdev, 0, skb_recv_done);
 	if (IS_ERR(vi->rvq)) {
 		err = PTR_ERR(vi->rvq);
-		goto free;
+		goto free_vqs;
 	}
 
 	vi->svq = vdev->config->find_vq(vdev, 1, skb_xmit_done);
@@ -914,7 +921,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_recv;
 	}
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
+	if (control_vq) {
 		vi->cvq = vdev->config->find_vq(vdev, 2, NULL);
 		if (IS_ERR(vi->cvq)) {
 			err = PTR_ERR(vi->svq);
@@ -965,6 +972,8 @@ free_send:
 	vdev->config->del_vq(vi->svq);
 free_recv:
 	vdev->config->del_vq(vi->rvq);
+free_vqs:
+	virtio_free_vqs(vi->vdev);
 free:
 	free_netdev(dev);
 	return err;
@@ -994,6 +1003,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	vdev->config->del_vq(vi->rvq);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ))
 		vdev->config->del_vq(vi->cvq);
+	virtio_free_vqs(vi->vdev);
 	unregister_netdev(vi->dev);
 
 	while (vi->pages)
-- 
1.6.0.6
