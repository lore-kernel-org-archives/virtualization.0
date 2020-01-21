From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 0/5] vDPA support
Date: Tue, 21 Jan 2020 08:44:39 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D73EC6B@SHSMSX104.ccr.corp.intel.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200116124231.20253-1-jasowang@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "shahafs@mellanox.com" <shahafs@mellanox.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "lulu@redhat.com" <lulu@redhat.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "hch@infradead.org" <hch@infradead.org>, "eperezma@redhat.com" <eperezma@redhat.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "jgg@mellanox.com" <jgg@mellanox.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "parav@mellanox.com" <parav@mellanox.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jiri@mellanox.com" <jiri@mellanox.com>, "mhabets@solarflare.com" <mhabets@solarflare.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Jason Wang
> Sent: Thursday, January 16, 2020 8:42 PM
> 
> Hi all:
> 
> Based on the comments and discussion for mdev based hardware virtio
> offloading support[1]. A different approach to support vDPA device is
> proposed in this series.

Can you point to the actual link which triggered the direction change?
A quick glimpse in that thread doesn't reveal such information...

> 
> Instead of leveraging VFIO/mdev which may not work for some
> vendors. This series tries to introduce a dedicated vDPA bus and
> leverage vhost for userspace drivers. This help for the devices that
> are not fit for VFIO and may reduce the conflict when try to propose a
> bus template for virtual devices in [1].
> 
> The vDPA support is split into following parts:
> 
> 1) vDPA core (bus, device and driver abstraction)
> 2) virtio vDPA transport for kernel virtio driver to control vDPA
>    device
> 3) vhost vDPA bus driver for userspace vhost driver to control vDPA
>    device
> 4) vendor vDPA drivers
> 5) management API
> 
> Both 1) and 2) are included in this series. Tiwei will work on part
> 3). For 4), Ling Shan will work and post IFCVF driver. For 5) we leave
> it to vendor to implement, but it's better to come into an agreement
> for management to create/configure/destroy vDPA device.
> 
> The sample driver is kept but renamed to vdap_sim. An on-chip IOMMU
> implementation is added to sample device to make it work for both
> kernel virtio driver and userspace vhost driver. It implements a sysfs
> based management API, but it can switch to any other (e.g devlink) if
> necessary.
> 
> Please refer each patch for more information.
> 
> Comments are welcomed.
> 
> [1] https://lkml.org/lkml/2019/11/18/261
> 
> Jason Wang (5):
>   vhost: factor out IOTLB
>   vringh: IOTLB support
>   vDPA: introduce vDPA bus
>   virtio: introduce a vDPA based transport
>   vdpasim: vDPA device simulator
> 
>  MAINTAINERS                    |   2 +
>  drivers/vhost/Kconfig          |   7 +
>  drivers/vhost/Kconfig.vringh   |   1 +
>  drivers/vhost/Makefile         |   2 +
>  drivers/vhost/net.c            |   2 +-
>  drivers/vhost/vhost.c          | 221 +++------
>  drivers/vhost/vhost.h          |  36 +-
>  drivers/vhost/vhost_iotlb.c    | 171 +++++++
>  drivers/vhost/vringh.c         | 434 +++++++++++++++++-
>  drivers/virtio/Kconfig         |  15 +
>  drivers/virtio/Makefile        |   2 +
>  drivers/virtio/vdpa/Kconfig    |  26 ++
>  drivers/virtio/vdpa/Makefile   |   3 +
>  drivers/virtio/vdpa/vdpa.c     | 141 ++++++
>  drivers/virtio/vdpa/vdpa_sim.c | 796
> +++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_vdpa.c   | 400 +++++++++++++++++
>  include/linux/vdpa.h           | 191 ++++++++
>  include/linux/vhost_iotlb.h    |  45 ++
>  include/linux/vringh.h         |  36 ++
>  19 files changed, 2327 insertions(+), 204 deletions(-)
>  create mode 100644 drivers/vhost/vhost_iotlb.c
>  create mode 100644 drivers/virtio/vdpa/Kconfig
>  create mode 100644 drivers/virtio/vdpa/Makefile
>  create mode 100644 drivers/virtio/vdpa/vdpa.c
>  create mode 100644 drivers/virtio/vdpa/vdpa_sim.c
>  create mode 100644 drivers/virtio/virtio_vdpa.c
>  create mode 100644 include/linux/vdpa.h
>  create mode 100644 include/linux/vhost_iotlb.h
> 
> --
> 2.19.1
