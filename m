From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/ttm: Rename ttm_bo_global_{init,release}() to
	ttm_bo_global_ref_{,}()
Date: Tue, 16 Oct 2018 10:43:17 +0000
Message-ID: <72d9ad54-af52-55a2-8537-2327fd6f0357@amd.com>
References: <20181016080409.18838-1-tzimmermann@suse.de>
	<20181016080409.18838-2-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181016080409.18838-2-tzimmermann@suse.de>
Content-Language: en-US
Content-ID: <20DC8C8EA0E5E0489BDFAF2F7BA56B34@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>, "Huang, Ray" <Ray.Huang@amd.com>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>, "sean@poorly.run" <sean@poorly.run>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "corbet@lwn.net" <corbet@lwn.net>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "bskeggs@redhat.com" <bskeggs@redhat.com>, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vm>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am 16.10.2018 um 10:04 schrieb Thomas Zimmermann:
> The functions ttm_bo_global_init() and ttm_bo_global_release() do not
> receive an argument of type struct ttm_bo_global. Both take a struct
> drm_global_reference that contains points to a struct ttm_bo_global_ref.
> Renaming them reflects this.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed and pushed upstream.

Christian.

> ---
>   Documentation/gpu/drm-mm.rst                | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 4 ++--
>   drivers/gpu/drm/ast/ast_ttm.c               | 4 ++--
>   drivers/gpu/drm/bochs/bochs_mm.c            | 4 ++--
>   drivers/gpu/drm/cirrus/cirrus_ttm.c         | 4 ++--
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c | 4 ++--
>   drivers/gpu/drm/mgag200/mgag200_ttm.c       | 4 ++--
>   drivers/gpu/drm/nouveau/nouveau_ttm.c       | 4 ++--
>   drivers/gpu/drm/qxl/qxl_ttm.c               | 4 ++--
>   drivers/gpu/drm/radeon/radeon_ttm.c         | 4 ++--
>   drivers/gpu/drm/ttm/ttm_bo.c                | 8 ++++----
>   drivers/gpu/drm/virtio/virtgpu_ttm.c        | 4 ++--
>   drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 4 ++--
>   drivers/staging/vboxvideo/vbox_ttm.c        | 4 ++--
>   include/drm/ttm/ttm_bo_driver.h             | 4 ++--
>   15 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> index e725e8449e72..d0f3c6b03200 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -72,8 +72,8 @@ object TTM to provide a pool for buffer object allocation by clients and
>   the kernel itself. The type of this object should be
>   TTM_GLOBAL_TTM_BO, and its size should be sizeof(struct
>   ttm_bo_global). Again, driver-specific init and release functions may
> -be provided, likely eventually calling ttm_bo_global_init() and
> -ttm_bo_global_release(), respectively. Also, like the previous
> +be provided, likely eventually calling ttm_bo_global_ref_init() and
> +ttm_bo_global_ref_release(), respectively. Also, like the previous
>   object, ttm_global_item_ref() is used to create an initial reference
>   count for the TTM, which will call your initialization function.
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a44fc12ae1f9..3a6802846698 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -125,8 +125,8 @@ static int amdgpu_ttm_global_init(struct amdgpu_device *adev)
>   	global_ref = &adev->mman.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/ast/ast_ttm.c b/drivers/gpu/drm/ast/ast_ttm.c
> index fe354ebf374d..d21fbd26785a 100644
> --- a/drivers/gpu/drm/ast/ast_ttm.c
> +++ b/drivers/gpu/drm/ast/ast_ttm.c
> @@ -70,8 +70,8 @@ static int ast_ttm_global_init(struct ast_private *ast)
>   	global_ref = &ast->ttm.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r != 0) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index e6ccf7fa92d4..ff4f41dec228 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -48,8 +48,8 @@ static int bochs_ttm_global_init(struct bochs_device *bochs)
>   	global_ref = &bochs->ttm.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r != 0) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/cirrus/cirrus_ttm.c b/drivers/gpu/drm/cirrus/cirrus_ttm.c
> index f21953243790..2e2141f26c5b 100644
> --- a/drivers/gpu/drm/cirrus/cirrus_ttm.c
> +++ b/drivers/gpu/drm/cirrus/cirrus_ttm.c
> @@ -70,8 +70,8 @@ static int cirrus_ttm_global_init(struct cirrus_device *cirrus)
>   	global_ref = &cirrus->ttm.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r != 0) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> index 2e3e0bdb8932..0454aa43ffc6 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> @@ -59,8 +59,8 @@ static int hibmc_ttm_global_init(struct hibmc_drm_private *hibmc)
>   		hibmc->mem_global_ref.object;
>   	hibmc->bo_global_ref.ref.global_type = DRM_GLOBAL_TTM_BO;
>   	hibmc->bo_global_ref.ref.size = sizeof(struct ttm_bo_global);
> -	hibmc->bo_global_ref.ref.init = &ttm_bo_global_init;
> -	hibmc->bo_global_ref.ref.release = &ttm_bo_global_release;
> +	hibmc->bo_global_ref.ref.init = &ttm_bo_global_ref_init;
> +	hibmc->bo_global_ref.ref.release = &ttm_bo_global_ref_release;
>   	ret = drm_global_item_ref(&hibmc->bo_global_ref.ref);
>   	if (ret) {
>   		DRM_ERROR("failed setting up TTM BO subsystem: %d\n", ret);
> diff --git a/drivers/gpu/drm/mgag200/mgag200_ttm.c b/drivers/gpu/drm/mgag200/mgag200_ttm.c
> index 05570f0de4d7..3444b539e7f4 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_ttm.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_ttm.c
> @@ -70,8 +70,8 @@ static int mgag200_ttm_global_init(struct mga_device *ast)
>   	global_ref = &ast->ttm.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r != 0) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> index 8edb9f2a4269..a293383c8654 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -209,8 +209,8 @@ nouveau_ttm_global_init(struct nouveau_drm *drm)
>   	global_ref = &drm->ttm.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   
>   	ret = drm_global_item_ref(global_ref);
>   	if (unlikely(ret != 0)) {
> diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
> index 86a1fb32f6db..db2a0036e9c4 100644
> --- a/drivers/gpu/drm/qxl/qxl_ttm.c
> +++ b/drivers/gpu/drm/qxl/qxl_ttm.c
> @@ -80,8 +80,8 @@ static int qxl_ttm_global_init(struct qxl_device *qdev)
>   	global_ref = &qdev->mman.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r != 0) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index cbb67e9ffb3a..dac4ec5a120b 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -97,8 +97,8 @@ static int radeon_ttm_global_init(struct radeon_device *rdev)
>   	global_ref = &rdev->mman.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r != 0) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 26b889f86670..9c2bb880491e 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1522,16 +1522,16 @@ static void ttm_bo_global_kobj_release(struct kobject *kobj)
>   	kfree(glob);
>   }
>   
> -void ttm_bo_global_release(struct drm_global_reference *ref)
> +void ttm_bo_global_ref_release(struct drm_global_reference *ref)
>   {
>   	struct ttm_bo_global *glob = ref->object;
>   
>   	kobject_del(&glob->kobj);
>   	kobject_put(&glob->kobj);
>   }
> -EXPORT_SYMBOL(ttm_bo_global_release);
> +EXPORT_SYMBOL(ttm_bo_global_ref_release);
>   
> -int ttm_bo_global_init(struct drm_global_reference *ref)
> +int ttm_bo_global_ref_init(struct drm_global_reference *ref)
>   {
>   	struct ttm_bo_global_ref *bo_ref =
>   		container_of(ref, struct ttm_bo_global_ref, ref);
> @@ -1564,7 +1564,7 @@ int ttm_bo_global_init(struct drm_global_reference *ref)
>   	kfree(glob);
>   	return ret;
>   }
> -EXPORT_SYMBOL(ttm_bo_global_init);
> +EXPORT_SYMBOL(ttm_bo_global_ref_init);
>   
>   
>   int ttm_bo_device_release(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> index e3152d45c5f1..526a5e48dc3b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -84,8 +84,8 @@ static int virtio_gpu_ttm_global_init(struct virtio_gpu_device *vgdev)
>   	global_ref = &vgdev->mman.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	r = drm_global_item_ref(global_ref);
>   	if (r != 0) {
>   		DRM_ERROR("Failed setting up TTM BO subsystem.\n");
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> index 7b1e5a5cbd2c..f3ce43c41978 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> @@ -76,8 +76,8 @@ int vmw_ttm_global_init(struct vmw_private *dev_priv)
>   	global_ref = &dev_priv->bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   	ret = drm_global_item_ref(global_ref);
>   
>   	if (unlikely(ret != 0)) {
> diff --git a/drivers/staging/vboxvideo/vbox_ttm.c b/drivers/staging/vboxvideo/vbox_ttm.c
> index 548edb7c494b..2329a55d4636 100644
> --- a/drivers/staging/vboxvideo/vbox_ttm.c
> +++ b/drivers/staging/vboxvideo/vbox_ttm.c
> @@ -68,8 +68,8 @@ static int vbox_ttm_global_init(struct vbox_private *vbox)
>   	global_ref = &vbox->ttm.bo_global_ref.ref;
>   	global_ref->global_type = DRM_GLOBAL_TTM_BO;
>   	global_ref->size = sizeof(struct ttm_bo_global);
> -	global_ref->init = &ttm_bo_global_init;
> -	global_ref->release = &ttm_bo_global_release;
> +	global_ref->init = &ttm_bo_global_ref_init;
> +	global_ref->release = &ttm_bo_global_ref_release;
>   
>   	ret = drm_global_item_ref(global_ref);
>   	if (ret) {
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index e4fee8e02559..c3c0751dec63 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -578,8 +578,8 @@ void ttm_bo_mem_put(struct ttm_buffer_object *bo, struct ttm_mem_reg *mem);
>   void ttm_bo_mem_put_locked(struct ttm_buffer_object *bo,
>   			   struct ttm_mem_reg *mem);
>   
> -void ttm_bo_global_release(struct drm_global_reference *ref);
> -int ttm_bo_global_init(struct drm_global_reference *ref);
> +void ttm_bo_global_ref_release(struct drm_global_reference *ref);
> +int ttm_bo_global_ref_init(struct drm_global_reference *ref);
>   
>   int ttm_bo_device_release(struct ttm_bo_device *bdev);
>   
