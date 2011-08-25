From: Wang Sheng-Hui <shhuiw@gmail.com>
Subject: [PATCH] virtio.h: correct comment for struct virtio_driver
Date: Thu, 25 Aug 2011 21:04:05 +0800
Message-ID: <4E564845.3020209__39583.426496438$1314288265$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The patch is against 3.0.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
 include/linux/virtio.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 7108857..e0a1973 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -126,10 +126,10 @@ void unregister_virtio_device(struct virtio_device *dev);
  * virtio_driver - operations for a virtio I/O driver
  * @driver: underlying device driver (populate name and owner).
  * @id_table: the ids serviced by this driver.
- * @feature_table: an array of feature numbers supported by this device.
+ * @feature_table: an array of feature numbers supported by this driver.
  * @feature_table_size: number of entries in the feature table array.
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
- * @remove: the function when a device is removed.
+ * @remove: the function to call when a device is removed.
  * @config_changed: optional function to call when the device configuration
  *    changes; may be called in interrupt context.
  */
-- 
1.7.1
