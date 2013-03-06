From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/1] virtio: rng: disallow multiple device registrations,
	fixes crashes
Date: Wed,  6 Mar 2013 13:43:45 +0530
Message-ID: <58c84c464bca72f80fec188f0ae0269058c6cf03.1362557573.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The code currently only supports one virtio-rng device at a time.
Invoking guests with multiple devices causes the guest to blow up.

Check if we've already registered and initialised the driver.  Also
cleanup in case of registration errors or hot-unplug so that a new
device can be used.

Reported-by: Peter Krempa <pkrempa@redhat.com>
Reported-by: <yunzheng@redhat.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---

Also valid for stable?

 drivers/char/hw_random/virtio-rng.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 10fd71c..6bf4d47 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -92,14 +92,22 @@ static int probe_common(struct virtio_device *vdev)
 {
 	int err;
 
+	if (vq) {
+		/* We only support one device for now */
+		return -EBUSY;
+	}
 	/* We expect a single virtqueue. */
 	vq = virtio_find_single_vq(vdev, random_recv_done, "input");
-	if (IS_ERR(vq))
-		return PTR_ERR(vq);
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
+		vq = NULL;
+		return err;
+	}
 
 	err = hwrng_register(&virtio_hwrng);
 	if (err) {
 		vdev->config->del_vqs(vdev);
+		vq = NULL;
 		return err;
 	}
 
@@ -112,6 +120,7 @@ static void remove_common(struct virtio_device *vdev)
 	busy = false;
 	hwrng_unregister(&virtio_hwrng);
 	vdev->config->del_vqs(vdev);
+	vq = NULL;
 }
 
 static int virtrng_probe(struct virtio_device *vdev)
-- 
1.8.1.2
