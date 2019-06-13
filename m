From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v8 0/7] Add virtio-iommu driver
Date: Thu, 13 Jun 2019 17:54:13 +0200
Message-ID: <42408240-81a1-fe25-72da-5a93c9e1cb89__3634.98089588887$1560441292$gmane$org@redhat.com>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, joro@8bytes.org, mst@redhat.com
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, Lorenzo.Pieralisi@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 5/30/19 7:09 PM, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.12 [1].
> Since last version [2] we've worked on improving the specification,
> which resulted in the following changes to the interface:
> * Remove the EXEC flag.
> * Add feature bit for the MMIO flag.
> * Change domain_bits to domain_range.
> 
> Given that there were small changes to patch 5/7, I removed the review
> and test tags. Please find the code at [3].
> 
> [1] Virtio-iommu specification v0.12, sources and pdf
>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.12
>     http://jpbrucker.net/virtio-iommu/spec/v0.12/virtio-iommu-v0.12.pdf
>     http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-dev-diff-v0.11-v0.12.pdf
> 
> [2] [PATCH v7 0/7] Add virtio-iommu driver
>     https://lore.kernel.org/linux-pci/0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com/T/
> 
> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.12
>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.12

SERIES
Tested-by: Eric Auger <eric.auger@redhat.com>

with QEMU branch:
https://github.com/eauger/qemu/tree/v4.0-virtio-iommu-v0.12

and kernel branch:
https://github.com/eauger/linux/tree/virtio-iommu-v0.12
(where I just added the rebased iort patches on top of Jean-Philippe's
virtio-iommu/v0.12 branch). So I also tested the ACPI boot.

I will formally submit the QEMU series ASAP.

Thanks

Eric

> 
> Jean-Philippe Brucker (7):
>   dt-bindings: virtio-mmio: Add IOMMU description
>   dt-bindings: virtio: Add virtio-pci-iommu node
>   of: Allow the iommu-map property to omit untranslated devices
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
>  drivers/iommu/virtio-iommu.c                  | 1176 +++++++++++++++++
>  drivers/of/base.c                             |   10 +-
>  drivers/pci/of.c                              |    6 +
>  include/uapi/linux/virtio_ids.h               |    1 +
>  include/uapi/linux/virtio_iommu.h             |  165 +++
>  10 files changed, 1470 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 drivers/iommu/virtio-iommu.c
>  create mode 100644 include/uapi/linux/virtio_iommu.h
> 
