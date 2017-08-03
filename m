From: Cihangir Akturk <cakturk@gmail.com>
Subject: [PATCH 00/29] DRM API conversions
Date: Thu,  3 Aug 2017 14:58:15 +0300
Message-ID: <1501761585-11757-1-git-send-email-cakturk__4942.20126788623$1509078903$gmane$org@gmail.com>
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
Cc: Xinliang Liu <xinliang.liu@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, dri-devel@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>, Alex Xie <AlexBin.Xie@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, linux-samsung-soc@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, etnaviv@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>, Dave Airlie <airlied@redhat.com>, Wei Yongjun <weiyj.lk@gmail.com>, =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <Nicolai.Haehnle@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>, linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, Andrew Morton <akpm@linux-foundation.org>, freedreno@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

This patch set replaces the occurrences of drm_*_reference() and
drm_*_unreference() with the new drm_*_get() and drm_*_put() functions.
All patches in the series do the same thing, converting to the new APIs.
I created patches per DRM driver as suggested by Daniel Vetter.

Background:

In the kernel, reference counting APIs use *_get(), *_put() style naming
to reference-count the objects. But DRM subsystem uses a different
naming for them such as *_reference(), *_unreference() which is
inconsistent with the other reference counting APIs in the kernel. To
solve this consistency issue, Thierry Reding introduced a couple of
functions and compatibility aliases in the following commits for them.

commit 020a218f95bd3ceff7dd1022ff7ebc0497bc7bf9
Author: Thierry Reding <treding@nvidia.com>
Date:   Tue Feb 28 15:46:38 2017 +0100

    drm: Introduce drm_mode_object_{get,put}()

commit ad09360750afa18a0a0ce0253d6ea6033abc22e7
Author: Thierry Reding <treding@nvidia.com>
Date:   Tue Feb 28 15:46:39 2017 +0100

    drm: Introduce drm_connector_{get,put}()

commit a4a69da06bc11a937a6e417938b1bb698ee1fa46
Author: Thierry Reding <treding@nvidia.com>
Date:   Tue Feb 28 15:46:40 2017 +0100

    drm: Introduce drm_framebuffer_{get,put}()

commit e6b62714e87c8811d5564b6a0738dcde63a51774
Author: Thierry Reding <treding@nvidia.com>
Date:   Tue Feb 28 15:46:41 2017 +0100

    drm: Introduce drm_gem_object_{get,put}()

commit 6472e5090be7c78749a3c279b4faae87ab835c40
Author: Thierry Reding <treding@nvidia.com>
Date:   Tue Feb 28 15:46:42 2017 +0100

    drm: Introduce drm_property_blob_{get,put}()


This patch set was generated using the following shell script:

#!/bin/sh

path=$1

do_replace() {
    local pattern=$1
    local replacement=$2

    git grep -lw "${pattern}" -- "${path}/*.[hc]" |\
        xargs -r sed -i "s/\b$pattern\b/$replacement/g"
}

do_replace drm_mode_object_reference drm_mode_object_get
do_replace drm_mode_object_unreference drm_mode_object_put
do_replace drm_connector_reference drm_connector_get
do_replace drm_connector_unreference drm_connector_put
do_replace drm_framebuffer_reference drm_framebuffer_get
do_replace drm_framebuffer_unreference drm_framebuffer_put
do_replace drm_gem_object_reference drm_gem_object_get
do_replace drm_gem_object_unreference drm_gem_object_put
do_replace __drm_gem_object_unreference __drm_gem_object_put
do_replace drm_gem_object_unreference_unlocked drm_gem_object_put_unlocked
do_replace drm_property_reference_blob drm_property_blob_get
do_replace drm_property_unreference_blob drm_property_blob_put

Cihangir Akturk (29):
  drm/amdgpu: switch to drm_*{get,put} helpers
  drm: mali-dp: switch to drm_*{get,put} helpers
  drm/armada: switch to drm_*{get,put} helpers
  drm/ast: switch to drm_*{get,put} helpers
  drm/atmel-hlcdc: switch to drm_*{get,put} helpers
  drm/bochs: switch to drm_*{get,put} helpers
  drm/cirrus: switch to drm_*{get,put} helpers
  drm/etnaviv: switch to drm_*{get,put} helpers
  drm/exynos: switch to drm_*{get,put} helpers
  drm/gma500: switch to drm_*{get,put} helpers
  drm/hisilicon: switch to drm_*{get,put} helpers
  drm/i915: switch to drm_*{get,put} helpers
  drm/imx: switch to drm_*{get,put} helpers
  drm/mediatek: switch to drm_*{get,put} helpers
  drm/mgag200: switch to drm_*{get,put} helpers
  drm/msm: switch to drm_*{get,put} helpers
  drm/nouveau: switch to drm_*{get,put} helpers
  drm/omap: switch to drm_*{get,put} helpers
  drm/qxl: switch to drm_*{get,put} helpers
  drm/radeon: switch to drm_*{get,put} helpers
  drm/rockchip: switch to drm_*{get,put} helpers
  drm/tegra: switch to drm_*{get,put} helpers
  drm/tilcdc: switch to drm_*{get,put} helpers
  drm/udl: switch to drm_*{get,put} helpers
  drm/vc4: switch to drm_*{get,put} helpers
  drm/vgem: switch to drm_*{get,put} helpers
  drm/virtio: switch to drm_*{get,put} helpers
  drm/vmwgfx: switch to drm_*{get,put} helpers
  staging: vboxvideo: switch to drm_*{get,put} helpers

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c            |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c           | 22 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  6 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  6 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  6 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  6 ++---
 drivers/gpu/drm/arm/malidp_planes.c               |  2 +-
 drivers/gpu/drm/armada/armada_crtc.c              | 22 ++++++++---------
 drivers/gpu/drm/armada/armada_drv.c               |  2 +-
 drivers/gpu/drm/armada/armada_fb.c                |  8 +++---
 drivers/gpu/drm/armada/armada_fbdev.c             |  6 ++---
 drivers/gpu/drm/armada/armada_gem.c               | 14 +++++------
 drivers/gpu/drm/armada/armada_overlay.c           |  4 +--
 drivers/gpu/drm/ast/ast_fb.c                      |  2 +-
 drivers/gpu/drm/ast/ast_main.c                    | 10 ++++----
 drivers/gpu/drm/ast/ast_mode.c                    |  6 ++---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  8 +++---
 drivers/gpu/drm/bochs/bochs_fbdev.c               |  2 +-
 drivers/gpu/drm/bochs/bochs_mm.c                  | 10 ++++----
 drivers/gpu/drm/cirrus/cirrus_fbdev.c             |  2 +-
 drivers/gpu/drm/cirrus/cirrus_main.c              | 10 ++++----
 drivers/gpu/drm/etnaviv/etnaviv_drv.c             |  8 +++---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c             | 20 +++++++--------
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c       |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c      |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_fb.c            |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_gem.c           | 12 ++++-----
 drivers/gpu/drm/exynos/exynos_drm_plane.c         |  2 +-
 drivers/gpu/drm/gma500/framebuffer.c              |  4 +--
 drivers/gpu/drm/gma500/gem.c                      |  4 +--
 drivers/gpu/drm/gma500/gma_display.c              |  6 ++---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c |  4 +--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c       |  8 +++---
 drivers/gpu/drm/i915/i915_gem_object.h            | 10 ++++----
 drivers/gpu/drm/i915/intel_display.c              | 24 +++++++++---------
 drivers/gpu/drm/i915/intel_dp_mst.c               |  2 +-
 drivers/gpu/drm/i915/intel_fbdev.c                |  4 +--
 drivers/gpu/drm/imx/ipuv3-crtc.c                  |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c             |  4 +--
 drivers/gpu/drm/mediatek/mtk_drm_gem.c            |  4 +--
 drivers/gpu/drm/mgag200/mgag200_cursor.c          |  2 +-
 drivers/gpu/drm/mgag200/mgag200_fb.c              |  4 +--
 drivers/gpu/drm/mgag200/mgag200_main.c            | 10 ++++----
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c             | 10 ++++----
 drivers/gpu/drm/msm/adreno/a5xx_power.c           |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c           |  2 +-
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c          |  6 ++---
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c           |  2 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c          |  2 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c         |  4 +--
 drivers/gpu/drm/msm/msm_drv.c                     |  8 +++---
 drivers/gpu/drm/msm/msm_fb.c                      |  4 +--
 drivers/gpu/drm/msm/msm_fbdev.c                   |  2 +-
 drivers/gpu/drm/msm/msm_gem.c                     |  8 +++---
 drivers/gpu/drm/msm/msm_gem_submit.c              |  4 +--
 drivers/gpu/drm/msm/msm_gpu.c                     |  4 +--
 drivers/gpu/drm/msm/msm_ringbuffer.c              |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c           |  2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c           |  2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c         |  8 +++---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c           |  2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c             | 14 +++++------
 drivers/gpu/drm/nouveau/nv50_display.c            |  2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                |  2 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                 |  4 +--
 drivers/gpu/drm/omapdrm/omap_fbdev.c              |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                |  4 +--
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c         |  2 +-
 drivers/gpu/drm/qxl/qxl_display.c                 |  4 +--
 drivers/gpu/drm/qxl/qxl_dumb.c                    |  2 +-
 drivers/gpu/drm/qxl/qxl_fb.c                      |  6 ++---
 drivers/gpu/drm/qxl/qxl_gem.c                     |  2 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                   |  4 +--
 drivers/gpu/drm/qxl/qxl_object.c                  |  6 ++---
 drivers/gpu/drm/radeon/radeon_cs.c                |  2 +-
 drivers/gpu/drm/radeon/radeon_cursor.c            |  6 ++---
 drivers/gpu/drm/radeon/radeon_display.c           | 12 ++++-----
 drivers/gpu/drm/radeon/radeon_fb.c                |  4 +--
 drivers/gpu/drm/radeon/radeon_gem.c               | 30 +++++++++++------------
 drivers/gpu/drm/radeon/radeon_object.c            |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c        |  6 ++---
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c       |  4 +--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c       |  4 +--
 drivers/gpu/drm/tegra/drm.c                       | 12 ++++-----
 drivers/gpu/drm/tegra/fb.c                        |  8 +++---
 drivers/gpu/drm/tegra/gem.c                       | 10 ++++----
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c              |  6 ++---
 drivers/gpu/drm/udl/udl_fb.c                      |  6 ++---
 drivers/gpu/drm/udl/udl_gem.c                     |  4 +--
 drivers/gpu/drm/vc4/vc4_bo.c                      | 12 ++++-----
 drivers/gpu/drm/vc4/vc4_crtc.c                    |  6 ++---
 drivers/gpu/drm/vc4/vc4_gem.c                     | 14 +++++------
 drivers/gpu/drm/vc4/vc4_kms.c                     |  2 +-
 drivers/gpu/drm/vgem/vgem_drv.c                   |  4 +--
 drivers/gpu/drm/vgem/vgem_fence.c                 |  2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c          |  4 +--
 drivers/gpu/drm/virtio/virtgpu_gem.c              |  4 +--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c            | 14 +++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c             |  4 +--
 drivers/staging/vboxvideo/vbox_fb.c               |  2 +-
 drivers/staging/vboxvideo/vbox_main.c             |  8 +++---
 drivers/staging/vboxvideo/vbox_mode.c             |  2 +-
 107 files changed, 319 insertions(+), 319 deletions(-)

-- 
2.7.4
