From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] virtio_blk: Use sysfs_match_string() helper
Date: Fri,  9 Jun 2017 15:07:42 +0300
Message-ID: <20170609120742.21959-1-andriy.shevchenko@linux.intel.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Use sysfs_match_string() helper instead of open coded variant.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/virtio_blk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 553cc4c542b4..0e707b8cce9d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -541,12 +541,9 @@ virtblk_cache_type_store(struct device *dev, struct device_attribute *attr,
 	int i;
 
 	BUG_ON(!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_CONFIG_WCE));
-	for (i = ARRAY_SIZE(virtblk_cache_types); --i >= 0; )
-		if (sysfs_streq(buf, virtblk_cache_types[i]))
-			break;
-
+	i = sysfs_match_string(virtblk_cache_types, buf);
 	if (i < 0)
-		return -EINVAL;
+		return i;
 
 	virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
 	virtblk_update_cache_mode(vdev);
-- 
2.11.0
