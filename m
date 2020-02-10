From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 0/5] vDPA support
Date: Mon, 10 Feb 2020 11:56:03 +0800
Message-ID: <20200210035608.10002-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

This is an updated version of kernel support for vDPA device. Various
changes were made based on the feedback since last verion. One major
change is to drop the sysfs API and leave the management interface for
future development, and introudce the incremental DMA bus
operations. Please see changelog for more information.

The work on vhost, IFCVF (intel VF driver for vDPA) and qemu is
ongoing.

Please provide feedback.

Thanks

Change from V1:

- drop sysfs API, leave the management interface to future development
  (Michael)
- introduce incremental DMA ops (dma_map/dma_unmap) (Michael)
- introduce dma_device and use it instead of parent device for doing
  IOMMU or DMA from bus driver (Michael, Jason, Ling Shan, Tiwei)
- accept parent device and dma device when register vdpa device
- coding style and compile fixes (Randy)
- using vdpa_xxx instead of xxx_vdpa (Jason)
- ove vDPA accessors to header and make it static inline (Jason)
- split vdp_register_device() into two helpers vdpa_init_device() and
  vdpa_register_device() which allows intermediate step to be done (Jason=
)
- warn on invalidate queue state when fail to creating virtqueue (Jason)
- make to_virtio_vdpa_device() static (Jason)
- use kmalloc/kfree instead of devres for virtio vdpa device (Jason)
- avoid using cast in vdpa bus function (Jason)
- introduce module_vdpa_driver and fix module refcnt (Jason)
- fix returning freed address in vdapsim coherent DMA addr allocation (Da=
n)
- various other fixes and tweaks

V1: https://lkml.org/lkml/2020/1/16/353

Jason Wang (5):
  vhost: factor out IOTLB
  vringh: IOTLB support
  vDPA: introduce vDPA bus
  virtio: introduce a vDPA based transport
  vdpasim: vDPA device simulator

 MAINTAINERS                    |   2 +
 drivers/vhost/Kconfig          |   7 +
 drivers/vhost/Kconfig.vringh   |   1 +
 drivers/vhost/Makefile         |   2 +
 drivers/vhost/net.c            |   2 +-
 drivers/vhost/vhost.c          | 221 ++++-------
 drivers/vhost/vhost.h          |  36 +-
 drivers/vhost/vhost_iotlb.c    | 171 +++++++++
 drivers/vhost/vringh.c         | 421 ++++++++++++++++++--
 drivers/virtio/Kconfig         |  15 +
 drivers/virtio/Makefile        |   2 +
 drivers/virtio/vdpa/Kconfig    |  26 ++
 drivers/virtio/vdpa/Makefile   |   3 +
 drivers/virtio/vdpa/vdpa.c     | 160 ++++++++
 drivers/virtio/vdpa/vdpa_sim.c | 678 +++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_vdpa.c   | 392 +++++++++++++++++++
 include/linux/vdpa.h           | 233 +++++++++++
 include/linux/vhost_iotlb.h    |  45 +++
 include/linux/vringh.h         |  36 ++
 19 files changed, 2249 insertions(+), 204 deletions(-)
 create mode 100644 drivers/vhost/vhost_iotlb.c
 create mode 100644 drivers/virtio/vdpa/Kconfig
 create mode 100644 drivers/virtio/vdpa/Makefile
 create mode 100644 drivers/virtio/vdpa/vdpa.c
 create mode 100644 drivers/virtio/vdpa/vdpa_sim.c
 create mode 100644 drivers/virtio/virtio_vdpa.c
 create mode 100644 include/linux/vdpa.h
 create mode 100644 include/linux/vhost_iotlb.h

--=20
2.19.1
