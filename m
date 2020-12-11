Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C00C4167B
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 10:18:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD18F23C18
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 10:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD18F23C18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3376285FE4;
	Fri, 11 Dec 2020 10:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P-HEbqlHo2x6; Fri, 11 Dec 2020 10:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3475885FC1;
	Fri, 11 Dec 2020 10:18:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 257D0C0FA7;
	Fri, 11 Dec 2020 10:18:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E8C9C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3B5E485FC6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Vqbmardf44c
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:18:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2B96385FC1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:18:38 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id r3so8464069wrt.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 02:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=WTgIBhdbimoRqEKAqfy9UxFMlho1PbiR1/VTSg638fk=;
 b=ApyqeucfRJrWGD1YXoJ1Es24YE3AVFRoe66fne88FW9C9LRUCF0a9SfX2u2KGPu/1f
 ZQFx4Gs4ephPIZuY8cpQxk24991ywDfrCOwll3oYJEDvdIH1whCTela8yn8SqqpF4Wjn
 7+yY8UmfvTlC6Xv0qh2h684H0AKjTpmcKg0ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=WTgIBhdbimoRqEKAqfy9UxFMlho1PbiR1/VTSg638fk=;
 b=tj0+til8bFE/1uLoM1EiMvHviVkANykdUFmVl/2Zk3DN8MbTux6xb9m/rXoGykG3aA
 VsaH1Wq9DzD8Vr1w+pmIbCd4cpYx5t8FnKoRo3FUbBrmRGy6cWTa1r+0JbvHtruVB4Ox
 pc9MAlfVwJhuRRaQEnhomk2KdB8XXqtEHNOZIdRQYoqIUHuzALvOXXPAmnQ+nY9VjztN
 AfsvDYhTQQ3ZEnuKSZptpzhv+75ym7w43rEzX14rFQUUosb34zwY3spB/9IoMyCVjha6
 GAfMvpJvHJ+/fyeT3tQ/xrt733LVi3KGINB/dLncZZvtyXbpcESvyYKeu4PZIE2LbOCq
 gHtQ==
X-Gm-Message-State: AOAM532U4rheIcxQBTcNWmmq+021ZTCRgnuoxeKR6Mb2WfWaS8bhfpT7
 X3P4PzY1UNYEk/GgW0juLWww4A==
X-Google-Smtp-Source: ABdhPJydCLTNSaiC4iyGoBNXTHc3OTs5jbw1npF1wAAkwnCOql4XTGDxa6tugRdwv1xQiazY+EKuNg==
X-Received: by 2002:adf:9167:: with SMTP id j94mr13144979wrj.249.1607681916638; 
 Fri, 11 Dec 2020 02:18:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k7sm16338003wrn.63.2020.12.11.02.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 02:18:35 -0800 (PST)
Date: Fri, 11 Dec 2020 11:18:33 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 2/8] drm/ast: Only map cursor BOs during updates
Message-ID: <20201211101833.GQ401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209142527.26415-3-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: eric@anholt.net, airlied@linux.ie, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
 hdegoede@redhat.com, daniel@ffwll.ch,
 virtualization@lists.linux-foundation.org, sean@poorly.run,
 christian.koenig@amd.com, linux-media@vger.kernel.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Dec 09, 2020 at 03:25:21PM +0100, Thomas Zimmermann wrote:
> The HW cursor's BO used to be mapped permanently into the kernel's
> address space. GEM's vmap operation will be protected by locks, and
> we don't want to lock the BO's for an indefinate period of time.
> =

> Change the cursor code to map the HW BOs only during updates. The
> vmap operation in VRAM helpers is cheap, as a once estabished mapping
> is being reused until the BO actually moves. As the HW cursor BOs are
> permanently pinned, they never move at all.
> =

> v2:
> 	* fix typos in commit description
> =

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Christian K=F6nig <christian.koenig@amd.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Now there's a pretty big issue here though: We can't take dma_resv_lock in
commit_tail, because of possible deadlocks on at least gpus that do real
async rendering because of the dma_fences. Unfortunately my annotations
patches got stuck a bit, I need to refresh them.

Rules are you can pin and unpin stuff in prepare/cleanup_plane, and also
take dma_resv_lock there, but not in commit_tail in-between. So I think
our vmap_local needs to loose the unconditional assert_locked and require
either that or a pin count.
-Daniel

> ---
>  drivers/gpu/drm/ast/ast_cursor.c | 51 ++++++++++++++++++--------------
>  drivers/gpu/drm/ast/ast_drv.h    |  2 --
>  2 files changed, 28 insertions(+), 25 deletions(-)
> =

> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_c=
ursor.c
> index 68bf3d33f1ed..fac1ee79c372 100644
> --- a/drivers/gpu/drm/ast/ast_cursor.c
> +++ b/drivers/gpu/drm/ast/ast_cursor.c
> @@ -39,7 +39,6 @@ static void ast_cursor_fini(struct ast_private *ast)
>  =

>  	for (i =3D 0; i < ARRAY_SIZE(ast->cursor.gbo); ++i) {
>  		gbo =3D ast->cursor.gbo[i];
> -		drm_gem_vram_vunmap(gbo, &ast->cursor.map[i]);
>  		drm_gem_vram_unpin(gbo);
>  		drm_gem_vram_put(gbo);
>  	}
> @@ -53,14 +52,13 @@ static void ast_cursor_release(struct drm_device *dev=
, void *ptr)
>  }
>  =

>  /*
> - * Allocate cursor BOs and pins them at the end of VRAM.
> + * Allocate cursor BOs and pin them at the end of VRAM.
>   */
>  int ast_cursor_init(struct ast_private *ast)
>  {
>  	struct drm_device *dev =3D &ast->base;
>  	size_t size, i;
>  	struct drm_gem_vram_object *gbo;
> -	struct dma_buf_map map;
>  	int ret;
>  =

>  	size =3D roundup(AST_HWC_SIZE + AST_HWC_SIGNATURE_SIZE, PAGE_SIZE);
> @@ -77,15 +75,7 @@ int ast_cursor_init(struct ast_private *ast)
>  			drm_gem_vram_put(gbo);
>  			goto err_drm_gem_vram_put;
>  		}
> -		ret =3D drm_gem_vram_vmap(gbo, &map);
> -		if (ret) {
> -			drm_gem_vram_unpin(gbo);
> -			drm_gem_vram_put(gbo);
> -			goto err_drm_gem_vram_put;
> -		}
> -
>  		ast->cursor.gbo[i] =3D gbo;
> -		ast->cursor.map[i] =3D map;
>  	}
>  =

>  	return drmm_add_action_or_reset(dev, ast_cursor_release, NULL);
> @@ -94,7 +84,6 @@ int ast_cursor_init(struct ast_private *ast)
>  	while (i) {
>  		--i;
>  		gbo =3D ast->cursor.gbo[i];
> -		drm_gem_vram_vunmap(gbo, &ast->cursor.map[i]);
>  		drm_gem_vram_unpin(gbo);
>  		drm_gem_vram_put(gbo);
>  	}
> @@ -168,31 +157,38 @@ static void update_cursor_image(u8 __iomem *dst, co=
nst u8 *src, int width, int h
>  int ast_cursor_blit(struct ast_private *ast, struct drm_framebuffer *fb)
>  {
>  	struct drm_device *dev =3D &ast->base;
> -	struct drm_gem_vram_object *gbo;
> -	struct dma_buf_map map;
> -	int ret;
> -	void *src;
> +	struct drm_gem_vram_object *dst_gbo =3D ast->cursor.gbo[ast->cursor.nex=
t_index];
> +	struct drm_gem_vram_object *src_gbo =3D drm_gem_vram_of_gem(fb->obj[0]);
> +	struct dma_buf_map src_map, dst_map;
>  	void __iomem *dst;
> +	void *src;
> +	int ret;
>  =

>  	if (drm_WARN_ON_ONCE(dev, fb->width > AST_MAX_HWC_WIDTH) ||
>  	    drm_WARN_ON_ONCE(dev, fb->height > AST_MAX_HWC_HEIGHT))
>  		return -EINVAL;
>  =

> -	gbo =3D drm_gem_vram_of_gem(fb->obj[0]);
> -
> -	ret =3D drm_gem_vram_vmap(gbo, &map);
> +	ret =3D drm_gem_vram_vmap(src_gbo, &src_map);
>  	if (ret)
>  		return ret;
> -	src =3D map.vaddr; /* TODO: Use mapping abstraction properly */
> +	src =3D src_map.vaddr; /* TODO: Use mapping abstraction properly */
>  =

> -	dst =3D ast->cursor.map[ast->cursor.next_index].vaddr_iomem;
> +	ret =3D drm_gem_vram_vmap(dst_gbo, &dst_map);
> +	if (ret)
> +		goto err_drm_gem_vram_vunmap;
> +	dst =3D dst_map.vaddr_iomem; /* TODO: Use mapping abstraction properly =
*/
>  =

>  	/* do data transfer to cursor BO */
>  	update_cursor_image(dst, src, fb->width, fb->height);
>  =

> -	drm_gem_vram_vunmap(gbo, &map);
> +	drm_gem_vram_vunmap(dst_gbo, &dst_map);
> +	drm_gem_vram_vunmap(src_gbo, &src_map);
>  =

>  	return 0;
> +
> +err_drm_gem_vram_vunmap:
> +	drm_gem_vram_vunmap(src_gbo, &src_map);
> +	return ret;
>  }
>  =

>  static void ast_cursor_set_base(struct ast_private *ast, u64 address)
> @@ -243,17 +239,26 @@ static void ast_cursor_set_location(struct ast_priv=
ate *ast, u16 x, u16 y,
>  void ast_cursor_show(struct ast_private *ast, int x, int y,
>  		     unsigned int offset_x, unsigned int offset_y)
>  {
> +	struct drm_device *dev =3D &ast->base;
> +	struct drm_gem_vram_object *gbo =3D ast->cursor.gbo[ast->cursor.next_in=
dex];
> +	struct dma_buf_map map;
>  	u8 x_offset, y_offset;
>  	u8 __iomem *dst;
>  	u8 __iomem *sig;
>  	u8 jreg;
> +	int ret;
>  =

> -	dst =3D ast->cursor.map[ast->cursor.next_index].vaddr;
> +	ret =3D drm_gem_vram_vmap(gbo, &map);
> +	if (drm_WARN_ONCE(dev, ret, "drm_gem_vram_vmap() failed, ret=3D%d\n", r=
et))
> +		return;
> +	dst =3D map.vaddr_iomem; /* TODO: Use mapping abstraction properly */
>  =

>  	sig =3D dst + AST_HWC_SIZE;
>  	writel(x, sig + AST_HWC_SIGNATURE_X);
>  	writel(y, sig + AST_HWC_SIGNATURE_Y);
>  =

> +	drm_gem_vram_vunmap(gbo, &map);
> +
>  	if (x < 0) {
>  		x_offset =3D (-x) + offset_x;
>  		x =3D 0;
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index ccaff81924ee..f871fc36c2f7 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -28,7 +28,6 @@
>  #ifndef __AST_DRV_H__
>  #define __AST_DRV_H__
>  =

> -#include <linux/dma-buf-map.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
>  #include <linux/io.h>
> @@ -133,7 +132,6 @@ struct ast_private {
>  =

>  	struct {
>  		struct drm_gem_vram_object *gbo[AST_DEFAULT_HWC_NUM];
> -		struct dma_buf_map map[AST_DEFAULT_HWC_NUM];
>  		unsigned int next_index;
>  	} cursor;
>  =

> -- =

> 2.29.2
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
