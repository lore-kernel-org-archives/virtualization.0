From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 0/6] virtio core DMA API conversion
Date: Thu, 29 Oct 2015 18:09:45 -0700
Message-ID: <cover.1446162273.git.luto__30026.9227278934$1446420945$gmane$org@kernel.org>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This switches virtio to use the DMA API unconditionally.  I'm sure
it breaks things, but it seems to work on x86 using virtio-pci, with
and without Xen, and using both the modern 1.0 variant and the
legacy variant.

This appears to work on native and Xen x86_64 using both modern and
legacy virtio-pci.  It also appears to work on arm and arm64.

It definitely won't work as-is on s390x, and I haven't been able to
test Christian's patches because I can't get virtio-ccw to work in
QEMU at all.  I don't know what I'm doing wrong.

It doesn't work on ppc64.  Ben, consider yourself pinged to send me
a patch :)

It doesn't work on sparc64.  I didn't realize at Kernel Summit that
sparc64 has the same problem as ppc64.

DaveM, for background, we're trying to fix virtio to use the DMA
API.  That will require that every platform that uses virtio
supplies valid DMA operations on devices that use virtio_ring.
Unfortunately, QEMU historically ignores the IOMMU on virtio
devices.

On x86, this isn't really a problem.  x86 has a nice way for the
platform to describe which devices are behind an IOMMU, and QEMU
will be adjusted accordingly.  The only thing that will break is a
recently-added experimental mode.

Ben's plan for powerpc is to add a quirk for existing virtio-pci
devices and to eventually update the devicetree stuff to allow QEMU
to tell the guest which devices use the IOMMU.

AFAICT sparc has a similar problem to powerpc.  DaveM, can you come
up with a straightforward way to get sparc's DMA API to work
correctly for virtio-pci devices?

NB: Sadly, the platforms I've successfully tested on don't include any
big-endian platforms, so there could still be lurking endian problems.

Changes from v3:
 - More big-endian fixes.
 - Added better virtio-ring APIs that handle allocation and use them in
   virtio-mmio and virtio-pci.
 - Switch to Michael's virtio-net patch.

Changes from v2:
 - Fix vring_mapping_error incorrect argument

Changes from v1:
 - Fix an endian conversion error causing a BUG to hit.
 - Fix a DMA ordering issue (swiotlb=force works now).
 - Minor cleanups.

Andy Lutomirski (5):
  virtio_ring: Support DMA APIs
  virtio_pci: Use the DMA API
  virtio: Add improved queue allocation API
  virtio_mmio: Use the DMA API
  virtio_pci: Use the DMA API

Michael S. Tsirkin (1):
  virtio-net: Stop doing DMA from the stack

 drivers/net/virtio_net.c           |  34 ++--
 drivers/virtio/Kconfig             |   2 +-
 drivers/virtio/virtio_mmio.c       |  67 ++-----
 drivers/virtio/virtio_pci_common.h |   6 -
 drivers/virtio/virtio_pci_legacy.c |  42 ++---
 drivers/virtio/virtio_pci_modern.c |  61 ++-----
 drivers/virtio/virtio_ring.c       | 348 ++++++++++++++++++++++++++++++-------
 include/linux/virtio.h             |  23 ++-
 include/linux/virtio_ring.h        |  35 ++++
 tools/virtio/linux/dma-mapping.h   |  17 ++
 10 files changed, 426 insertions(+), 209 deletions(-)
 create mode 100644 tools/virtio/linux/dma-mapping.h

-- 
2.4.3
