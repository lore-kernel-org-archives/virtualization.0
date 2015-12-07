From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: [PATCH RFC 0/3] Xen on Virtio
Date: Mon, 7 Dec 2015 16:19:26 +0000
Message-ID: <alpine.DEB.2.02.1512071555590.24652__12072.8009184406$1449505806$gmane$org@kaball.uk.xensource.com>
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
To: mst@redhat.com
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

this patch series introduces support for running Linux on top of Xen
inside a virtual machine with virtio devices (nested virt scenario).
The problem is that Linux virtio drivers use virt_to_phys to get the
guest pseudo-physical addresses to pass to the backend, which doesn't
work as expected on Xen.

Switching the virtio drivers to the dma APIs (dma_alloc_coherent,
dma_map/unmap_single and dma_map/unmap_sg) would solve the problem, as
Xen support in Linux provides an implementation of the dma API which
takes care of the additional address conversions. However using the dma
API would increase the complexity of the non-Xen case too. We would also
need to keep track of the physical or virtual address in addition to the
dma address for each vring_desc to be able to free the memory in
detach_buf (see patch #3).

Instead this series adds few obvious checks to perform address
translations in a couple of key places, without changing non-Xen code
paths. You are welcome to suggest improvements or alternative
implementations.

Thanks,

Stefano


Stefano Stabellini (3):
      xen: export xen_phys_to_bus, xen_bus_to_phys and xen_virt_to_bus
      xen/virtio: allocate a contiguous region to be use as virtio queue
      xen/virtio_ring: introduce cpu_to_virtio_addr and virtio_addr_to_cpu

 drivers/virtio/virtio_pci_legacy.c |   19 +++++++++++++++----
 drivers/virtio/virtio_ring.c       |    9 +++++----
 drivers/xen/swiotlb-xen.c          |   31 -------------------------------
 include/linux/virtio_config.h      |   14 ++++++++++++++
 include/xen/swiotlb-xen.h          |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 39 deletions(-)
