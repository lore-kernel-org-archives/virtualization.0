From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Date: Fri, 22 Nov 2019 08:00:46 -0500
Message-ID: <20191122075438-mutt-send-email-mst__41237.0842693903$1574427675$gmane$org@kernel.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, guohanjun@huawei.com, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 22, 2019 at 11:49:47AM +0100, Jean-Philippe Brucker wrote:
> I'm seeking feedback on multi-platform support for virtio-iommu. At the
> moment only devicetree (DT) is supported and we don't have a pleasant
> solution for other platforms. Once we figure out the topology
> description, x86 support is trivial.
> 
> Since the IOMMU manages memory accesses from other devices, the guest
> kernel needs to initialize the IOMMU before endpoints start issuing DMA.
> It's a solved problem: firmware or hypervisor describes through DT or
> ACPI tables the device dependencies, and probe of endpoints is deferred
> until the IOMMU is probed. But:
> 
> (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD and IORT
>     for Arm). From my point of view IORT is easier to extend, since we
>     just need to introduce a new node type. There are no dependencies to
>     Arm in the Linux IORT driver, so it works well with CONFIG_X86.
> 
>     However, there are concerns about other OS vendors feeling obligated
>     to implement this new node, so Arm proposed introducing another ACPI
>     table, that can wrap any of DMAR, IVRS and IORT to extend it with
>     new virtual nodes. A draft of this VIOT table specification is
>     available at http://jpbrucker.net/virtio-iommu/viot/viot-v5.pdf
> 
>     I'm afraid this could increase fragmentation as guests would need to
>     implement or modify their support for all of DMAR, IVRS and IORT. If
>     we end up doing VIOT, I suggest limiting it to IORT.
> 
> (2) In addition, there are some concerns about having virtio depend on
>     ACPI or DT. Some hypervisors (Firecracker, QEMU microvm, kvmtool x86
>     [1])

power?

> don't currently implement those methods.
> 
>     It was suggested to embed the topology description into the device.
>     It can work, as demonstrated at the end of this RFC, with the
>     following limitations:
> 
>     - The topology description must be read before any endpoint managed
>       by the IOMMU is probed, and even before the virtio module is
>       loaded. This RFC uses a PCI quirk to manually parse the virtio
>       configuration. It assumes that all endpoints managed by the IOMMU
>       are under this same PCI host.
> 
>     - I don't have a solution for the virtio-mmio transport at the
>       moment, because I haven't had time to modify a host to test it. I
>       think it could either use a notifier on the platform bus, or
>       better, a new 'iommu' command-line argument to the virtio-mmio
>       driver.

	A notifier seems easier for users. What are the disadvantages of
	that?

>	So the current prototype doesn't work for firecracker and
>       microvm, which rely on virtio-mmio.
> 
>     - For Arm, if the platform has an ITS, the hypervisor needs IORT or
>       DT to describe it anyway. More generally, not using either ACPI or
>       DT might prevent from supporting other features as well. I suspect
>       the above users will have to implement a standard method sooner or
>       later.
> 
>     - Even when reusing as much existing code as possible, guest support
>       is still going to be around a few hundred lines since we can't
>       rely on the normal virtio infrastructure to be loaded at that
>       point. As you can see below, the diffstat for the incomplete
>       topology implementation is already bigger than the exhaustive IORT
>       support, even when jumping through the VIOT hoop.
> 
>     So it's a lightweight solution for very specific use-cases, and we
>     should still support ACPI for the general case. Multi-platform
>     guests such as Linux will then need to support three topology
>     descriptions instead of two.
> 
> In this RFC I present both solutions, but I'd rather not keep all of it.
> Please see the individual patches for details:
> 
> (1) Patches 1, 3-10 add support for virtio-iommu to the Linux IORT
>     driver and patches 2, 11 add the VIOT glue.
> 
> (2) Patch 12 adds the built-in topology description to the virtio-iommu
>     specification. Patch 13 is a partial implementation for the Linux
>     virtio-iommu driver. It only supports PCI, not platform devices.
> 
> You can find Linux and QEMU code on my virtio-iommu/devel branches at
> http://jpbrucker.net/git/linux and http://jpbrucker.net/git/qemu
> 
> 
> I split the diffstat since there are two independent features. The first
> one is for patches 1-11, and the second one for patch 13.
> 
> Jean-Philippe Brucker (11):
>   ACPI/IORT: Move IORT to the ACPI folder
>   ACPI: Add VIOT definitions
>   ACPI/IORT: Allow registration of external tables
>   ACPI/IORT: Add node categories
>   ACPI/IORT: Support VIOT virtio-mmio node
>   ACPI/IORT: Support VIOT virtio-pci node
>   ACPI/IORT: Defer probe until virtio-iommu-pci has registered a fwnode
>   ACPI/IORT: Add callback to update a device's fwnode
>   iommu/virtio: Create fwnode if necessary
>   iommu/virtio: Update IORT fwnode
>   ACPI: Add VIOT table
> 
>  MAINTAINERS                     |   9 +
>  drivers/acpi/Kconfig            |   7 +
>  drivers/acpi/Makefile           |   2 +
>  drivers/acpi/arm64/Kconfig      |   3 -
>  drivers/acpi/arm64/Makefile     |   1 -
>  drivers/acpi/bus.c              |   2 +
>  drivers/acpi/{arm64 => }/iort.c | 317 ++++++++++++++++++++++++++------
>  drivers/acpi/tables.c           |   2 +-
>  drivers/acpi/viot.c             |  44 +++++
>  drivers/iommu/Kconfig           |   1 +
>  drivers/iommu/virtio-iommu.c    |  61 +++++-
>  include/acpi/actbl2.h           |  31 ++++
>  include/linux/acpi_iort.h       |  14 ++
>  include/linux/acpi_viot.h       |  20 ++
>  14 files changed, 448 insertions(+), 66 deletions(-)
>  rename drivers/acpi/{arm64 => }/iort.c (86%)
>  create mode 100644 drivers/acpi/viot.c
>  create mode 100644 include/linux/acpi_viot.h
> 
> Jean-Philippe Brucker (1):
>   iommu/virtio: Add topology description to virtio-iommu config space
> 
>  drivers/base/platform.c               |   3 +
>  drivers/iommu/Kconfig                 |   9 +
>  drivers/iommu/Makefile                |   1 +
>  drivers/iommu/virtio-iommu-topology.c | 410 ++++++++++++++++++++++++++
>  drivers/iommu/virtio-iommu.c          |   3 +
>  drivers/pci/pci-driver.c              |   3 +
>  include/linux/virtio_iommu.h          |  18 ++
>  include/uapi/linux/virtio_iommu.h     |  26 ++
>  8 files changed, 473 insertions(+)
>  create mode 100644 drivers/iommu/virtio-iommu-topology.c
>  create mode 100644 include/linux/virtio_iommu.h
> 
> 
> [1] firecracker: https://github.com/firecracker-microvm/firecracker
>     microvm: https://github.com/qemu/qemu/blob/master/docs/microvm.rst
>     kvmtool: https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git/
> -- 
> 2.24.0
