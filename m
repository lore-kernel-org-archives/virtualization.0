From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 6/6] virtio: drop legacy_only driver flag
Date: Mon, 8 Dec 2014 15:06:10 +0200
Message-ID: <1418042769-25539-7-git-send-email-mst@redhat.com>
References: <1418042769-25539-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418042769-25539-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: dahi@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

legacy_only flag is now unused, drop it from core.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h  | 2 --
 drivers/virtio/virtio.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d666bcb..d09e093 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -134,7 +134,6 @@ int virtio_device_restore(struct virtio_device *dev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
- * @legacy_only: driver does not support virtio 1.0.
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @remove: the function to call when a device is removed.
  * @config_changed: optional function to call when the device configuration
@@ -147,7 +146,6 @@ struct virtio_driver {
 	unsigned int feature_table_size;
 	const unsigned int *feature_table_legacy;
 	unsigned int feature_table_size_legacy;
-	bool legacy_only;
 	int (*probe)(struct virtio_device *dev);
 	void (*scan)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index e1673a5..f226658 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -198,10 +198,6 @@ static int virtio_dev_probe(struct device *_d)
 		driver_features_legacy = driver_features;
 	}
 
-	/* Detect legacy-only drivers and disable VIRTIO_F_VERSION_1. */
-	if (drv->legacy_only)
-		device_features &= ~(1ULL << VIRTIO_F_VERSION_1);
-
 	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
 		dev->features = driver_features & device_features;
 	else
-- 
MST
