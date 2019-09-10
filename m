From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 2/4] mdev: introduce helper to set per device dma ops
Date: Tue, 10 Sep 2019 16:19:33 +0800
Message-ID: <20190910081935.30516-3-jasowang__20997.4855811865$1568103637$gmane$org@redhat.com>
References: <20190910081935.30516-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190910081935.30516-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: idos@mellanox.com, cohuck@redhat.com, kwankhede@nvidia.com, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com, xiao.w.wang@intel.com, zhihong.wang@intel.com, haotian.wang@sifive.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces mdev_set_dma_ops() which allows parent to set
per device DMA ops. This help for the kernel driver to setup a correct
DMA mappings.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vfio/mdev/mdev_core.c | 7 +++++++
 include/linux/mdev.h          | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index b558d4cfd082..eb28552082d7 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -13,6 +13,7 @@
 #include <linux/uuid.h>
 #include <linux/sysfs.h>
 #include <linux/mdev.h>
+#include <linux/dma-mapping.h>
 
 #include "mdev_private.h"
 
@@ -27,6 +28,12 @@ static struct class_compat *mdev_bus_compat_class;
 static LIST_HEAD(mdev_list);
 static DEFINE_MUTEX(mdev_list_lock);
 
+void mdev_set_dma_ops(struct mdev_device *mdev, struct dma_map_ops *ops)
+{
+	set_dma_ops(&mdev->dev, ops);
+}
+EXPORT_SYMBOL(mdev_set_dma_ops);
+
 struct device *mdev_parent_dev(struct mdev_device *mdev)
 {
 	return mdev->parent->dev;
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 0ce30ca78db0..7195f40bf8bf 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -145,4 +145,6 @@ struct device *mdev_parent_dev(struct mdev_device *mdev);
 struct device *mdev_dev(struct mdev_device *mdev);
 struct mdev_device *mdev_from_dev(struct device *dev);
 
+void mdev_set_dma_ops(struct mdev_device *mdev, struct dma_map_ops *ops);
+
 #endif /* MDEV_H */
-- 
2.19.1
