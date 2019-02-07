From: Thomas Hellstrom via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 2/5] drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
Date: Thu, 7 Feb 2019 19:07:42 +0000
Message-ID: <67782273034c55fd14d7c5d20ba35309ade32afe.camel__18319.6622225054$1549716363$gmane$org@vmware.com>
References: <20190207085931.29569-1-tzimmermann@suse.de>
	<20190207085931.29569-3-tzimmermann@suse.de>
Reply-To: Thomas Hellstrom <thellstrom@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190207085931.29569-3-tzimmermann@suse.de>
Content-Language: en-US
Content-ID: <6EEB2504C6D02A44B866B4D8ACED3D53@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "kraxel@redhat.com" <kraxel@redhat.com>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "David1.Zhou@amd.com" <David1.Zhou@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>, "bskeggs@redhat.com" <bskeggs@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "airlied@redhat.com" <airlied@redhat.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Jerry.Zhang@amd.com" <Jerry.Zhang@amd.com>, Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2019-02-07 at 09:59 +0100, Thomas Zimmermann wrote:
> Most TTM drivers define the constant DRM_FILE_PAGE_OFFSET of the same
> value. The only exception is vboxvideo, which is being converted to
> the
> new offset by this patch. Unifying the constants in a single place
> simplifies the driver code.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 2 --
>  drivers/gpu/drm/ast/ast_drv.h               | 2 --
>  drivers/gpu/drm/bochs/bochs.h               | 2 --
>  drivers/gpu/drm/cirrus/cirrus_drv.h         | 1 -
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c | 2 --
>  drivers/gpu/drm/mgag200/mgag200_drv.h       | 1 -
>  drivers/gpu/drm/nouveau/nouveau_drv.h       | 2 --
>  drivers/gpu/drm/qxl/qxl_drv.h               | 3 ---
>  drivers/gpu/drm/radeon/radeon_ttm.c         | 2 --
>  drivers/gpu/drm/virtio/virtgpu_ttm.c        | 2 --
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c         | 2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h         | 1 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 2 +-
>  drivers/staging/vboxvideo/vbox_drv.h        | 2 --
>  include/drm/ttm/ttm_bo_driver.h             | 2 ++
>  15 files changed, 4 insertions(+), 24 deletions(-)
> 
> 

...

> diff --git a/include/drm/ttm/ttm_bo_driver.h
> b/include/drm/ttm/ttm_bo_driver.h
> index cbf3180cb612..c0bed72492f3 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -49,6 +49,8 @@
>  #define TTM_MEMTYPE_FLAG_MAPPABLE      (1 << 1)	/* Memory
> mappable */
>  #define TTM_MEMTYPE_FLAG_CMA           (1 << 3)	/* Can't map
> aperture */
>  
> +#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
> +

IMO strictly, the place in the drm file address space where a driver
chooses to insert the TTM bo address space is to be determined by DRM,
(as also the define indicates) rather than TTM. So I think the right
place for this define is a drm header, not a ttm header.

Thanks,
Thomas


>  struct ttm_mem_type_manager;
>  
>  struct ttm_mem_type_manager_func {
