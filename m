From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/2] vfio: blacklist legacy virtio devices
Date: Tue, 30 Aug 2016 05:27:07 +0300
Message-ID: <1472523968-9540-1-git-send-email-mst@redhat.com>
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Legacy virtio devices always bypassed an IOMMU, so using them with vfio was
never safe.  This adds a quirk detecting these and disabling VFIO unless the
noiommu mode is used.  At the moment, this only applies to virtio-pci devices.

The patch might make sense on stable as well.

Michael S. Tsirkin (2):
  vfio: report group noiommu status
  vfio: add virtio pci quirk

 drivers/vfio/pci/vfio_pci_private.h |   1 +
 include/linux/vfio.h                |   2 +
 drivers/vfio/pci/vfio_pci.c         |  14 ++++
 drivers/vfio/pci/vfio_pci_virtio.c  | 140 ++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio.c                 |  12 ++++
 drivers/vfio/pci/Makefile           |   1 +
 6 files changed, 170 insertions(+)
 create mode 100644 drivers/vfio/pci/vfio_pci_virtio.c

-- 
MST
