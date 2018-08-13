From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 0/2] Provide init/release functions for struct
	ttm_bo_global
Date: Mon, 13 Aug 2018 12:33:52 +0200
Message-ID: <b77c649e-4c5d-a19d-8c46-d91c69859293__12700.7472016432$1534156335$gmane$org@amd.com>
References: <20180813102443.12662-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180813102443.12662-1-tzimmermann@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>, ray.huang@amd.com, Jerry.Zhang@amd.com, dri-devel@lists.freedesktop.org
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, nouveau@lists.freedesktop.org, syeh@vmware.com, airlied@linux.ie, puck.chen@hisilicon.com, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, linux-graphics-maintainer@vmware.com, gregkh@linuxfoundation.org, alexander.deucher@amd.com, bskeggs@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Yes, please! I had it on my TODO list to clean that up for an eternity.

Actually I never understood why that should be driver work to setup TTM?

I mean can't we just have a module_init/module_exit for TTM?

Thanks,
Christian.

Am 13.08.2018 um 12:24 schrieb Thomas Zimmermann:
> TTM uses global memory and BO for backing graphics buffers. These are
> represented by struct ttm_mem_global and struct ttm_bo_global.
>
> Currently, struct ttm_bo_global can only be initialized and released through
> struct ttm_bo_global_ref. This is a workaround for passing an instance of
> ttm_mem_global to the BO global initialization code.
>
> The use of struct ttm_bo_global_ref makes driver code unnecessary hard to
> understand. At the same time drivers can use any combination of memory and
> BO for initializing the global instances. This can result in subtle bugs
> when the order of initializing and releasing drivers changes.
>
> As a first step for resolving these problems, the provided patch set
> separates initialization and release of struct ttm_bo_global from
> struct ttm_bo_global_ref.
>
> The first patch only renames ttm_bo_global_{init/release}. Hopefully this
> change can be applied at once for all drivers.
>
> Future directions: All TTM-based drivers follow the same pattern for setting
> up the TTM. In a follow-up patch, this code can be moved into a single place
> and shared among drivers.
>
> Thomas Zimmermann (2):
>    drm/ttm: Rename ttm_bo_global_{init,release}() to
>      ttm_bo_global_ref_*()
>    drm/ttm: Provide ttm_bo_global_{init/release}() for struct
>      ttm_bo_global
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  4 +-
>   drivers/gpu/drm/ast/ast_ttm.c               |  4 +-
>   drivers/gpu/drm/bochs/bochs_mm.c            |  4 +-
>   drivers/gpu/drm/cirrus/cirrus_ttm.c         |  4 +-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c |  4 +-
>   drivers/gpu/drm/mgag200/mgag200_ttm.c       |  4 +-
>   drivers/gpu/drm/nouveau/nouveau_ttm.c       |  4 +-
>   drivers/gpu/drm/qxl/qxl_ttm.c               |  4 +-
>   drivers/gpu/drm/radeon/radeon_ttm.c         |  4 +-
>   drivers/gpu/drm/ttm/ttm_bo.c                | 12 ++---
>   drivers/gpu/drm/virtio/virtgpu_ttm.c        |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    |  4 +-
>   drivers/staging/vboxvideo/vbox_ttm.c        |  4 +-
>   include/drm/ttm/ttm_bo_driver.h             | 53 ++++++++++++++++-----
>   14 files changed, 70 insertions(+), 43 deletions(-)
>
> --
> 2.18.0
>
