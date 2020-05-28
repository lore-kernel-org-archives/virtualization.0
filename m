From: Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3 0/2] VMD endpoint passthrough support
Date: Wed, 27 May 2020 23:02:37 -0400
Message-ID: <20200528030240.16024-1-jonathan.derrick@intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jon Derrick <jonathan.derrick@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This set contains 2 patches for Linux and 1 for QEMU. VMD device
8086:28C0 contains information in registers to assist with direct
assignment passthrough. Several other VMD devices don't have this
information, but hypervisors can easily provide the guest with this
information through various means.

The QEMU patch provides the information in an emulated vendor-specific
PCI capability. Existing VMD devices don't conflict with the offset
chosen for the capability.

The Linux patch allows guest kernels to use the passthrough information
emulated by the QEMU patch, by matching against the vendor-specific PCI
capability if it exists.

V2 Ref:
https://lore.kernel.org/linux-pci/20200511190129.9313-1-jonathan.derrick@intel.com/

Changes from v2:
Uses vendor-specific PCI capability rather than emulating the 28C0
MEMBAR/VMLOCK modes.

Changes from v1:
v1 changed the VMD Subsystem ID to QEMU's so that the guest driver could
match against it. This was unnecessary as the VMLOCK register and shadow
membar registers could be safely emulated. Future VMDs will be aligned
on these register bits.

Jon Derrick (2):
  PCI: vmd: Filter resource type bits from shadow register
  PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

-- 
1.8.3.1
