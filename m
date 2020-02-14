From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] iommu/virtio: Build virtio-iommu as module
Date: Fri, 14 Feb 2020 17:38:27 +0100
Message-ID: <20200214163827.1606668-1-jean-philippe@linaro.org>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Cc: joro@8bytes.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Now that the infrastructure changes are in place, enable virtio-iommu to
be built as a module. Remove the redundant pci_request_acs() call, since
it's not exported but is already invoked during DMA setup.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
This conflicts with the multiplatform work [1] since they both change
Kconfig. Locally I have this patch applied on top of that series but
there is no functional dependency between the two.

[1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
---
 drivers/iommu/Kconfig        | 4 ++--
 drivers/iommu/virtio-iommu.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index adcbda44d473..bfd4e5fcd6aa 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -506,8 +506,8 @@ config HYPERV_IOMMU
 	  guests to run with x2APIC mode enabled.
 
 config VIRTIO_IOMMU
-	bool "Virtio IOMMU driver"
-	depends on VIRTIO=y
+	tristate "Virtio IOMMU driver"
+	depends on VIRTIO
 	depends on (ARM64 || X86)
 	select IOMMU_API
 	select IOMMU_DMA
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f18ba8e22ebd..5429c12c879b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1084,7 +1084,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &viommu_ops) {
-		pci_request_acs();
 		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
 		if (ret)
 			goto err_unregister;
-- 
2.25.0
