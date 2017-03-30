From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] virtio: virtio_driver doc
Date: Thu, 30 Mar 2017 13:13:33 +0200
Message-ID: <20170330111333.47725-3-cornelia.huck__36926.9773051657$1490872448$gmane$org@de.ibm.com>
References: <20170330111333.47725-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170330111333.47725-1-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add comments for the virtio_driver members that were not documented.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/linux/virtio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 8f4d4bf..e80adf2 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -133,9 +133,13 @@ int virtio_device_restore(struct virtio_device *dev);
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
+ * @scan: optional function to call after successful probe; intended
+ *    for virtio-scsi to invoke a scan.
  * @remove: the function to call when a device is removed.
  * @config_changed: optional function to call when the device configuration
  *    changes; may be called in interrupt context.
+ * @freeze: optional function to call during suspend/hibernation.
+ * @restore: optional function to call on resume.
  */
 struct virtio_driver {
 	struct device_driver driver;
-- 
2.8.4
