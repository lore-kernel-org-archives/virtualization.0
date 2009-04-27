From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/8] virtio-rng: add request_vqs/free_vqs calls
Date: Mon, 27 Apr 2009 15:32:26 +0300
Message-ID: <20090427123226.GA1175__38459.9812016406$1240856030$gmane$org@redhat.com>
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

Add request_vqs/free_vqs calls to virtio-rng.
These will be required for MSI support.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index d0e563e..d43a6cd 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -94,13 +94,20 @@ static int virtrng_probe(struct virtio_device *vdev)
 	int err;
 
 	/* We expect a single virtqueue. */
+	err = virtio_request_vqs(vdev, 1);
+	if (err)
+		return err;
+
 	vq = vdev->config->find_vq(vdev, 0, random_recv_done);
-	if (IS_ERR(vq))
+	if (IS_ERR(vq)) {
+		virtio_free_vqs(vdev);
 		return PTR_ERR(vq);
+	}
 
 	err = hwrng_register(&virtio_hwrng);
 	if (err) {
 		vdev->config->del_vq(vq);
+		virtio_free_vqs(vdev);
 		return err;
 	}
 
@@ -113,6 +120,7 @@ static void virtrng_remove(struct virtio_device *vdev)
 	vdev->config->reset(vdev);
 	hwrng_unregister(&virtio_hwrng);
 	vdev->config->del_vq(vq);
+	virtio_free_vqs(vdev);
 }
 
 static struct virtio_device_id id_table[] = {
-- 
1.6.0.6
