From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 1/3] iommu/virtio: Fix sparse warning
Date: Thu, 26 Mar 2020 10:35:56 +0100
Message-ID: <20200326093558.2641019-2-jean-philippe@linaro.org>
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200326093558.2641019-1-jean-philippe@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kbuild test robot <lkp@intel.com>, mst@redhat.com, joro@8bytes.org, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, bbhushan2@marvell.com
List-Id: virtualization@lists.linuxfoundation.org

We copied the virtio_iommu_config from the virtio-iommu specification,
which declares the fields using little-endian annotations (for example
le32). Unfortunately this causes sparse to warn about comparison between
little- and cpu-endian, because of the typecheck() in virtio_cread():

drivers/iommu/virtio-iommu.c:1024:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1024:9: sparse:    restricted __le64 *
drivers/iommu/virtio-iommu.c:1024:9: sparse:    unsigned long long *
drivers/iommu/virtio-iommu.c:1036:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1036:9: sparse:    restricted __le64 *
drivers/iommu/virtio-iommu.c:1036:9: sparse:    unsigned long long *
drivers/iommu/virtio-iommu.c:1040:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1040:9: sparse:    restricted __le64 *
drivers/iommu/virtio-iommu.c:1040:9: sparse:    unsigned long long *
drivers/iommu/virtio-iommu.c:1044:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1044:9: sparse:    restricted __le32 *
drivers/iommu/virtio-iommu.c:1044:9: sparse:    unsigned int *
drivers/iommu/virtio-iommu.c:1048:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1048:9: sparse:    restricted __le32 *
drivers/iommu/virtio-iommu.c:1048:9: sparse:    unsigned int *
drivers/iommu/virtio-iommu.c:1052:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1052:9: sparse:    restricted __le32 *
drivers/iommu/virtio-iommu.c:1052:9: sparse:    unsigned int *

Although virtio_cread() does convert virtio-endian (in our case
little-endian) to cpu-endian, the typecheck() needs the two arguments to
have the same endianness. Do as UAPI headers of other virtio devices do,
and remove the endian annotation from the device config.

Even though we change the UAPI this shouldn't cause any regression since
QEMU, the existing implementation of virtio-iommu that uses this header,
already removes the annotations when importing headers.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..48e3c29223b5 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -18,24 +18,24 @@
 #define VIRTIO_IOMMU_F_MMIO			5
 
 struct virtio_iommu_range_64 {
-	__le64					start;
-	__le64					end;
+	__u64					start;
+	__u64					end;
 };
 
 struct virtio_iommu_range_32 {
-	__le32					start;
-	__le32					end;
+	__u32					start;
+	__u32					end;
 };
 
 struct virtio_iommu_config {
 	/* Supported page sizes */
-	__le64					page_size_mask;
+	__u64					page_size_mask;
 	/* Supported IOVA range */
 	struct virtio_iommu_range_64		input_range;
 	/* Max domain ID size */
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
-	__le32					probe_size;
+	__u32					probe_size;
 };
 
 /* Request types */
-- 
2.25.1
