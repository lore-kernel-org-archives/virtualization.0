From: Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [RFC PATCH kvmtool 00/15] Add virtio-iommu
Date: Mon, 22 May 2017 08:26:12 +0000
Message-ID: <AM5PR0401MB2545FADDF2A7649DF0DB68309AF80__38659.3223353431$1495441592$gmane$org@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Jean,

I am trying to run and review on my side but I see Linux patches are not with latest kernel version.
Will it be possible for you to share your Linux and kvmtool git repository reference?

Thanks
-Bharat

> -----Original Message-----
> From: virtualization-bounces@lists.linux-foundation.org
> [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf Of Jean-
> Philippe Brucker
> Sent: Saturday, April 08, 2017 12:55 AM
> To: iommu@lists.linux-foundation.org; kvm@vger.kernel.org;
> virtualization@lists.linux-foundation.org; virtio-dev@lists.oasis-open.org
> Cc: cdall@linaro.org; lorenzo.pieralisi@arm.com; mst@redhat.com;
> marc.zyngier@arm.com; joro@8bytes.org; will.deacon@arm.com;
> robin.murphy@arm.com
> Subject: [RFC PATCH kvmtool 00/15] Add virtio-iommu
> 
> Implement a virtio-iommu device and translate DMA traffic from vfio and
> virtio devices. Virtio needed some rework to support scatter-gather accesses
> to vring and buffers at page granularity. Patch 3 implements the actual virtio-
> iommu device.
> 
> Adding --viommu on the command-line now inserts a virtual IOMMU in front
> of all virtio and vfio devices:
> 
> 	$ lkvm run -k Image --console virtio -p console=hvc0 \
> 	           --viommu --vfio 0 --vfio 4 --irqchip gicv3-its
> 	...
> 	[    2.998949] virtio_iommu virtio0: probe successful
> 	[    3.007739] virtio_iommu virtio1: probe successful
> 	...
> 	[    3.165023] iommu: Adding device 0000:00:00.0 to group 0
> 	[    3.536480] iommu: Adding device 10200.virtio to group 1
> 	[    3.553643] iommu: Adding device 10600.virtio to group 2
> 	[    3.570687] iommu: Adding device 10800.virtio to group 3
> 	[    3.627425] iommu: Adding device 10a00.virtio to group 4
> 	[    7.823689] iommu: Adding device 0000:00:01.0 to group 5
> 	...
> 
> Patches 13 and 14 add debug facilities. Some statistics are gathered for each
> address space and can be queried via the debug builtin:
> 
> 	$ lkvm debug -n guest-1210 --iommu stats
> 	iommu 0 "viommu-vfio"
> 	  kicks                 1255
> 	  requests              1256
> 	  ioas 1
> 	    maps                7
> 	    unmaps              4
> 	    resident            2101248
> 	  ioas 6
> 	    maps                623
> 	    unmaps              620
> 	    resident            16384
> 	iommu 1 "viommu-virtio"
> 	  kicks                 11426
> 	  requests              11431
> 	  ioas 2
> 	    maps                2836
> 	    unmaps              2835
> 	    resident            8192
> 	    accesses            2836
> 	...
> 
> This is based on the VFIO patchset[1], itself based on Andre's ITS work.
> The VFIO bits have only been tested on a software model and are unlikely to
> work on actual hardware, but I also tested virtio on an ARM Juno.
> 
> [1] http://www.spinics.net/lists/kvm/msg147624.html
> 
> Jean-Philippe Brucker (15):
>   virtio: synchronize virtio-iommu headers with Linux
>   FDT: (re)introduce a dynamic phandle allocator
>   virtio: add virtio-iommu
>   Add a simple IOMMU
>   iommu: describe IOMMU topology in device-trees
>   irq: register MSI doorbell addresses
>   virtio: factor virtqueue initialization
>   virtio: add vIOMMU instance for virtio devices
>   virtio: access vring and buffers through IOMMU mappings
>   virtio-pci: translate MSIs with the virtual IOMMU
>   virtio: set VIRTIO_F_IOMMU_PLATFORM when necessary
>   vfio: add support for virtual IOMMU
>   virtio-iommu: debug via IPC
>   virtio-iommu: implement basic debug commands
>   virtio: use virtio-iommu when available
> 
>  Makefile                          |   3 +
>  arm/gic.c                         |   4 +
>  arm/include/arm-common/fdt-arch.h |   2 +-
>  arm/pci.c                         |  49 ++-
>  builtin-debug.c                   |   8 +-
>  builtin-run.c                     |   2 +
>  fdt.c                             |  35 ++
>  include/kvm/builtin-debug.h       |   6 +
>  include/kvm/devices.h             |   4 +
>  include/kvm/fdt.h                 |  20 +
>  include/kvm/iommu.h               | 105 +++++
>  include/kvm/irq.h                 |   3 +
>  include/kvm/kvm-config.h          |   1 +
>  include/kvm/vfio.h                |   2 +
>  include/kvm/virtio-iommu.h        |  15 +
>  include/kvm/virtio-mmio.h         |   1 +
>  include/kvm/virtio-pci.h          |   2 +
>  include/kvm/virtio.h              | 137 +++++-
>  include/linux/virtio_config.h     |  74 ++++
>  include/linux/virtio_ids.h        |   4 +
>  include/linux/virtio_iommu.h      | 142 ++++++
>  iommu.c                           | 240 ++++++++++
>  irq.c                             |  35 ++
>  kvm-ipc.c                         |  43 +-
>  mips/include/kvm/fdt-arch.h       |   2 +-
>  powerpc/include/kvm/fdt-arch.h    |   2 +-
>  vfio.c                            | 281 +++++++++++-
>  virtio/9p.c                       |   7 +-
>  virtio/balloon.c                  |   7 +-
>  virtio/blk.c                      |  10 +-
>  virtio/console.c                  |   7 +-
>  virtio/core.c                     | 240 ++++++++--
>  virtio/iommu.c                    | 902
> ++++++++++++++++++++++++++++++++++++++
>  virtio/mmio.c                     |  44 +-
>  virtio/net.c                      |   8 +-
>  virtio/pci.c                      |  61 ++-
>  virtio/rng.c                      |   6 +-
>  virtio/scsi.c                     |   6 +-
>  x86/include/kvm/fdt-arch.h        |   2 +-
>  39 files changed, 2389 insertions(+), 133 deletions(-)  create mode 100644
> fdt.c  create mode 100644 include/kvm/iommu.h  create mode 100644
> include/kvm/virtio-iommu.h  create mode 100644
> include/linux/virtio_config.h  create mode 100644
> include/linux/virtio_iommu.h  create mode 100644 iommu.c  create mode
> 100644 virtio/iommu.c
> 
> --
> 2.12.1
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
