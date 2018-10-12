From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
Date: Fri, 12 Oct 2018 15:59:13 +0100
Message-ID: <20181012145917.6840-4-jean-philippe.brucker__48423.4247393489$1539356403$gmane$org@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, mst@redhat.com, marc.zyngier@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com, robh+dt@kernel.org, robin.murphy@arm.com, joro@8bytes.org
List-Id: virtualization@lists.linuxfoundation.org

Using the iommu-map binding, endpoints in a given PCI domain can be
managed by different IOMMUs. Some virtual machines may allow a subset of
endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
PCI root complex has an iommu-map property, the driver requires all
endpoints to be described by the property. Allow the iommu-map property to
have gaps.

Relaxing of_pci_map_rid also allows the msi-map property to have gaps,
which is invalid since MSIs always reach an MSI controller. Thankfully
Linux will error out later, when attempting to find an MSI domain for the
device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/of.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 1836b8ddf292..2f5015bdb256 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -451,9 +451,10 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
 		return 0;
 	}
 
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
+	/* Bypasses translation */
+	if (id_out)
+		*id_out = rid;
+	return 0;
 }
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.19.1
