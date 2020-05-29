From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/6] vDPA: doorbell mapping
Date: Fri, 29 May 2020 16:02:57 +0800
Message-ID: <20200529080303.15449-1-jasowang@redhat.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, jasowang@redhat.com
Cc: shahafs@mellanox.com, lulu@redhat.com, kvm@vger.kernel.org, saugatm@xilinx.com, netdev@vger.kernel.org, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

This series introduce basic functionality of doorbell mapping support
for vhost-vDPA. Userspace program may use mmap() to map a the doorbell
of a specific virtqueue into its address space. This is help to reudce
the syscall or vmexit overhead.

A new vdpa_config_ops was introduced to report the location of the
doorbell, vhost_vdpa may then choose to map the doorbell when:

- The doorbell register is localted at page boundary
- The doorbell register does not share page with non doorbell
  registers.

With these two requriements, doorbells layout could be modelled more
easily from guest (e.g Qemu's page-per-vq model) and it would be more
safe to avoid exposing other registers to userspace directly.

IFCVF was reported to support this feature but unfortuantely the one I
used does not meet those requirements. So a new virtio-pci driver for
vDPA bus is introduced, and I verify this with page-per-vq=on with a
userspace vhost-vdpa driver in guest.

Please review.

Thanks

Jason Wang (6):
  vhost: allow device that does not depend on vhost worker
  vhost: use mmgrab() instead of mmget() for non worker device
  vdpa: introduce get_vq_notification method
  vhost_vdpa: support doorbell mapping via mmap
  vdpa: introduce virtio pci driver
  vdpa: vp_vdpa: report doorbell location

 drivers/vdpa/Kconfig           |   6 +
 drivers/vdpa/Makefile          |   1 +
 drivers/vdpa/vp_vdpa/Makefile  |   2 +
 drivers/vdpa/vp_vdpa/vp_vdpa.c | 604 +++++++++++++++++++++++++++++++++
 drivers/vhost/net.c            |   2 +-
 drivers/vhost/scsi.c           |   2 +-
 drivers/vhost/vdpa.c           |  61 +++-
 drivers/vhost/vhost.c          |  80 +++--
 drivers/vhost/vhost.h          |   2 +
 drivers/vhost/vsock.c          |   2 +-
 include/linux/vdpa.h           |  16 +
 11 files changed, 753 insertions(+), 25 deletions(-)
 create mode 100644 drivers/vdpa/vp_vdpa/Makefile
 create mode 100644 drivers/vdpa/vp_vdpa/vp_vdpa.c

-- 
2.20.1
