From: Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 0/2] VMD endpoint passthrough support
Date: Mon, 11 May 2020 15:01:26 -0400
Message-ID: <20200511190129.9313-1-jonathan.derrick@intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, Jon Derrick <jonathan.derrick@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This set contains 2 patches for Linux and 1 for QEMU. VMD device
8086:28C0 contains information in registers to assist with direct
assignment passthrough. Several other VMD devices don't have this
information, but can easily be emulated to offer this feature.

The existing VMD devices not supporting the feature cannot be changed to
offer the information, but also don't restrict the ability to offer this
information in emulation by the hypervisor. Future VMD devices will
offer the 28C0 mode natively.

The QEMU patch emulates the hardware assistance that the VMD 28C0 device
provides: a config space register claiming passthrough support, and the
shadow membar registers containing the host information for guest
address assignment in the VMD domain. These VMD devices have this config
space register set as reserved and will not conflict with the emulated
bit.

The Linux patch allows guest kernels to use the passthrough information
emulated by the QEMU patch, by matching the config space register
claiming passthrough support.

Changes from v1:
v1 changed the VMD Subsystem ID to QEMU's so that the guest driver could
match against it. This was unnecessary as the VMLOCK register and shadow
membar registers could be safely emulated. Future VMDs will be aligned
on these register bits.

Added the resource bit filtering patch that got lost in the mailserver.

v1: https://lore.kernel.org/linux-pci/20200422171444.10992-1-jonathan.derrick@intel.com/

Jon Derrick (2):
  PCI: vmd: Filter resource type bits from shadow register
  PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.18.1
