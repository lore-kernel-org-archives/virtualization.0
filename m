From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] iommu/virtio: Update to most recent specification
Date: Mon, 22 Jul 2019 15:40:07 +0100
Message-ID: <20190722144007.6437-1-jean-philippe__30348.745609966$1563995374$gmane$org@linaro.org>
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
To: mst@redhat.com, joro@8bytes.org
Cc: eric.auger@redhat.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Following specification review a few things were changed in v8 of the
virtio-iommu series [1], but have been omitted when merging the base
driver. Add them now:

* Remove the EXEC flag.
* Add feature bit for the MMIO flag.
* Change domain_bits to domain_range.
* Add NOMEM status flag.

[1] https://lore.kernel.org/linux-iommu/20190530170929.19366-1-jean-philippe.brucker@arm.com/

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c      | 40 ++++++++++++++++++++++---------
 include/uapi/linux/virtio_iommu.h | 32 ++++++++++++++-----------
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 433f4d2ee956..80a740df0737 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -2,7 +2,7 @@
 /*
  * Virtio driver for the paravirtualized IOMMU
  *
- * Copyright (C) 2018 Arm Limited
+ * Copyright (C) 2019 Arm Limited
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -47,7 +47,10 @@ struct viommu_dev {
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
 	u64				pgsize_bitmap;
-	u8				domain_bits;
+	u32				first_domain;
+	u32				last_domain;
+	/* Supported MAP flags */
+	u32				map_flags;
 	u32				probe_size;
 };
 
@@ -62,6 +65,7 @@ struct viommu_domain {
 	struct viommu_dev		*viommu;
 	struct mutex			mutex; /* protects viommu pointer */
 	unsigned int			id;
+	u32				map_flags;
 
 	spinlock_t			mappings_lock;
 	struct rb_root_cached		mappings;
@@ -113,6 +117,8 @@ static int viommu_get_req_errno(void *buf, size_t len)
 		return -ENOENT;
 	case VIRTIO_IOMMU_S_FAULT:
 		return -EFAULT;
+	case VIRTIO_IOMMU_S_NOMEM:
+		return -ENOMEM;
 	case VIRTIO_IOMMU_S_IOERR:
 	case VIRTIO_IOMMU_S_DEVERR:
 	default:
@@ -607,15 +613,15 @@ static int viommu_domain_finalise(struct viommu_dev *viommu,
 {
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
-	unsigned int max_domain = viommu->domain_bits > 31 ? ~0 :
-				  (1U << viommu->domain_bits) - 1;
 
 	vdomain->viommu		= viommu;
+	vdomain->map_flags	= viommu->map_flags;
 
 	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
 	domain->geometry	= viommu->geometry;
 
-	ret = ida_alloc_max(&viommu->domain_ids, max_domain, GFP_KERNEL);
+	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
+			      viommu->last_domain, GFP_KERNEL);
 	if (ret >= 0)
 		vdomain->id = (unsigned int)ret;
 
@@ -710,7 +716,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 		      phys_addr_t paddr, size_t size, int prot)
 {
 	int ret;
-	int flags;
+	u32 flags;
 	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -718,6 +724,9 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 		(prot & IOMMU_WRITE ? VIRTIO_IOMMU_MAP_F_WRITE : 0) |
 		(prot & IOMMU_MMIO ? VIRTIO_IOMMU_MAP_F_MMIO : 0);
 
+	if (flags & ~vdomain->map_flags)
+		return -EINVAL;
+
 	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
 	if (ret)
 		return ret;
@@ -1027,7 +1036,8 @@ static int viommu_probe(struct virtio_device *vdev)
 		goto err_free_vqs;
 	}
 
-	viommu->domain_bits = 32;
+	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
+	viommu->last_domain = ~0U;
 
 	/* Optional features */
 	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
@@ -1038,9 +1048,13 @@ static int viommu_probe(struct virtio_device *vdev)
 			     struct virtio_iommu_config, input_range.end,
 			     &input_end);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_BITS,
-			     struct virtio_iommu_config, domain_bits,
-			     &viommu->domain_bits);
+	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+			     struct virtio_iommu_config, domain_range.start,
+			     &viommu->first_domain);
+
+	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+			     struct virtio_iommu_config, domain_range.end,
+			     &viommu->last_domain);
 
 	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
 			     struct virtio_iommu_config, probe_size,
@@ -1052,6 +1066,9 @@ static int viommu_probe(struct virtio_device *vdev)
 		.force_aperture	= true,
 	};
 
+	if (virtio_has_feature(vdev, VIRTIO_IOMMU_F_MMIO))
+		viommu->map_flags |= VIRTIO_IOMMU_MAP_F_MMIO;
+
 	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
 
 	virtio_device_ready(vdev);
@@ -1130,9 +1147,10 @@ static void viommu_config_changed(struct virtio_device *vdev)
 
 static unsigned int features[] = {
 	VIRTIO_IOMMU_F_MAP_UNMAP,
-	VIRTIO_IOMMU_F_DOMAIN_BITS,
 	VIRTIO_IOMMU_F_INPUT_RANGE,
+	VIRTIO_IOMMU_F_DOMAIN_RANGE,
 	VIRTIO_IOMMU_F_PROBE,
+	VIRTIO_IOMMU_F_MMIO,
 };
 
 static struct virtio_device_id id_table[] = {
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index ba1b460c9944..237e36a280cb 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
 /*
- * Virtio-iommu definition v0.9
+ * Virtio-iommu definition v0.12
  *
- * Copyright (C) 2018 Arm Ltd.
+ * Copyright (C) 2019 Arm Ltd.
  */
 #ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
 #define _UAPI_LINUX_VIRTIO_IOMMU_H
@@ -11,26 +11,31 @@
 
 /* Feature bits */
 #define VIRTIO_IOMMU_F_INPUT_RANGE		0
-#define VIRTIO_IOMMU_F_DOMAIN_BITS		1
+#define VIRTIO_IOMMU_F_DOMAIN_RANGE		1
 #define VIRTIO_IOMMU_F_MAP_UNMAP		2
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
+#define VIRTIO_IOMMU_F_MMIO			5
 
-struct virtio_iommu_range {
-	__u64					start;
-	__u64					end;
+struct virtio_iommu_range_64 {
+	__le64					start;
+	__le64					end;
+};
+
+struct virtio_iommu_range_32 {
+	__le32					start;
+	__le32					end;
 };
 
 struct virtio_iommu_config {
 	/* Supported page sizes */
-	__u64					page_size_mask;
+	__le64					page_size_mask;
 	/* Supported IOVA range */
-	struct virtio_iommu_range		input_range;
+	struct virtio_iommu_range_64		input_range;
 	/* Max domain ID size */
-	__u8					domain_bits;
-	__u8					padding[3];
+	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
-	__u32					probe_size;
+	__le32					probe_size;
 };
 
 /* Request types */
@@ -49,6 +54,7 @@ struct virtio_iommu_config {
 #define VIRTIO_IOMMU_S_RANGE			0x05
 #define VIRTIO_IOMMU_S_NOENT			0x06
 #define VIRTIO_IOMMU_S_FAULT			0x07
+#define VIRTIO_IOMMU_S_NOMEM			0x08
 
 struct virtio_iommu_req_head {
 	__u8					type;
@@ -78,12 +84,10 @@ struct virtio_iommu_req_detach {
 
 #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
-#define VIRTIO_IOMMU_MAP_F_EXEC			(1 << 2)
-#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 3)
+#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
 
 #define VIRTIO_IOMMU_MAP_F_MASK			(VIRTIO_IOMMU_MAP_F_READ |	\
 						 VIRTIO_IOMMU_MAP_F_WRITE |	\
-						 VIRTIO_IOMMU_MAP_F_EXEC |	\
 						 VIRTIO_IOMMU_MAP_F_MMIO)
 
 struct virtio_iommu_req_map {
-- 
2.22.0
