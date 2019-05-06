From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 01/19] drm: Add |struct drm_gem_vram_object| and helpers
Date: Mon, 6 May 2019 14:31:14 +0200
Message-ID: <20190506123114.hzyl2hkix7lvqjyx__9083.17452283285$1557145943$gmane$org@sirius.home.kraxel.org>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506082649.942-2-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190506082649.942-2-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

> +/**
> + * drm_gem_vram_unpin() - Unpins a GEM VRAM object
> + * @gbo:	the GEM VRAM object
> + *
> + * Returns:
> + * 0 on success, or
> + * a negative error code otherwise.
> + */
> +int drm_gem_vram_unpin(struct drm_gem_vram_object *gbo)
> +{
> +	int i, ret;
> +	struct ttm_operation_ctx ctx = { false, false };
> +
> +	if (!gbo->pin_count)
> +		return 0;

WARN_ON_ONCE() here?  That should not happen ...

> +/**
> + * drm_gem_vram_push_to_system() - \
> +	Unpins a GEM VRAM object and moves it to system memory
> + * @gbo:	the GEM VRAM object
> + *
> + * This operation only works if the caller holds the final pin on the
> + * buffer object.
> + *
> + * Returns:
> + * 0 on success, or
> + * a negative error code otherwise.
> + */
> +int drm_gem_vram_push_to_system(struct drm_gem_vram_object *gbo)
> +{
> +	int i, ret;
> +	struct ttm_operation_ctx ctx = { false, false };
> +
> +	if (!gbo->pin_count)
> +		return 0;

Likewise.

> +	--gbo->pin_count;
> +	if (gbo->pin_count)
> +		return 0;
> +
> +	if (gbo->kmap.virtual)
> +		ttm_bo_kunmap(&gbo->kmap);
> +
> +	drm_gem_vram_placement(gbo, TTM_PL_FLAG_SYSTEM);
> +	for (i = 0; i < gbo->placement.num_placement ; ++i)
> +		gbo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
> +
> +	ret = ttm_bo_validate(&gbo->bo, &gbo->placement, &ctx);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_gem_vram_push_to_system);

Very simliar to drm_gem_vram_unpin, can't we just call that function?

Something like this:

	drm_gem_vram_push_to_system()
	{
		if (gbo->pin_count == 1 && gbo->kmap.virtual)
			ttm_bo_kunmap(&gbo->kmap);
		return drm_gem_vram_unpin();
	}

> +struct drm_gem_vram_object {
> +	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
> +	struct ttm_placement placement;
> +	struct ttm_place placements[3];

placements[2] should be enough I guess?

cheers,
  Gerd
