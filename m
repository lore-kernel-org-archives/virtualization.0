From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/2] virtio: modernize DMA quirks
Date: Wed, 24 Jun 2020 19:21:18 -0400
Message-ID: <20200624232035.704217-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

Use generic names for the quirks to make it clear it is not just about
the IOMMU, it's about DMA access in general.

changes from v1:
	added patch 2

Michael S. Tsirkin (2):
  virtio: VIRTIO_F_IOMMU_PLATFORM -> VIRTIO_F_ACCESS_PLATFORM
  virtio: virtio_has_iommu_quirk -> virtio_has_dma_quirk

 arch/um/drivers/virtio_uml.c            |  2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  4 ++--
 drivers/vdpa/ifcvf/ifcvf_base.h         |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c        |  4 ++--
 drivers/vhost/net.c                     |  4 ++--
 drivers/vhost/vdpa.c                    |  2 +-
 drivers/virtio/virtio_balloon.c         |  2 +-
 drivers/virtio/virtio_ring.c            |  4 ++--
 include/linux/virtio_config.h           |  6 +++---
 include/uapi/linux/virtio_config.h      | 10 +++++++---
 tools/virtio/linux/virtio_config.h      |  6 +++---
 12 files changed, 26 insertions(+), 22 deletions(-)

-- 
MST
