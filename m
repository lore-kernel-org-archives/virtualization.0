From: Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/1] KVM support for VMD devices
Date: Wed, 22 Apr 2020 13:14:44 -0400
Message-ID: <20200422171444.10992-1-jonathan.derrick@intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, qemu-devel@nongnu.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrzej Jakowski <andrzej.jakowski@intel.com>, Jon Derrick <jonathan.derrick@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

The two patches (Linux & QEMU) add support for passthrough VMD devices
in QEMU/KVM. VMD device 28C0 already supports passthrough natively by
providing the Host Physical Address in a shadow register to the guest
for correct bridge programming.

The QEMU patch emulates the 28C0 mode by creating a shadow register and
advertising its support by using QEMU's subsystem vendor/id.
The Linux patch matches the QEMU subsystem vendor/id to use the shadow
register.

Jon Derrick (1):
  pci: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.18.1
