From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v3 2/3] drm: plumb attaching dev thru to prime_pin/unpin
Date: Wed, 17 Jul 2019 06:59:03 +0000
Message-ID: <fc57fbc8-3b37-519b-a6e2-9714df3c7715__44889.210075938$1563346759$gmane$org@amd.com>
References: <20190716213746.4670-1-robdclark@gmail.com>
	<20190716213746.4670-2-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190716213746.4670-2-robdclark@gmail.com>
Content-Language: en-US
Content-ID: <E6EDA68FB1F2154482748941D0CB311D@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Clark <robdclark@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Eric Biggers <ebiggers@google.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Imre Deak <imre.deak@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Eric Anholt <eric@anholt.net>, Emil Velikov <emil.velikov@collabora.com>, Rob Clark <robdclark@chromium.org>, "Zhou,
	David(ChunMing)" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Ben Skeggs <bskeggs@redhat.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Dave Airlie <airlied@redhat.com>, "Sharma,
	Deepak" <Deepak.Sharma@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>"etnaviv@lists.freedesktop.org" <e>
List-Id: virtualization@lists.linuxfoundation.org

Am 16.07.19 um 23:37 schrieb Rob Clark:
> From: Rob Clark <robdclark@chromium.org>
>
> Needed in the following patch for cache operations.

Well have you seen that those callbacks are deprecated?
>   	 * Deprecated hook in favour of &drm_gem_object_funcs.pin.

>   	 * Deprecated hook in favour of &drm_gem_object_funcs.unpin.
>

I would rather say if you want to extend something it would be better to 
switch over to the per GEM object functions first.

Regards,
Christian.

>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> v3: rebased on drm-tip
>
>   drivers/gpu/drm/drm_gem.c                   | 8 ++++----
>   drivers/gpu/drm/drm_internal.h              | 4 ++--
>   drivers/gpu/drm/drm_prime.c                 | 4 ++--
>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 4 ++--
>   drivers/gpu/drm/msm/msm_drv.h               | 4 ++--
>   drivers/gpu/drm/msm/msm_gem_prime.c         | 4 ++--
>   drivers/gpu/drm/nouveau/nouveau_gem.h       | 4 ++--
>   drivers/gpu/drm/nouveau/nouveau_prime.c     | 4 ++--
>   drivers/gpu/drm/qxl/qxl_prime.c             | 4 ++--
>   drivers/gpu/drm/radeon/radeon_prime.c       | 4 ++--
>   drivers/gpu/drm/vgem/vgem_drv.c             | 4 ++--
>   include/drm/drm_drv.h                       | 5 ++---
>   12 files changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 84689ccae885..af2549c45027 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1215,22 +1215,22 @@ void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
>   		obj->dev->driver->gem_print_info(p, indent, obj);
>   }
>   
> -int drm_gem_pin(struct drm_gem_object *obj)
> +int drm_gem_pin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	if (obj->funcs && obj->funcs->pin)
>   		return obj->funcs->pin(obj);
>   	else if (obj->dev->driver->gem_prime_pin)
> -		return obj->dev->driver->gem_prime_pin(obj);
> +		return obj->dev->driver->gem_prime_pin(obj, dev);
>   	else
>   		return 0;
>   }
>   
> -void drm_gem_unpin(struct drm_gem_object *obj)
> +void drm_gem_unpin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	if (obj->funcs && obj->funcs->unpin)
>   		obj->funcs->unpin(obj);
>   	else if (obj->dev->driver->gem_prime_unpin)
> -		obj->dev->driver->gem_prime_unpin(obj);
> +		obj->dev->driver->gem_prime_unpin(obj, dev);
>   }
>   
>   void *drm_gem_vmap(struct drm_gem_object *obj)
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index 51a2055c8f18..e64090373e3a 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -133,8 +133,8 @@ void drm_gem_release(struct drm_device *dev, struct drm_file *file_private);
>   void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
>   			const struct drm_gem_object *obj);
>   
> -int drm_gem_pin(struct drm_gem_object *obj);
> -void drm_gem_unpin(struct drm_gem_object *obj);
> +int drm_gem_pin(struct drm_gem_object *obj, struct device *dev);
> +void drm_gem_unpin(struct drm_gem_object *obj, struct device *dev);
>   void *drm_gem_vmap(struct drm_gem_object *obj);
>   void drm_gem_vunmap(struct drm_gem_object *obj, void *vaddr);
>   
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 189d980402ad..126860432ff9 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -575,7 +575,7 @@ int drm_gem_map_attach(struct dma_buf *dma_buf,
>   {
>   	struct drm_gem_object *obj = dma_buf->priv;
>   
> -	return drm_gem_pin(obj);
> +	return drm_gem_pin(obj, attach->dev);
>   }
>   EXPORT_SYMBOL(drm_gem_map_attach);
>   
> @@ -593,7 +593,7 @@ void drm_gem_map_detach(struct dma_buf *dma_buf,
>   {
>   	struct drm_gem_object *obj = dma_buf->priv;
>   
> -	drm_gem_unpin(obj);
> +	drm_gem_unpin(obj, attach->dev);
>   }
>   EXPORT_SYMBOL(drm_gem_map_detach);
>   
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index a05292e8ed6f..67e69a5f00f2 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -43,7 +43,7 @@ int etnaviv_gem_prime_mmap(struct drm_gem_object *obj,
>   	return etnaviv_obj->ops->mmap(etnaviv_obj, vma);
>   }
>   
> -int etnaviv_gem_prime_pin(struct drm_gem_object *obj)
> +int etnaviv_gem_prime_pin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	if (!obj->import_attach) {
>   		struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> @@ -55,7 +55,7 @@ int etnaviv_gem_prime_pin(struct drm_gem_object *obj)
>   	return 0;
>   }
>   
> -void etnaviv_gem_prime_unpin(struct drm_gem_object *obj)
> +void etnaviv_gem_prime_unpin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	if (!obj->import_attach) {
>   		struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index ee7b512dc158..0eea68618b68 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -288,8 +288,8 @@ void msm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
>   int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>   struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,
>   		struct dma_buf_attachment *attach, struct sg_table *sg);
> -int msm_gem_prime_pin(struct drm_gem_object *obj);
> -void msm_gem_prime_unpin(struct drm_gem_object *obj);
> +int msm_gem_prime_pin(struct drm_gem_object *obj, struct device *dev);
> +void msm_gem_prime_unpin(struct drm_gem_object *obj, struct device *dev);
>   void *msm_gem_get_vaddr(struct drm_gem_object *obj);
>   void *msm_gem_get_vaddr_active(struct drm_gem_object *obj);
>   void msm_gem_put_vaddr(struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
> index 5d64e0671f7a..cc07bf94e206 100644
> --- a/drivers/gpu/drm/msm/msm_gem_prime.c
> +++ b/drivers/gpu/drm/msm/msm_gem_prime.c
> @@ -47,14 +47,14 @@ struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,
>   	return msm_gem_import(dev, attach->dmabuf, sg);
>   }
>   
> -int msm_gem_prime_pin(struct drm_gem_object *obj)
> +int msm_gem_prime_pin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	if (!obj->import_attach)
>   		msm_gem_get_pages(obj);
>   	return 0;
>   }
>   
> -void msm_gem_prime_unpin(struct drm_gem_object *obj)
> +void msm_gem_prime_unpin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	if (!obj->import_attach)
>   		msm_gem_put_pages(obj);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.h b/drivers/gpu/drm/nouveau/nouveau_gem.h
> index fe39998f65cc..91dcf89138f1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.h
> @@ -32,9 +32,9 @@ extern int nouveau_gem_ioctl_cpu_fini(struct drm_device *, void *,
>   extern int nouveau_gem_ioctl_info(struct drm_device *, void *,
>   				  struct drm_file *);
>   
> -extern int nouveau_gem_prime_pin(struct drm_gem_object *);
> +extern int nouveau_gem_prime_pin(struct drm_gem_object *, struct device *);
>   struct reservation_object *nouveau_gem_prime_res_obj(struct drm_gem_object *);
> -extern void nouveau_gem_prime_unpin(struct drm_gem_object *);
> +extern void nouveau_gem_prime_unpin(struct drm_gem_object *, struct device *);
>   extern struct sg_table *nouveau_gem_prime_get_sg_table(struct drm_gem_object *);
>   extern struct drm_gem_object *nouveau_gem_prime_import_sg_table(
>   	struct drm_device *, struct dma_buf_attachment *, struct sg_table *);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
> index 1fefc93af1d7..dec2d5e37b34 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_prime.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
> @@ -88,7 +88,7 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
>   	return &nvbo->gem;
>   }
>   
> -int nouveau_gem_prime_pin(struct drm_gem_object *obj)
> +int nouveau_gem_prime_pin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct nouveau_bo *nvbo = nouveau_gem_object(obj);
>   	int ret;
> @@ -101,7 +101,7 @@ int nouveau_gem_prime_pin(struct drm_gem_object *obj)
>   	return 0;
>   }
>   
> -void nouveau_gem_prime_unpin(struct drm_gem_object *obj)
> +void nouveau_gem_prime_unpin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct nouveau_bo *nvbo = nouveau_gem_object(obj);
>   
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> index 7d3816fca5a8..21e9b44eb2e4 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -28,14 +28,14 @@
>   /* Empty Implementations as there should not be any other driver for a virtual
>    * device that might share buffers with qxl */
>   
> -int qxl_gem_prime_pin(struct drm_gem_object *obj)
> +int qxl_gem_prime_pin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct qxl_bo *bo = gem_to_qxl_bo(obj);
>   
>   	return qxl_bo_pin(bo);
>   }
>   
> -void qxl_gem_prime_unpin(struct drm_gem_object *obj)
> +void qxl_gem_prime_unpin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct qxl_bo *bo = gem_to_qxl_bo(obj);
>   
> diff --git a/drivers/gpu/drm/radeon/radeon_prime.c b/drivers/gpu/drm/radeon/radeon_prime.c
> index deaffce50a2e..f3442bd860f6 100644
> --- a/drivers/gpu/drm/radeon/radeon_prime.c
> +++ b/drivers/gpu/drm/radeon/radeon_prime.c
> @@ -83,7 +83,7 @@ struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
>   	return &bo->gem_base;
>   }
>   
> -int radeon_gem_prime_pin(struct drm_gem_object *obj)
> +int radeon_gem_prime_pin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct radeon_bo *bo = gem_to_radeon_bo(obj);
>   	int ret = 0;
> @@ -101,7 +101,7 @@ int radeon_gem_prime_pin(struct drm_gem_object *obj)
>   	return ret;
>   }
>   
> -void radeon_gem_prime_unpin(struct drm_gem_object *obj)
> +void radeon_gem_prime_unpin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct radeon_bo *bo = gem_to_radeon_bo(obj);
>   	int ret = 0;
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 76d95b5e289c..e7d12e93b1f0 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -307,7 +307,7 @@ static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
>   	mutex_unlock(&bo->pages_lock);
>   }
>   
> -static int vgem_prime_pin(struct drm_gem_object *obj)
> +static int vgem_prime_pin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct drm_vgem_gem_object *bo = to_vgem_bo(obj);
>   	long n_pages = obj->size >> PAGE_SHIFT;
> @@ -325,7 +325,7 @@ static int vgem_prime_pin(struct drm_gem_object *obj)
>   	return 0;
>   }
>   
> -static void vgem_prime_unpin(struct drm_gem_object *obj)
> +static void vgem_prime_unpin(struct drm_gem_object *obj, struct device *dev)
>   {
>   	struct drm_vgem_gem_object *bo = to_vgem_bo(obj);
>   
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index b33f2cee2099..2b3d79bde6e1 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -592,20 +592,19 @@ struct drm_driver {
>   	 */
>   	struct drm_gem_object * (*gem_prime_import)(struct drm_device *dev,
>   				struct dma_buf *dma_buf);
> -
>   	/**
>   	 * @gem_prime_pin:
>   	 *
>   	 * Deprecated hook in favour of &drm_gem_object_funcs.pin.
>   	 */
> -	int (*gem_prime_pin)(struct drm_gem_object *obj);
> +	int (*gem_prime_pin)(struct drm_gem_object *obj, struct device *dev);
>   
>   	/**
>   	 * @gem_prime_unpin:
>   	 *
>   	 * Deprecated hook in favour of &drm_gem_object_funcs.unpin.
>   	 */
> -	void (*gem_prime_unpin)(struct drm_gem_object *obj);
> +	void (*gem_prime_unpin)(struct drm_gem_object *obj, struct device *dev);
>   
>   
>   	/**
