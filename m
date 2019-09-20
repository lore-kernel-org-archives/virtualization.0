From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH V2 0/6] mdev based hardware virtio offloading support
Date: Fri, 20 Sep 2019 16:20:44 +0800
Message-ID: <20190920082050.19352-1-jasowang@redhat.com>
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
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: sebott@linux.ibm.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, zhenyuw@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, jani.nikula@linux.intel.com, zhihong.wang@intel.com, akrowiak@linux.ibm.com, pmorel@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, oberpar@linux.ibm.com, maxime.coquelin@redhat.com, daniel@ffwll.ch, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

There are hardware that can do virtio datapath offloading while having
its own control path. This path tries to implement a mdev based
unified API to support using kernel virtio driver to drive those
devices. This is done by introducing a new mdev transport for virtio
(virtio_mdev) and register itself as a new kind of mdev driver. Then
it provides a unified way for kernel virtio driver to talk with mdev
device implementation.

Though the series only contain kernel driver support, the goal is to
make the transport generic enough to support userspace drivers. This
means vhost-mdev[1] could be built on top as well by resuing the
transport.

A sample driver is also implemented which simulate a virito-net
loopback ethernet device on top of vringh + workqueue. This could be
used as a reference implementation for real hardware driver.

Consider mdev framework only support VFIO device and driver right now,
this series also extend it to support other types. This is done
through introducing class id to the device and pairing it with
id_talbe claimed by the driver. On top, this seris also decouple
device specific parents ops out of the common ones.

Pktgen test was done with virito-net + mvnet loop back device.

Please review.

Changes from V1:

- rename device id to class id
- add docs for class id and device specific ops (device_ops)
- split device_ops into seperate headers
- drop the mdev_set_dma_ops()
- use device_ops to implement the transport API, then it's not a part
  of UAPI any more
- use GFP_ATOMIC in mvnet sample device and other tweaks
- set_vring_base/get_vring_base support for mvnet device

Jason Wang (6):
  mdev: class id support
  mdev: introduce device specific ops
  mdev: introduce virtio device and its device ops
  virtio: introudce a mdev based transport
  vringh: fix copy direction of vringh_iov_push_kern()
  docs: Sample driver to demonstrate how to implement virtio-mdev
    framework

 .../driver-api/vfio-mediated-device.rst       |  11 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c              |  17 +-
 drivers/s390/cio/vfio_ccw_ops.c               |  17 +-
 drivers/s390/crypto/vfio_ap_ops.c             |  14 +-
 drivers/vfio/mdev/Kconfig                     |   7 +
 drivers/vfio/mdev/Makefile                    |   1 +
 drivers/vfio/mdev/mdev_core.c                 |  21 +-
 drivers/vfio/mdev/mdev_driver.c               |  14 +
 drivers/vfio/mdev/mdev_private.h              |   1 +
 drivers/vfio/mdev/vfio_mdev.c                 |  37 +-
 drivers/vfio/mdev/virtio_mdev.c               | 418 +++++++++++
 drivers/vhost/vringh.c                        |   8 +-
 include/linux/mdev.h                          |  46 +-
 include/linux/mod_devicetable.h               |   8 +
 include/linux/vfio_mdev.h                     |  50 ++
 include/linux/virtio_mdev.h                   | 141 ++++
 samples/Kconfig                               |   7 +
 samples/vfio-mdev/Makefile                    |   1 +
 samples/vfio-mdev/mbochs.c                    |  19 +-
 samples/vfio-mdev/mdpy.c                      |  19 +-
 samples/vfio-mdev/mtty.c                      |  17 +-
 samples/vfio-mdev/mvnet.c                     | 688 ++++++++++++++++++
 22 files changed, 1473 insertions(+), 89 deletions(-)
 create mode 100644 drivers/vfio/mdev/virtio_mdev.c
 create mode 100644 include/linux/vfio_mdev.h
 create mode 100644 include/linux/virtio_mdev.h
 create mode 100644 samples/vfio-mdev/mvnet.c

-- 
2.19.1
