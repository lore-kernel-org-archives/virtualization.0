From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v8 0/7] Add virtio-iommu driver
Date: Thu, 30 May 2019 18:09:22 +0100
Message-ID: <20190530170929.19366-1-jean-philippe.brucker__12029.5702175767$1559236373$gmane$org@arm.com>
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
To: joro@8bytes.org, mst@redhat.com
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, Lorenzo.Pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, bhelgaas@google.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

Implement the virtio-iommu driver, following specification v0.12 [1].
Since last version [2] we've worked on improving the specification,
which resulted in the following changes to the interface:
* Remove the EXEC flag.
* Add feature bit for the MMIO flag.
* Change domain_bits to domain_range.

Given that there were small changes to patch 5/7, I removed the review
and test tags. Please find the code at [3].

[1] Virtio-iommu specification v0.12, sources and pdf
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.12
    http://jpbrucker.net/virtio-iommu/spec/v0.12/virtio-iommu-v0.12.pdf
    http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-dev-diff-v0.11-v0.12.pdf

[2] [PATCH v7 0/7] Add virtio-iommu driver
    https://lore.kernel.org/linux-pci/0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com/T/

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.12
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.12

Jean-Philippe Brucker (7):
  dt-bindings: virtio-mmio: Add IOMMU description
  dt-bindings: virtio: Add virtio-pci-iommu node
  of: Allow the iommu-map property to omit untranslated devices
  PCI: OF: Initialize dev->fwnode appropriately
  iommu: Add virtio-iommu driver
  iommu/virtio: Add probe request
  iommu/virtio: Add event queue

 .../devicetree/bindings/virtio/iommu.txt      |   66 +
 .../devicetree/bindings/virtio/mmio.txt       |   30 +
 MAINTAINERS                                   |    7 +
 drivers/iommu/Kconfig                         |   11 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/virtio-iommu.c                  | 1176 +++++++++++++++++
 drivers/of/base.c                             |   10 +-
 drivers/pci/of.c                              |    6 +
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  165 +++
 10 files changed, 1470 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.21.0
