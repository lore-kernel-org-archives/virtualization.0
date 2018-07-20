From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [RFC 0/4] Virtio uses DMA API for all devices
Date: Fri, 20 Jul 2018 09:29:37 +0530
Message-ID: <20180720035941.6844-1-khandual__31267.3335116871$1532059073$gmane$org@linux.vnet.ibm.com>
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
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, benh@kernel.crashing.org, linuxram@us.ibm.com, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

This patch series is the follow up on the discussions we had before about
the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
for virito devices (https://patchwork.kernel.org/patch/10417371/). There
were suggestions about doing away with two different paths of transactions
with the host/QEMU, first being the direct GPA and the other being the DMA
API based translations.

First patch attempts to create a direct GPA mapping based DMA operations
structure called 'virtio_direct_dma_ops' with exact same implementation
of the direct GPA path which virtio core currently has but just wrapped in
a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
existing semantics. The second patch does exactly that inside the function
virtio_finalize_features(). The third patch removes the default direct GPA
path from virtio core forcing it to use DMA API callbacks for all devices.
Now with that change, every device must have a DMA operations structure
associated with it. The fourth patch adds an additional hook which gives
the platform an opportunity to do yet another override if required. This
platform hook can be used on POWER Ultravisor based protected guests to
load up SWIOTLB DMA callbacks to do the required (as discussed previously
in the above mentioned thread how host is allowed to access only parts of
the guest GPA range) bounce buffering into the shared memory for all I/O
scatter gather buffers to be consumed on the host side.

Please go through these patches and review whether this approach broadly
makes sense. I will appreciate suggestions, inputs, comments regarding
the patches or the approach in general. Thank you.

Anshuman Khandual (4):
  virtio: Define virtio_direct_dma_ops structure
  virtio: Override device's DMA OPS with virtio_direct_dma_ops selectively
  virtio: Force virtio core to use DMA API callbacks for all virtio devices
  virtio: Add platform specific DMA API translation for virito devices

 arch/powerpc/include/asm/dma-mapping.h |  6 +++
 arch/powerpc/platforms/pseries/iommu.c |  6 +++
 drivers/virtio/virtio.c                | 72 ++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h     |  3 ++
 drivers/virtio/virtio_ring.c           | 65 +-----------------------------
 5 files changed, 89 insertions(+), 63 deletions(-)

-- 
2.9.3
