From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6/8] virtio_balloon: add request_vqs/free_vqs calls
Date: Mon, 27 Apr 2009 15:33:02 +0300
Message-ID: <20090427123302.GA1186__15447.1591733911$1240856225$gmane$org@redhat.com>
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

Add request_vqs/free_vqs calls to virtio_balloon.
These will be required for MSI support.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5926826..77eac2b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -217,10 +217,14 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	vb->vdev = vdev;
 
 	/* We expect two virtqueues. */
+	err = virtio_request_vqs(vdev, 2);
+	if (err)
+		goto out_free_vb;
+
 	vb->inflate_vq = vdev->config->find_vq(vdev, 0, balloon_ack);
 	if (IS_ERR(vb->inflate_vq)) {
 		err = PTR_ERR(vb->inflate_vq);
-		goto out_free_vb;
+		goto out_free_vqs;
 	}
 
 	vb->deflate_vq = vdev->config->find_vq(vdev, 1, balloon_ack);
@@ -244,6 +248,8 @@ out_del_deflate_vq:
 	vdev->config->del_vq(vb->deflate_vq);
 out_del_inflate_vq:
 	vdev->config->del_vq(vb->inflate_vq);
+out_free_vqs:
+	virtio_free_vqs(vdev);
 out_free_vb:
 	kfree(vb);
 out:
@@ -265,6 +271,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 
 	vdev->config->del_vq(vb->deflate_vq);
 	vdev->config->del_vq(vb->inflate_vq);
+	virtio_free_vqs(vdev);
 	kfree(vb);
 }
 
-- 
1.6.0.6
