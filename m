From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC 1/3] virtio-iommu: firmware description of the virtual topology
Date: Fri,  7 Apr 2017 20:17:45 +0100
Message-ID: <20170407191747.26618-2-jean-philippe.brucker__38031.8755437203$1491592803$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Unlike other virtio devices, the virtio-iommu doesn't work independently,
it is linked to other virtual or assigned devices. So before jumping into
device operations, we need to define a way for the guest to discover the
virtual IOMMU and the devices it translates.

The host must describe the relation between IOMMU and devices to the guest
using either device-tree or ACPI. The virtual IOMMU identifies each
virtual device with a 32-bit ID, that we will call "Device ID" in this
document. Device IDs are not necessarily unique system-wide, but they may
not overlap within a single virtual IOMMU. Device ID of passed-through
devices do not need to match IDs seen by the physical IOMMU.

The virtual IOMMU uses virtio-mmio transport exclusively, not virtio-pci,
because with PCI the IOMMU interface would itself be an endpoint, and
existing firmware interfaces don't allow to describe IOMMU<->master
relations between PCI endpoints.

The following diagram describes a situation where two virtual IOMMUs
translate traffic from devices in the system. vIOMMU 1 translates two PCI
domains, in which each function has a 16-bits requester ID. In order for
the vIOMMU to differentiate guest requests targeted at devices in each
domain, their Device ID ranges cannot overlap. vIOMMU 2 translates two PCI
domains and a collection of platform devices.

                       Device ID    Requester ID
                  /       0x0           0x0      \
                 /         |             |        PCI domain 1
                /      0xffff           0xffff   /
        vIOMMU 1
                \     0x10000           0x0      \
                 \         |             |        PCI domain 2
                  \   0x1ffff           0xffff   /

                  /       0x0                    \
                 /         |                      platform devices
                /      0x1fff                    /
        vIOMMU 2
                \      0x2000           0x0      \
                 \         |             |        PCI domain 3
                  \   0x11fff           0xffff   /

Device-tree already offers a way to describe the topology. Here's an
example description of vIOMMU 2 with its devices:

	/* The virtual IOMMU is described with a virtio-mmio node */
	viommu2: virtio@10000 {
		compatible = "virtio,mmio";
		reg = <0x10000 0x200>;
		dma-coherent;
		interrupts = <0x0 0x5 0x1>;
		
		#iommu-cells = <1>
	};
	
	/* Some platform device has Device ID 0x5 */
	somedevice@20000 {
		...
		
		iommus = <&viommu2 0x5>;
	};
	
	/*
	 * PCI domain 3 is described by its host controller node, along
	 * with the complete relation to the IOMMU
	 */
	pci {
		...
		/* Linear map between RIDs and Device IDs for the whole bus */
		iommu-map = <0x0 &viommu2 0x10000 0x10000>;
	};

For more details, please refer to [DT-IOMMU].

For ACPI, we expect to add a new node type to the IO Remapping Table
specification [IORT], providing a similar mechanism for describing
translations via ACPI tables. The following is *not* a specification,
simply an example of what the node could be.

         Field      | Len.  | Off.  | Description
    ----------------|-------|-------|---------------------------------
     Type           | 1     | 0     | 5: paravirtualized IOMMU
     Length         | 2     | 1     | The length of the node.
     Revision       | 1     | 3     | 0
     Reserved       | 4     | 4     | Must be zero.
     Number of ID   | 4     | 8     |
       mappings     |       |       |
     Reference to   | 4     | 12    | Offset from the start of the
       ID Array     |       |       | IORT node to the start of its
                    |       |       | Array ID mappings.
                    |       |       |
     Model          | 4     | 16    | 0: virtio-iommu
     Device object  | --    | 20    | ASCII Null terminated string
       name         |       |       | with the full path to the entry
                    |       |       | in the namespace for this IOMMU.
     Padding        | --    | --    | To keep 32-bit alignment and
                    |       |       | leave space for future models.
                    |       |       |
     Array of ID    |       |       |
       mappings     | 20xN  | --    | ID Array.

The OS parses the IORT table to build a map of ID relations between IOMMU
and devices. ID Array is used to find correspondence between IOMMU IDs and
PCI or platform devices. Later on, the virtio-iommu driver finds the
associated LNRO0005 descriptor via the "Device object name" field, and
probes the virtio device to find out more about its capabilities. Since
all properties of the IOMMU will be obtained during virtio probing, the
IORT node can stay simple.

[DT-IOMMU] https://www.kernel.org/doc/Documentation/devicetree/bindings/iommu/iommu.txt
           https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-iommu.txt

[IORT] IO Remapping Table, DEN0049B
       http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
