From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v8 2/7] dt-bindings: virtio: Add virtio-pci-iommu node
Date: Thu, 30 May 2019 18:09:24 +0100
Message-ID: <20190530170929.19366-3-jean-philippe.brucker__23176.8949701049$1559236409$gmane$org@arm.com>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: joro@8bytes.org, mst@redhat.com
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, Lorenzo.Pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, bhelgaas@google.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

Some systems implement virtio-iommu as a PCI endpoint. The operating
system needs to discover the relationship between IOMMU and masters long
before the PCI endpoint gets probed. Add a PCI child node to describe the
virtio-iommu device.

The virtio-pci-iommu is conceptually split between a PCI programming
interface and a translation component on the parent bus. The latter
doesn't have a node in the device tree. The virtio-pci-iommu node
describes both, by linking the PCI endpoint to "iommus" property of DMA
master nodes and to "iommu-map" properties of bus nodes.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 .../devicetree/bindings/virtio/iommu.txt      | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt

diff --git a/Documentation/devicetree/bindings/virtio/iommu.txt b/Documentation/devicetree/bindings/virtio/iommu.txt
new file mode 100644
index 000000000000..2407fea0651c
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/iommu.txt
@@ -0,0 +1,66 @@
+* virtio IOMMU PCI device
+
+When virtio-iommu uses the PCI transport, its programming interface is
+discovered dynamically by the PCI probing infrastructure. However the
+device tree statically describes the relation between IOMMU and DMA
+masters. Therefore, the PCI root complex that hosts the virtio-iommu
+contains a child node representing the IOMMU device explicitly.
+
+Required properties:
+
+- compatible:	Should be "virtio,pci-iommu"
+- reg:		PCI address of the IOMMU. As defined in the PCI Bus
+		Binding reference [1], the reg property is a five-cell
+		address encoded as (phys.hi phys.mid phys.lo size.hi
+		size.lo). phys.hi should contain the device's BDF as
+		0b00000000 bbbbbbbb dddddfff 00000000. The other cells
+		should be zero.
+- #iommu-cells:	Each platform DMA master managed by the IOMMU is assigned
+		an endpoint ID, described by the "iommus" property [2].
+		For virtio-iommu, #iommu-cells must be 1.
+
+Notes:
+
+- DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
+  virtio-iommu node doesn't have an "iommus" property, and is omitted from
+  the iommu-map property of the root complex.
+
+Example:
+
+pcie@10000000 {
+	compatible = "pci-host-ecam-generic";
+	...
+
+	/* The IOMMU programming interface uses slot 00:01.0 */
+	iommu0: iommu@0008 {
+		compatible = "virtio,pci-iommu";
+		reg = <0x00000800 0 0 0 0>;
+		#iommu-cells = <1>;
+	};
+
+	/*
+	 * The IOMMU manages all functions in this PCI domain except
+	 * itself. Omit BDF 00:01.0.
+	 */
+	iommu-map = <0x0 &iommu0 0x0 0x8>
+		    <0x9 &iommu0 0x9 0xfff7>;
+};
+
+pcie@20000000 {
+	compatible = "pci-host-ecam-generic";
+	...
+	/*
+	 * The IOMMU also manages all functions from this domain,
+	 * with endpoint IDs 0x10000 - 0x1ffff
+	 */
+	iommu-map = <0x0 &iommu0 0x10000 0x10000>;
+};
+
+ethernet@fe001000 {
+	...
+	/* The IOMMU manages this platform device with endpoint ID 0x20000 */
+	iommus = <&iommu0 0x20000>;
+};
+
+[1] Documentation/devicetree/bindings/pci/pci.txt
+[2] Documentation/devicetree/bindings/iommu/iommu.txt
-- 
2.21.0
