From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH 0/2] virtio: Support encrypted memory on powerpc secure guests
Date: Fri, 11 Oct 2019 18:25:17 -0700
Message-ID: <1570843519-8696-1-git-send-email-linuxram__11374.98104233$1570844076$gmane$org@us.ibm.com>
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
To: linux-kernel@vger.kernel.org
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, robin.murphy@arm.com, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

 **We would like the patches to be merged through the virtio tree.  Please
 review, and ack merging the DMA mapping change through that tree. Thanks!**

 The memory of powerpc secure guests can't be accessed by the hypervisor /
 virtio device except for a few memory regions designated as 'shared'.
 
 At the moment, Linux uses bounce-buffering to communicate with the
 hypervisor, with a bounce buffer marked as shared. This is how the DMA API
 is implemented on this platform.
 
 In particular, the most convenient way to use virtio on this platform is by
 making virtio use the DMA API: in fact, this is exactly what happens if the
 virtio device exposes the flag VIRTIO_F_ACCESS_PLATFORM.  However, bugs in the
 hypervisor on the powerpc platform do not allow setting this flag, with some
 hypervisors already in the field that don't set this flag. At the moment they
 are forced to use emulated devices when guest is in secure mode; virtio is
 only useful when guest is not secure.
 
 Normally, both device and driver must support VIRTIO_F_ACCESS_PLATFORM:
 if one of them doesn't, the other mustn't assume it for communication
 to work.
 
 However, a guest-side work-around is possible to enable virtio
 for these hypervisors with guest in secure mode: it so happens that on
 powerpc secure platform the DMA address is actually a physical address -
 that of the bounce buffer. For these platforms we can make the virtio
 driver go through the DMA API even though the device itself ignores
 the DMA API.
 
 These patches implement this work around for virtio: we detect that
 - secure guest mode is enabled - so we know that since we don't share
   most memory and Hypervisor has not enabled VIRTIO_F_ACCESS_PLATFORM,
   regular virtio code won't work.
 - DMA API is giving us addresses that are actually also physical
   addresses.
 - Hypervisor has not enabled VIRTIO_F_ACCESS_PLATFORM.
 
 and if all conditions are true, we force all data through the bounce
 buffer.
 
 To put it another way, from hypervisor's point of view DMA API is
 not required: hypervisor would be happy to get access to all of guest
 memory. That's why it does not set VIRTIO_F_ACCESS_PLATFORM. However,
 guest decides that it does not trust the hypervisor and wants to force
 a bounce buffer for its own reasons.


Thiago Jung Bauermann (2):
  dma-mapping: Add dma_addr_is_phys_addr()
  virtio_ring: Use DMA API if memory is encrypted

 arch/powerpc/include/asm/dma-mapping.h | 21 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig |  1 +
 drivers/virtio/virtio.c                | 18 ++++++++++++++++++
 drivers/virtio/virtio_ring.c           |  8 ++++++++
 include/linux/dma-mapping.h            | 20 ++++++++++++++++++++
 include/linux/virtio_config.h          | 14 ++++++++++++++
 kernel/dma/Kconfig                     |  3 +++
 7 files changed, 85 insertions(+)

-- 
1.8.3.1
