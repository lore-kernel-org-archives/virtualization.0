From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 5/5] virtio: rng: s3/s4 support
Date: Mon, 28 May 2012 12:18:43 +0530
Message-ID: <a64f97e41246436659905b1cff8d9ef49c1c2e2f.1338187342.git.amit.shah@redhat.com>
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

Unregister from the hwrng interface and remove the vq before entering
the S3 or S4 states.  Add the vq and re-register with hwrng on restore.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a9673a7..5708299 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -124,6 +124,19 @@ static void __devexit virtrng_remove(struct virtio_device *vdev)
 	remove_common(vdev);
 }
 
+#ifdef CONFIG_PM
+static int virtrng_freeze(struct virtio_device *vdev)
+{
+	remove_common(vdev);
+	return 0;
+}
+
+static int virtrng_restore(struct virtio_device *vdev)
+{
+	return probe_common(vdev);
+}
+#endif
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_RNG, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -135,6 +148,10 @@ static struct virtio_driver virtio_rng_driver = {
 	.id_table =	id_table,
 	.probe =	virtrng_probe,
 	.remove =	__devexit_p(virtrng_remove),
+#ifdef CONFIG_PM
+	.freeze =	virtrng_freeze,
+	.restore =	virtrng_restore,
+#endif
 };
 
 static int __init init(void)
-- 
1.7.7.6
