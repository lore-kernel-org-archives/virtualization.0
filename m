From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 3/7] of: Allow the iommu-map property to omit untranslated
	devices
Date: Thu, 15 Nov 2018 16:52:30 +0000
Message-ID: <20181115165234.43990-4-jean-philippe.brucker__31183.4156899296$1542301193$gmane$org@arm.com>
References: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com, eric.auger@redhat.com, robh+dt@kernel.org, bhelgaas@google.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

In PCI root complex nodes, the iommu-map property describes the IOMMU that
translates each endpoint. On some platforms, the IOMMU itself is presented
as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). This isn't supported
by the current OF driver, which expects all endpoints to have an IOMMU.
Allow the iommu-map property to have gaps.

Relaxing of_map_rid() also allows the msi-map property to have gaps, which
is invalid since MSIs always reach an MSI controller. In that case
pci_msi_setup_msi_irqs() will return an error when attempting to find the
device's MSI domain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/of/base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..99f6bfa9b898 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2237,8 +2237,12 @@ int of_map_rid(struct device_node *np, u32 rid,
 		return 0;
 	}
 
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
+	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
+		rid, target && *target ? *target : NULL);
+
+	/* Bypasses translation */
+	if (id_out)
+		*id_out = rid;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_rid);
-- 
2.19.1
