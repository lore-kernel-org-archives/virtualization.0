From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 48/50] virtio_balloon: add legacy_only flag
Date: Mon, 1 Dec 2014 18:06:50 +0200
Message-ID: <1417449619-24896-49-git-send-email-mst@redhat.com>
References: <1417449619-24896-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417449619-24896-1-git-send-email-mst@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

We have no plans to support virtio 1.0 in balloon driver.  Add an
explicit flag to mark it legacy only.

This will be used by follow-up patches.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h          | 2 ++
 drivers/virtio/virtio_balloon.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index f70411e..2bbf626 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -132,6 +132,7 @@ int virtio_device_restore(struct virtio_device *dev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
+ * @legacy_only: driver does not support virtio 1.0.
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @remove: the function to call when a device is removed.
  * @config_changed: optional function to call when the device configuration
@@ -144,6 +145,7 @@ struct virtio_driver {
 	unsigned int feature_table_size;
 	const unsigned int *feature_table_legacy;
 	unsigned int feature_table_size_legacy;
+	bool legacy_only;
 	int (*probe)(struct virtio_device *dev);
 	void (*scan)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c9703d4..4497def 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -518,6 +518,7 @@ static unsigned int features[] = {
 };
 
 static struct virtio_driver virtio_balloon_driver = {
+	.legacy_only = true,
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name =	KBUILD_MODNAME,
-- 
MST
