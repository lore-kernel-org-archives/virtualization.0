Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E4C4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 16:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F9760F56
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 16:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49F9760F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 080EB6088D;
	Tue,  3 Aug 2021 16:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9aNmcz9AM8Z5; Tue,  3 Aug 2021 16:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6EBE660658;
	Tue,  3 Aug 2021 16:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 501FDC001A;
	Tue,  3 Aug 2021 16:13:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 504DBC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 402E483252
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VSwW711mcVpP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:13:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com
 [91.221.196.215])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E770831BD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:13:29 +0000 (UTC)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
 by mx1.smtp.larsendata.com (Halon) with ESMTPS
 id c00e4ed9-f475-11eb-9082-0050568c148b;
 Tue, 03 Aug 2021 16:13:33 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net
 [80.162.45.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: sam@ravnborg.org)
 by mail01.mxhotel.dk (Postfix) with ESMTPSA id 520E9194B79;
 Tue,  3 Aug 2021 18:13:48 +0200 (CEST)
Date: Tue, 3 Aug 2021 18:13:21 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 01/11] drm/gem: Provide offset-adjusted framebuffer BO
 mappings
Message-ID: <YQlrIZxoz9kdUqUz@ravnborg.org>
References: <20210803125928.27780-1-tzimmermann@suse.de>
 <20210803125928.27780-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210803125928.27780-2-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, rodrigosiqueiramelo@gmail.com,
 hdegoede@redhat.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, melissa.srw@gmail.com,
 drawat.floss@gmail.com, noralf@tronnes.org, daniel@ffwll.ch,
 airlied@redhat.com, sean@poorly.run
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Thomas,

On Tue, Aug 03, 2021 at 02:59:18PM +0200, Thomas Zimmermann wrote:
> Add an additional argument to drm_gem_fb_vmap() to return each BO's
> mapping adjusted by the rsp offset. Update all callers.

rsp? respective?

> 
> The newly returned values point to the first by of the data stored
by => byte

> in the framebuffer BOs. Drivers that access the BO data should use
> it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/drm_gem_atomic_helper.c      |  2 +-
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c | 17 ++++++++++++++++-
>  drivers/gpu/drm/gud/gud_pipe.c               |  2 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c        |  2 +-
>  include/drm/drm_gem_atomic_helper.h          |  8 ++++++++
>  include/drm/drm_gem_framebuffer_helper.h     |  3 ++-
>  6 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
> index b1cc19e47165..8410ec3c5db0 100644
> --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> @@ -339,7 +339,7 @@ int drm_gem_prepare_shadow_fb(struct drm_plane *plane, struct drm_plane_state *p
>  	if (ret)
>  		return ret;
>  
> -	return drm_gem_fb_vmap(fb, shadow_plane_state->map);
> +	return drm_gem_fb_vmap(fb, shadow_plane_state->map, shadow_plane_state->data);
>  }
>  EXPORT_SYMBOL(drm_gem_prepare_shadow_fb);
>  
> diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> index 02928607a716..7f2bbe4f0053 100644
> --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> @@ -316,19 +316,25 @@ EXPORT_SYMBOL_GPL(drm_gem_fb_create_with_dirty);
>   * drm_gem_fb_vmap - maps all framebuffer BOs into kernel address space
>   * @fb: the framebuffer
>   * @map: returns the mapping's address for each BO
> + * @data: returns the data address for each BO, can be NULL
>   *
>   * This function maps all buffer objects of the given framebuffer into
>   * kernel address space and stores them in struct dma_buf_map. If the
>   * mapping operation fails for one of the BOs, the function unmaps the
>   * already established mappings automatically.
>   *
> + * Callers that want to access a BO's stored data should pass @data.
> + * The argument returns the addresses of the data stored in each BO. This
> + * is different from @map if the framebuffer's offsets field is non-zero.
> + *
>   * See drm_gem_fb_vunmap() for unmapping.
>   *
>   * Returns:
>   * 0 on success, or a negative errno code otherwise.
>   */
>  int drm_gem_fb_vmap(struct drm_framebuffer *fb,
> -		    struct dma_buf_map map[static DRM_FORMAT_MAX_PLANES])
> +		    struct dma_buf_map map[static DRM_FORMAT_MAX_PLANES],
> +		    struct dma_buf_map data[DRM_FORMAT_MAX_PLANES])
>  {
>  	struct drm_gem_object *obj;
>  	unsigned int i;
> @@ -345,6 +351,15 @@ int drm_gem_fb_vmap(struct drm_framebuffer *fb,
>  			goto err_drm_gem_vunmap;
>  	}
>  
> +	if (data) {
> +		for (i = 0; i < DRM_FORMAT_MAX_PLANES; ++i) {
> +			memcpy(&data[i], &map[i], sizeof(data[i]));
> +			if (dma_buf_map_is_null(&data[i]))
> +				continue;
> +			dma_buf_map_incr(&data[i], fb->offsets[i]);
> +		}
> +	}
> +
>  	return 0;
>  
>  err_drm_gem_vunmap:
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 7e009f562b30..6270a1a32a65 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -162,7 +162,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
>  	if (len > gdrm->bulk_len)
>  		return -E2BIG;
>  
> -	ret = drm_gem_fb_vmap(fb, map);
> +	ret = drm_gem_fb_vmap(fb, map, NULL);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 425b6c6b8cad..3a8e2ed93e7c 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -75,7 +75,7 @@ static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
>  	if (!vkmsjob)
>  		return -ENOMEM;
>  
> -	ret = drm_gem_fb_vmap(job->fb, vkmsjob->map);
> +	ret = drm_gem_fb_vmap(job->fb, vkmsjob->map, NULL);
>  	if (ret) {
>  		DRM_ERROR("vmap failed: %d\n", ret);
>  		goto err_kfree;
> diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
> index f9f8b6f0494a..48222a107873 100644
> --- a/include/drm/drm_gem_atomic_helper.h
> +++ b/include/drm/drm_gem_atomic_helper.h
> @@ -42,6 +42,14 @@ struct drm_shadow_plane_state {
>  	 * prepare_fb callback and removed in the cleanup_fb callback.
>  	 */
>  	struct dma_buf_map map[DRM_FORMAT_MAX_PLANES];
> +
> +	/**
> +	 * @data: Address of each framebuffer BO's data
> +	 *
> +	 * The address of the data stored in each mapping. This is different
> +	 * for framebuffers with non-zero offset fields.
> +	 */
> +	struct dma_buf_map data[DRM_FORMAT_MAX_PLANES];
>  };
>  
>  /**
> diff --git a/include/drm/drm_gem_framebuffer_helper.h b/include/drm/drm_gem_framebuffer_helper.h
> index ff2024dd7b77..905727719ead 100644
> --- a/include/drm/drm_gem_framebuffer_helper.h
> +++ b/include/drm/drm_gem_framebuffer_helper.h
> @@ -40,7 +40,8 @@ drm_gem_fb_create_with_dirty(struct drm_device *dev, struct drm_file *file,
>  			     const struct drm_mode_fb_cmd2 *mode_cmd);
>  
>  int drm_gem_fb_vmap(struct drm_framebuffer *fb,
> -		    struct dma_buf_map map[static DRM_FORMAT_MAX_PLANES]);
> +		    struct dma_buf_map map[static DRM_FORMAT_MAX_PLANES],
> +		    struct dma_buf_map data[DRM_FORMAT_MAX_PLANES]);
>  void drm_gem_fb_vunmap(struct drm_framebuffer *fb,
>  		       struct dma_buf_map map[static DRM_FORMAT_MAX_PLANES]);
>  int drm_gem_fb_begin_cpu_access(struct drm_framebuffer *fb, enum dma_data_direction dir);
> -- 
> 2.32.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
