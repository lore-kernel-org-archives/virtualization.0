From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC 0/5] support batched IOTLB updating in vhost-vdpa
Date: Thu, 18 Jun 2020 13:56:21 +0800
Message-ID: <20200618055626.25660-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

This series tries to support batched IOTLB updating vhost-vdpa.

Currently vhost-vdpa accepts userspace mapping via IOTLB API, and it
can only forward one mapping to IOMMU or device through IOMMU API or
dma_map(). Though set_map() is deisgend to have the capability to pass
an rbtree based mapping to vDPA device, it's still be called at least
once for each VHOST_IOTLB_UPDATE or VHOST_IOTLB_INVALIDATE. This is
because vhost-vdpa doesn't know the userspace start or stop then
updating.

So this patch introduces two flags as hints for vhost-vdpa to call
set_map() only when userspace finish a batch of IOTLB updating.

So instead of:

1) VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE -> set_map() (s)
2) VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE -> set_map() (s)
...
n) VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE -> set_map() (s)

With the help of hints, we do:

0) VHOST_IOTLB_BATCH_START

1) VHOST_IOTLB_UPDATE/INVALIDATE
...
n) VHOST_IOTLB_UPDATE/INVALIDATE

n+1) VHOST_IOTLB_BATCH_END -> set_map()

One one call of set_map() to vDPA device for a batch of IOTLB
mappings. So for the device that has its own DMA translation logic, it
can efficiently structure the memory mapping to get best performance.

Note, this only impact the devices that want its own DMA
translation. For other type of device, no changes in behaviour.

Please reivew.

Jason Wang (5):
  vhost-vdpa: refine ioctl pre-processing
  vhost: generialize backend features setting/getting
  vhost-vdpa: support get/set backend features
  vhost-vdpa: support IOTLB batching hints
  vdpasim: support batch updating

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 40 +++++++++++++++++++++--
 drivers/vhost/net.c              | 18 ++---------
 drivers/vhost/vdpa.c             | 55 ++++++++++++++++++++++++++------
 drivers/vhost/vhost.c            | 15 +++++++++
 drivers/vhost/vhost.h            |  2 ++
 include/uapi/linux/vhost.h       |  2 ++
 include/uapi/linux/vhost_types.h |  7 ++++
 7 files changed, 110 insertions(+), 29 deletions(-)

-- 
2.20.1
