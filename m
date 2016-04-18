From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/3] virtio-pci: iommu support
Date: Mon, 18 Apr 2016 12:58:08 +0300
Message-ID: <1460973374-32719-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Wei Liu <wei.liu2@citrix.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an attempt to allow enabling IOMMU for DMA.
Design:
	- new feature bit IOMMU_PLATFORM which means
          host won't bypass IOMMU
	- virtio core uses DMA API if it sees IOMMU_PLATFORM
	- add quirk for vfio to disable device unless IOMMU_PLATFORM is set
          or the no-iommu mode is enabled
	- while I'm not sure how it will be used, it seems like a good idea to
	  also have ability to distinguish between a legacy device and one
	  where iommu is bypassed intentionally.  To this end, add another feature bit
	  IOMMU_PASSTHROUGH. We don't acknowledge it if IOMMU_PLATFORM is set.

TODO:
	- I'm not sure whether there are setups that mix IOMMU
	  and no-IOMMU configs. If so, failing on probe might not
	  be the right thing to do, should fail binding to IOMMU group instead.


Michael S. Tsirkin (3):
  virtio: add features for IOMMU control
  vfio: report group noiommu status
  vfio: add virtio pci quirk

 drivers/vfio/pci/vfio_pci_private.h          |   1 +
 include/uapi/linux/virtio_config.h           |  10 +-
 drivers/vfio/pci/vfio_pci.c                  |  13 ++-
 drivers/vfio/pci/vfio_pci_virtio.c           | 142 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_common.c |   2 +-
 drivers/vfio/vfio.c                          |   5 +-
 drivers/virtio/virtio_ring.c                 |  18 +++-
 Documentation/vfio.txt                       |   4 +-
 drivers/vfio/pci/Makefile                    |   1 +
 9 files changed, 190 insertions(+), 6 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_virtio.c

-- 
MST
