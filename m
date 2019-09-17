From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC v4 0/3] vhost: introduce mdev based hardware backend
Date: Tue, 17 Sep 2019 09:02:01 +0800
Message-ID: <20190917010204.30376-1-tiwei.bie__31656.6691546299$1568682310$gmane$org@intel.com>
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
To: mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, maxime.coquelin@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This RFC is to demonstrate below ideas,

a) Build vhost-mdev on top of the same abstraction defined in
   the virtio-mdev series [1];

b) Introduce /dev/vhost-mdev to do vhost ioctls and support
   setting mdev device as backend;

Now the userspace API looks like this:

- Userspace generates a compatible mdev device;

- Userspace opens this mdev device with VFIO API (including
  doing IOMMU programming for this mdev device with VFIO's
  container/group based interface);

- Userspace opens /dev/vhost-mdev and gets vhost fd;

- Userspace uses vhost ioctls to setup vhost (userspace should
  do VHOST_MDEV_SET_BACKEND ioctl with VFIO group fd and device
  fd first before doing other vhost ioctls);

Only compile test has been done for this series for now.

RFCv3: https://patchwork.kernel.org/patch/11117785/

[1] https://lkml.org/lkml/2019/9/10/135

Tiwei Bie (3):
  vfio: support getting vfio device from device fd
  vfio: support checking vfio driver by device ops
  vhost: introduce mdev based hardware backend

 drivers/vfio/mdev/vfio_mdev.c    |   3 +-
 drivers/vfio/vfio.c              |  32 +++
 drivers/vhost/Kconfig            |   9 +
 drivers/vhost/Makefile           |   3 +
 drivers/vhost/mdev.c             | 462 +++++++++++++++++++++++++++++++
 drivers/vhost/vhost.c            |  39 ++-
 drivers/vhost/vhost.h            |   6 +
 include/linux/vfio.h             |  11 +
 include/uapi/linux/vhost.h       |  10 +
 include/uapi/linux/vhost_types.h |   5 +
 10 files changed, 573 insertions(+), 7 deletions(-)
 create mode 100644 drivers/vhost/mdev.c

-- 
2.17.1
