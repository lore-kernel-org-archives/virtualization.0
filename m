From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 0/2] Mdev: support mutiple kinds of devices
Date: Thu, 12 Sep 2019 17:40:10 +0800
Message-ID: <20190912094012.29653-1-jasowang__29177.0216239215$1568281244$gmane$org@redhat.com>
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
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com
Cc: sebott@linux.ibm.com, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, rodrigo.vivi@intel.com, lingshan.zhu@intel.com, akrowiak@linux.ibm.com, pmorel@linux.ibm.com, cohuck@redhat.com, oberpar@linux.ibm.com, maxime.coquelin@redhat.com, daniel@ffwll.ch, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

During the development of virtio-mdev[1]. I find that mdev needs to be
extended to support devices other than vfio mdev device. So this
series tries to extend the mdev to be able to differ from different
devices by:

- device id and matching for mdev bus
- device speicfic callbacks and move vfio callbacks there

Sent for early reivew, compile test only!

Thanks

[1] https://lkml.org/lkml/2019/9/10/135

Jason Wang (2):
  mdev: device id support
  mdev: introduce device specific ops

 drivers/gpu/drm/i915/gvt/kvmgt.c  | 16 ++++---
 drivers/s390/cio/vfio_ccw_ops.c   | 16 ++++---
 drivers/s390/crypto/vfio_ap_ops.c | 13 ++++--
 drivers/vfio/mdev/mdev_core.c     | 14 +++++-
 drivers/vfio/mdev/mdev_driver.c   | 14 ++++++
 drivers/vfio/mdev/mdev_private.h  |  1 +
 drivers/vfio/mdev/vfio_mdev.c     | 36 ++++++++++-----
 include/linux/mdev.h              | 76 +++++++++++++++++++------------
 include/linux/mod_devicetable.h   |  6 +++
 samples/vfio-mdev/mbochs.c        | 18 +++++---
 samples/vfio-mdev/mdpy.c          | 18 +++++---
 samples/vfio-mdev/mtty.c          | 16 ++++---
 12 files changed, 163 insertions(+), 81 deletions(-)

-- 
2.19.1
