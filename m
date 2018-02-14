From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 4/4] vfio: Allow type-1 IOMMU instantiation with a virtio-iommu
Date: Wed, 14 Feb 2018 14:53:40 +0000
Message-ID: <20180214145340.1223-5-jean-philippe.brucker__42574.5669207119$1518620032$gmane$org@arm.com>
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, kvmarm@lists.cs.columbia.edu
Cc: jayachandran.nair@cavium.com, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, mst@redhat.com, marc.zyngier@arm.com, will.deacon@arm.com, jintack@cs.columbia.edu, eric.auger@redhat.com, robin.murphy@arm.com, joro@8bytes.org, eric.auger.pro@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

When enabling both VFIO and VIRTIO_IOMMU modules, automatically select
VFIO_IOMMU_TYPE1 as well.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index c84333eb5eb5..65a1e691110c 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -21,7 +21,7 @@ config VFIO_VIRQFD
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
-	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
+	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3 || VIRTIO_IOMMU)
 	select ANON_INODES
 	help
 	  VFIO provides a framework for secure userspace device drivers.
-- 
2.16.1
