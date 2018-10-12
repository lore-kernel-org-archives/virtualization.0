From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/7] Add virtio-iommu driver
Date: Fri, 12 Oct 2018 13:00:34 -0400
Message-ID: <20181012125443-mutt-send-email-mst__4163.265732541$1539363525$gmane$org@kernel.org>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, marc.zyngier@arm.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 12, 2018 at 03:59:10PM +0100, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.8 [1].
> Changes since v2 [2]:
> 
> * Patches 2-4 allow virtio-iommu to use the PCI transport, since QEMU
>   would like to phase out the MMIO transport. This produces a complex
>   topology where the programming interface of the IOMMU could appear
>   lower than the endpoints that it translates. It's not unheard of (e.g.
>   AMD IOMMU), and the guest easily copes with this.
>   
>   The "Firmware description" section of the specification has been
>   updated with all combinations of PCI, MMIO and DT, ACPI.
> 
> * Fix structures layout, they don't need the "packed" attribute anymore.
> 
> * While we're at it, add domain parameter to DETACH request, and leave
>   some padding. This way the next version, that adds PASID support,
>   won't have to introduce a "DETACH2" request to stay backward
>   compatible.
> 
> * Require virtio device 1.0+. Remove legacy transport notes from the
>   specification.
> 
> * Request timeout is now only enabled with DEBUG.
> 
> * The patch for VFIO Kconfig (previously patch 5/5) is in next.
> 
> You can find Linux driver and kvmtool device on branches
> virtio-iommu/v0.8 [3] (currently based on 4.19-rc7 but rebasing onto
> next only produced a trivial conflict). Branch virtio-iommu/devel
> contains a few patches that I'd like to send once the base is upstream:
> 
> * virtio-iommu as a module. It got *much* nicer after Rob's probe
>   deferral rework, but I still have a bug to fix when re-loading the
>   virtio-iommu module.
> 
> * ACPI support requires a minor IORT spec update (reservation of node
>   ID). I think it should be easier to obtain once the device and drivers
>   are upstream.
> 
> [1] Virtio-iommu specification v0.8, diff from v0.7, and sources
>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.8
>     http://jpbrucker.net/virtio-iommu/spec/v0.8/virtio-iommu-v0.8.pdf
>     http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.7-v0.8.pdf
> 
> [2] [PATCH v2 0/5] Add virtio-iommu driver
>     https://www.spinics.net/lists/kvm/msg170655.html
> 
> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.8
>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.8
> 
> Jean-Philippe Brucker (7):
>   dt-bindings: virtio-mmio: Add IOMMU description
>   dt-bindings: virtio: Add virtio-pci-iommu node
>   PCI: OF: allow endpoints to bypass the iommu
>   PCI: OF: Initialize dev->fwnode appropriately
>   iommu: Add virtio-iommu driver
>   iommu/virtio: Add probe request
>   iommu/virtio: Add event queue
> 
>  .../devicetree/bindings/virtio/iommu.txt      |   66 +
>  .../devicetree/bindings/virtio/mmio.txt       |   30 +
>  MAINTAINERS                                   |    7 +
>  drivers/iommu/Kconfig                         |   11 +
>  drivers/iommu/Makefile                        |    1 +
>  drivers/iommu/virtio-iommu.c                  | 1171 +++++++++++++++++
>  drivers/pci/of.c                              |   14 +-
>  include/uapi/linux/virtio_ids.h               |    1 +
>  include/uapi/linux/virtio_iommu.h             |  159 +++
>  9 files changed, 1457 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 drivers/iommu/virtio-iommu.c
>  create mode 100644 include/uapi/linux/virtio_iommu.h

This all looks good to me. Minor nits:
- I think DEBUG mode is best just removed for now
- Slightly wrong patch splitup causing a misaligned structure
  in uapi until all patches are applied.

You should Cc Bjorn on the pci change - I'd like to see his ack on it
being merged through my tree.

And pls Cc the virtio-dev list on any virtio uapi changes.

At a feature level I have some ideas for more features we
could add, but for now I think I'll put this version in -next
while you iron out the above wrinkles. Hope you can make the
merge window.

> -- 
> 2.19.1
