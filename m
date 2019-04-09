From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 13/15] drm/vboxvideo: Convert vboxvideo driver to Simple
	TTM
Date: Tue, 9 Apr 2019 09:09:50 +0200
Message-ID: <0dc20e8f-3b93-25da-b40a-bf67540890fe__6485.50222847319$1554793805$gmane$org@redhat.com>
References: <20190408092144.4548-1-tzimmermann@suse.de>
	<20190408092144.4548-14-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190408092144.4548-14-tzimmermann@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, christian.koenig@amd.com, ray.huang@amd.com, Jerry.Zhang@amd.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 08-04-19 11:21, Thomas Zimmermann wrote:
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Patch looks good to me (although perhaps it needs a commit msg):

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/gpu/drm/vboxvideo/Kconfig    |   1 +
>   drivers/gpu/drm/vboxvideo/vbox_drv.h |   6 +-
>   drivers/gpu/drm/vboxvideo/vbox_ttm.c | 123 ++-------------------------
>   3 files changed, 12 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/Kconfig b/drivers/gpu/drm/vboxvideo/Kconfig
> index c1ca87df81df..e29df360978d 100644
> --- a/drivers/gpu/drm/vboxvideo/Kconfig
> +++ b/drivers/gpu/drm/vboxvideo/Kconfig
> @@ -4,6 +4,7 @@ config DRM_VBOXVIDEO
>   	select DRM_KMS_HELPER
>   	select DRM_TTM
>   	select DRM_GEM_TTM_HELPER
> +	select DRM_SIMPLE_TTM_HELPER
>   	select GENERIC_ALLOCATOR
>   	help
>   	  This is a KMS driver for the virtual Graphics Card used in
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.h b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> index 7db4e961805d..d4cfcc6339ef 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.h
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> @@ -20,6 +20,8 @@
>   #include <drm/drm_gem.h>
>   #include <drm/drm_gem_ttm_helper.h>
>   
> +#include <drm/drm_simple_ttm_helper.h>
> +
>   #include <drm/ttm/ttm_bo_api.h>
>   #include <drm/ttm/ttm_bo_driver.h>
>   #include <drm/ttm/ttm_placement.h>
> @@ -78,9 +80,7 @@ struct vbox_private {
>   
>   	int fb_mtrr;
>   
> -	struct {
> -		struct ttm_bo_device bdev;
> -	} ttm;
> +	struct drm_simple_ttm ttm;
>   
>   	struct mutex hw_mutex; /* protects modeset and accel/vbva accesses */
>   	struct work_struct hotplug_work;
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_ttm.c b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> index a1d64e1ea90c..115ec44636ab 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> @@ -11,128 +11,25 @@
>   #include <drm/ttm/ttm_page_alloc.h>
>   #include "vbox_drv.h"
>   
> -static inline struct vbox_private *vbox_bdev(struct ttm_bo_device *bd)
> -{
> -	return container_of(bd, struct vbox_private, ttm.bdev);
> -}
> -
> -static int
> -vbox_bo_init_mem_type(struct ttm_bo_device *bdev, u32 type,
> -		      struct ttm_mem_type_manager *man)
> -{
> -	switch (type) {
> -	case TTM_PL_SYSTEM:
> -		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE;
> -		man->available_caching = TTM_PL_MASK_CACHING;
> -		man->default_caching = TTM_PL_FLAG_CACHED;
> -		break;
> -	case TTM_PL_VRAM:
> -		man->func = &ttm_bo_manager_func;
> -		man->flags = TTM_MEMTYPE_FLAG_FIXED | TTM_MEMTYPE_FLAG_MAPPABLE;
> -		man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
> -		man->default_caching = TTM_PL_FLAG_WC;
> -		break;
> -	default:
> -		DRM_ERROR("Unsupported memory type %u\n", (unsigned int)type);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int vbox_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
> -				   struct ttm_mem_reg *mem)
> -{
> -	struct ttm_mem_type_manager *man = &bdev->man[mem->mem_type];
> -	struct vbox_private *vbox = vbox_bdev(bdev);
> -
> -	mem->bus.addr = NULL;
> -	mem->bus.offset = 0;
> -	mem->bus.size = mem->num_pages << PAGE_SHIFT;
> -	mem->bus.base = 0;
> -	mem->bus.is_iomem = false;
> -	if (!(man->flags & TTM_MEMTYPE_FLAG_MAPPABLE))
> -		return -EINVAL;
> -	switch (mem->mem_type) {
> -	case TTM_PL_SYSTEM:
> -		/* system memory */
> -		return 0;
> -	case TTM_PL_VRAM:
> -		mem->bus.offset = mem->start << PAGE_SHIFT;
> -		mem->bus.base = pci_resource_start(vbox->ddev.pdev, 0);
> -		mem->bus.is_iomem = true;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -static void vbox_ttm_io_mem_free(struct ttm_bo_device *bdev,
> -				 struct ttm_mem_reg *mem)
> -{
> -}
> -
> -static void vbox_ttm_backend_destroy(struct ttm_tt *tt)
> -{
> -	ttm_tt_fini(tt);
> -	kfree(tt);
> -}
> -
> -static struct ttm_backend_func vbox_tt_backend_func = {
> -	.destroy = &vbox_ttm_backend_destroy,
> -};
> -
> -static struct ttm_tt *vbox_ttm_tt_create(struct ttm_buffer_object *bo,
> -					 u32 page_flags)
> -{
> -	struct ttm_tt *tt;
> -
> -	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
> -	if (!tt)
> -		return NULL;
> -
> -	tt->func = &vbox_tt_backend_func;
> -	if (ttm_tt_init(tt, bo, page_flags)) {
> -		kfree(tt);
> -		return NULL;
> -	}
> -
> -	return tt;
> -}
> -
> -static struct ttm_bo_driver vbox_bo_driver = {
> -	.ttm_tt_create = vbox_ttm_tt_create,
> -	.init_mem_type = vbox_bo_init_mem_type,
> -	.eviction_valuable = ttm_bo_eviction_valuable,
> +static const struct drm_simple_ttm_funcs vbox_simple_ttm_funcs = {
>   	.evict_flags = drm_gem_ttm_bo_driver_evict_flags,
> -	.verify_access = drm_gem_ttm_bo_driver_verify_access,
> -	.io_mem_reserve = &vbox_ttm_io_mem_reserve,
> -	.io_mem_free = &vbox_ttm_io_mem_free,
> +	.verify_access = drm_gem_ttm_bo_driver_verify_access
>   };
>   
>   int vbox_mm_init(struct vbox_private *vbox)
>   {
>   	int ret;
>   	struct drm_device *dev = &vbox->ddev;
> -	struct ttm_bo_device *bdev = &vbox->ttm.bdev;
>   
> -	ret = ttm_bo_device_init(&vbox->ttm.bdev,
> -				 &vbox_bo_driver,
> -				 dev->anon_inode->i_mapping,
> -				 true);
> +	ret = drm_simple_ttm_init(&vbox->ttm, dev,
> +				  pci_resource_start(dev->pdev, 0),
> +				  vbox->available_vram_size,
> +				  &vbox_simple_ttm_funcs);
>   	if (ret) {
> -		DRM_ERROR("Error initialising bo driver; %d\n", ret);
> +		DRM_ERROR("Error initializing Simple TTM; %d\n", ret);
>   		return ret;
>   	}
>   
> -	ret = ttm_bo_init_mm(bdev, TTM_PL_VRAM,
> -			     vbox->available_vram_size >> PAGE_SHIFT);
> -	if (ret) {
> -		DRM_ERROR("Failed ttm VRAM init: %d\n", ret);
> -		goto err_device_release;
> -	}
> -
>   #ifdef DRM_MTRR_WC
>   	vbox->fb_mtrr = drm_mtrr_add(pci_resource_start(dev->pdev, 0),
>   				     pci_resource_len(dev->pdev, 0),
> @@ -142,10 +39,6 @@ int vbox_mm_init(struct vbox_private *vbox)
>   					 pci_resource_len(dev->pdev, 0));
>   #endif
>   	return 0;
> -
> -err_device_release:
> -	ttm_bo_device_release(&vbox->ttm.bdev);
> -	return ret;
>   }
>   
>   void vbox_mm_fini(struct vbox_private *vbox)
> @@ -157,7 +50,7 @@ void vbox_mm_fini(struct vbox_private *vbox)
>   #else
>   	arch_phys_wc_del(vbox->fb_mtrr);
>   #endif
> -	ttm_bo_device_release(&vbox->ttm.bdev);
> +	drm_simple_ttm_cleanup(&vbox->ttm);
>   }
>   
>   int vbox_mmap(struct file *filp, struct vm_area_struct *vma)
> 
