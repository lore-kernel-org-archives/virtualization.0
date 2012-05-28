From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 4/5] virtio: rng: split out common code in probe / remove for
	s3/s4 ops
Date: Mon, 28 May 2012 12:18:42 +0530
Message-ID: <4f3e1d4958c9394c83215c7491ec64537432a376.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The freeze/restore s3/s4 operations will use code that's common to the
probe and remove routines.  Put the common code in separate funcitons.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 2dc9ce1..a9673a7 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -88,7 +88,7 @@ static struct hwrng virtio_hwrng = {
 	.read		= virtio_read,
 };
 
-static int virtrng_probe(struct virtio_device *vdev)
+static int probe_common(struct virtio_device *vdev)
 {
 	int err;
 
@@ -106,7 +106,7 @@ static int virtrng_probe(struct virtio_device *vdev)
 	return 0;
 }
 
-static void __devexit virtrng_remove(struct virtio_device *vdev)
+static void remove_common(struct virtio_device *vdev)
 {
 	vdev->config->reset(vdev);
 	busy = false;
@@ -114,6 +114,16 @@ static void __devexit virtrng_remove(struct virtio_device *vdev)
 	vdev->config->del_vqs(vdev);
 }
 
+static int virtrng_probe(struct virtio_device *vdev)
+{
+	return probe_common(vdev);
+}
+
+static void __devexit virtrng_remove(struct virtio_device *vdev)
+{
+	remove_common(vdev);
+}
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_RNG, VIRTIO_DEV_ANY_ID },
 	{ 0 },
-- 
1.7.7.6
