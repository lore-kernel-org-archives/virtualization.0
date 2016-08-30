From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/2] vfio: report group noiommu status
Date: Tue, 30 Aug 2016 05:27:14 +0300
Message-ID: <1472523968-9540-2-git-send-email-mst@redhat.com>
References: <1472523968-9540-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1472523968-9540-1-git-send-email-mst@redhat.com>
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When using vfio, callers might want to know whether device is added
to a regular group or an non-iommu group.

Report this status from vfio_is_noiommu_group_dev.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/vfio.h |  2 ++
 drivers/vfio/vfio.c  | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0ecae0b..584757b 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -51,6 +51,8 @@ extern int vfio_add_group_dev(struct device *dev,
 			      const struct vfio_device_ops *ops,
 			      void *device_data);
 
+extern bool vfio_is_noiommu_group_dev(struct device *dev);
+
 extern void *vfio_del_group_dev(struct device *dev);
 extern struct vfio_device *vfio_device_get_from_dev(struct device *dev);
 extern void vfio_device_put(struct vfio_device *device);
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index d1d70e0..22f279f 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -872,6 +872,18 @@ static bool vfio_dev_present(struct vfio_group *group, struct device *dev)
 }
 
 /*
+ * Is device part of a noiommu group?
+ * Note: must call vfio_add_group_dev first.
+ */
+bool vfio_is_noiommu_group_dev(struct device *dev)
+{
+	struct vfio_device *device = dev_get_drvdata(dev);
+	struct vfio_group *group = device->group;
+
+	return group->noiommu;
+}
+
+/*
  * Decrement the device reference count and wait for the device to be
  * removed.  Open file descriptors for the device... */
 void *vfio_del_group_dev(struct device *dev)
-- 
MST
