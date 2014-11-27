From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 13/45] virtio: add legacy feature table support
Date: Thu, 27 Nov 2014 14:31:09 +0200
Message-ID: <1417091078-24611-14-git-send-email-mst__28225.0372846194$1417091557$gmane$org@redhat.com>
References: <1417091078-24611-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417091078-24611-1-git-send-email-mst@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, Pawel Moll <pawel.moll@arm.com>, rusty@au1.ibm.com, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

virtio-blk has some legacy feature bits that modern drivers
must not negotiate, but are needed for old legacy hosts
(that e.g. don't support virtio-scsi).
Allow a separate legacy feature table for such cases.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h  |  4 ++++
 drivers/virtio/virtio.c | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d6359a5..f70411e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -130,6 +130,8 @@ int virtio_device_restore(struct virtio_device *dev);
  * @id_table: the ids serviced by this driver.
  * @feature_table: an array of feature numbers supported by this driver.
  * @feature_table_size: number of entries in the feature table array.
+ * @feature_table_legacy: same as feature_table but when working in legacy mode.
+ * @feature_table_size_legacy: number of entries in feature table legacy array.
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @remove: the function to call when a device is removed.
  * @config_changed: optional function to call when the device configuration
@@ -140,6 +142,8 @@ struct virtio_driver {
 	const struct virtio_device_id *id_table;
 	const unsigned int *feature_table;
 	unsigned int feature_table_size;
+	const unsigned int *feature_table_legacy;
+	unsigned int feature_table_size_legacy;
 	int (*probe)(struct virtio_device *dev);
 	void (*scan)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 498bded..100b029 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -113,6 +113,13 @@ void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
 	for (i = 0; i < drv->feature_table_size; i++)
 		if (drv->feature_table[i] == fbit)
 			return;
+
+	if (drv->feature_table_legacy) {
+		for (i = 0; i < drv->feature_table_size_legacy; i++)
+			if (drv->feature_table_legacy[i] == fbit)
+				return;
+	}
+
 	BUG();
 }
 EXPORT_SYMBOL_GPL(virtio_check_driver_offered_feature);
@@ -161,6 +168,7 @@ static int virtio_dev_probe(struct device *_d)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	u64 device_features;
 	u64 driver_features;
+	u64 driver_features_legacy;
 	unsigned status;
 
 	/* We have a driver! */
@@ -177,7 +185,22 @@ static int virtio_dev_probe(struct device *_d)
 		driver_features |= (1ULL << f);
 	}
 
-	dev->features = driver_features & device_features;
+	/* Some drivers have a separate feature table for virtio v1.0 */
+	if (drv->feature_table_legacy) {
+		driver_features_legacy = 0;
+		for (i = 0; i < drv->feature_table_size_legacy; i++) {
+			unsigned int f = drv->feature_table_legacy[i];
+			BUG_ON(f >= 64);
+			driver_features_legacy |= (1ULL << f);
+		}
+	} else {
+		driver_features_legacy = driver_features;
+	}
+
+	if (driver_features & device_features & (1ULL << VIRTIO_F_VERSION_1))
+		dev->features = driver_features & device_features;
+	else
+		dev->features = driver_features_legacy & device_features;
 
 	/* Transport features always preserved to pass to finalize_features. */
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
-- 
MST
