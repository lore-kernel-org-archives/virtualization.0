From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 02/13] ACPI: Add VIOT definitions
Date: Fri, 22 Nov 2019 11:49:49 +0100
Message-ID: <20191122105000.800410-3-jean-philippe__370.966659259864$1574419883$gmane$org@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, gregkh@linuxfoundation.org, joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net, eric.auger@redhat.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, guohanjun@huawei.com, bhelgaas@google.com, lenb@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This is temporary, until the VIOT table is published and these
definitions added to ACPICA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/actbl2.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e45ced27f4c3..99c1d747e9d8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -25,6 +25,7 @@
  * the wrong signature.
  */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
+#define ACPI_SIG_VIOT           "VIOT"	/* Virtual I/O Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
@@ -412,6 +413,36 @@ struct acpi_ivrs_memory {
 	u64 memory_length;
 };
 
+/*******************************************************************************
+ *
+ * VIOT - Virtual I/O Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_viot {
+	struct acpi_table_header header;
+	u8 reserved[12];
+	struct acpi_table_header base_table;
+};
+
+#define ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU    0x80
+#define ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU   0x81
+
+struct acpi_viot_iort_virtio_pci_iommu {
+	u32 devid;
+};
+
+struct acpi_viot_iort_virtio_mmio_iommu {
+	u64 base_address;
+	u64 span;
+	u64 flags;
+	u64 interrupt;
+};
+
+/* FIXME: rename this monstrosity. */
+#define ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERENT (1<<0)
+
 /*******************************************************************************
  *
  * LPIT - Low Power Idle Table
-- 
2.24.0
