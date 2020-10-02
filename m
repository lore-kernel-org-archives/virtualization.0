Return-Path: <SRS0=l9dZ=DJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A58C4363D
	for <virtualization@archiver.kernel.org>; Fri,  2 Oct 2020 13:04:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DC2206E3
	for <virtualization@archiver.kernel.org>; Fri,  2 Oct 2020 13:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ld4XU9dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DC2206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 00B6E204F0;
	Fri,  2 Oct 2020 13:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hMzV-sNUpMmU; Fri,  2 Oct 2020 13:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6367C204CA;
	Fri,  2 Oct 2020 13:04:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47D9AC016F;
	Fri,  2 Oct 2020 13:04:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C62EC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 13:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2BA5520459
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 13:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqdT6A+pTe3c
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 13:04:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 7CA8C204CA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 13:04:46 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id m6so1775172wrn.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Oct 2020 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=BRdG+Sv9lbvsBV80MeJ5uYgZhZMNFbaqhIia52Zq8gE=;
 b=ld4XU9dC3LDxekGn7GamKDrYPL7jSfU1sRt03W6y6ZG7Aj0ZYozjOKbQG2CqnDAQ+a
 Wm85y42hH9jUGUKeb3Qq0XMhu73F73vVo9TsKURGxDLRrOQhbtc2wTcM+8/StKpZWy9v
 y7aSSQFwbsgDSwiglVqPKSeUy1LEYeYYNmeDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BRdG+Sv9lbvsBV80MeJ5uYgZhZMNFbaqhIia52Zq8gE=;
 b=necF+NOnnSxbW5U6lwKcU2oajVFeYskVzlVflcsKroGY/Tjz3E2uMobtXX7PRF6iYw
 pJgJ6TSpm1S6PxBsNRIPirqgpDjxbZ4Bi7Sf8xIA2WWKYX3eCwAvVOp7amH7sRg42Ux6
 wEIvDXXX25B0l0d809JRG//cM/ez7TRIUlZALq+eASpqOoRCpKAUH2bKAfQnjvchrUxp
 oWmF+fthH0ujjU+SoSTwrVvAwbGg+vJqpGEqK32L55eGXaGWbBNywM+MgYlsqKrMVi1W
 oJ9Ix6oBXOwqWLr4JMnour89mG/r9XlIrbywpC2Dman/WSZzXP+WvHhQq59G400IKMT2
 Cl7w==
X-Gm-Message-State: AOAM532iQvi9d9hQQh/brFJs+P6G3CI+/FwXPrW5AkyG2elv0a8Bn1Sy
 nxYA2BF38WmNGgdKXRD+q0PILA==
X-Google-Smtp-Source: ABdhPJyzB9ctK1WKL4a99n8wsCE482hZW17HPxIJTgRxw4A/5rqlGoYgwqEr/r2ZqiiE1CWrWADjIQ==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr3054113wrn.228.1601643884841; 
 Fri, 02 Oct 2020 06:04:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id d13sm1695267wrp.44.2020.10.02.06.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:04:43 -0700 (PDT)
Date: Fri, 2 Oct 2020 15:04:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 4/7] drm/gem: Update internal GEM vmap/vunmap
 interfaces to use struct dma_buf_map
Message-ID: <20201002130440.GK438822@phenom.ffwll.local>
References: <20200929151437.19717-1-tzimmermann@suse.de>
 <20200929151437.19717-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929151437.19717-5-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: luben.tuikov@amd.com, heiko@sntech.de, airlied@linux.ie,
 nouveau@lists.freedesktop.org, linus.walleij@linaro.org,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 melissa.srw@gmail.com, eric@anholt.net, ray.huang@amd.com, sam@ravnborg.org,
 sumit.semwal@linaro.org, emil.velikov@collabora.com, robh@kernel.org,
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 lima@lists.freedesktop.org, oleksandr_andrushchenko@epam.com, krzk@kernel.org,
 steven.price@arm.com, linux-rockchip@lists.infradead.org, kgene@kernel.org,
 bskeggs@redhat.com, linux+etnaviv@armlinux.org.uk,
 spice-devel@lists.freedesktop.org, alyssa.rosenzweig@collabora.com,
 maarten.lankhorst@linux.intel.com, etnaviv@lists.freedesktop.org,
 mripard@kernel.org, inki.dae@samsung.com, hdegoede@redhat.com,
 christian.gmeiner@gmail.com, xen-devel@lists.xenproject.org,
 virtualization@lists.linux-foundation.org, sean@poorly.run, apaneers@amd.com,
 linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, tomeu.vizoso@collabora.com,
 sw0312.kim@samsung.com, hjc@rock-chips.com, kyungmin.park@samsung.com,
 miaoqinglang@huawei.com, yuq825@gmail.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, linux-media@vger.kernel.org,
 christian.koenig@amd.com, l.stach@pengutronix.de
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

On Tue, Sep 29, 2020 at 05:14:34PM +0200, Thomas Zimmermann wrote:
> GEM's vmap and vunmap interfaces now wrap memory pointers in struct
> dma_buf_map.
> =

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_client.c   | 18 +++++++++++-------
>  drivers/gpu/drm/drm_gem.c      | 28 ++++++++++++++--------------
>  drivers/gpu/drm/drm_internal.h |  5 +++--
>  drivers/gpu/drm/drm_prime.c    | 14 ++++----------
>  4 files changed, 32 insertions(+), 33 deletions(-)
> =

> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index 495f47d23d87..ac0082bed966 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -3,6 +3,7 @@
>   * Copyright 2018 Noralf Tr=F8nnes
>   */
>  =

> +#include <linux/dma-buf-map.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -304,7 +305,8 @@ drm_client_buffer_create(struct drm_client_dev *clien=
t, u32 width, u32 height, u
>   */
>  void *drm_client_buffer_vmap(struct drm_client_buffer *buffer)
>  {
> -	void *vaddr;
> +	struct dma_buf_map map;
> +	int ret;
>  =

>  	if (buffer->vaddr)
>  		return buffer->vaddr;
> @@ -317,13 +319,13 @@ void *drm_client_buffer_vmap(struct drm_client_buff=
er *buffer)
>  	 * fd_install step out of the driver backend hooks, to make that
>  	 * final step optional for internal users.
>  	 */
> -	vaddr =3D drm_gem_vmap(buffer->gem);
> -	if (IS_ERR(vaddr))
> -		return vaddr;
> +	ret =3D drm_gem_vmap(buffer->gem, &map);
> +	if (ret)
> +		return ERR_PTR(ret);
>  =

> -	buffer->vaddr =3D vaddr;
> +	buffer->vaddr =3D map.vaddr;
>  =

> -	return vaddr;
> +	return map.vaddr;
>  }
>  EXPORT_SYMBOL(drm_client_buffer_vmap);
>  =

> @@ -337,7 +339,9 @@ EXPORT_SYMBOL(drm_client_buffer_vmap);
>   */
>  void drm_client_buffer_vunmap(struct drm_client_buffer *buffer)
>  {
> -	drm_gem_vunmap(buffer->gem, buffer->vaddr);
> +	struct dma_buf_map map =3D DMA_BUF_MAP_INIT_VADDR(buffer->vaddr);
> +
> +	drm_gem_vunmap(buffer->gem, &map);
>  	buffer->vaddr =3D NULL;
>  }
>  EXPORT_SYMBOL(drm_client_buffer_vunmap);
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 0c4a66dea5c2..f2b2f37d41c4 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1205,32 +1205,32 @@ void drm_gem_unpin(struct drm_gem_object *obj)
>  		obj->funcs->unpin(obj);
>  }
>  =

> -void *drm_gem_vmap(struct drm_gem_object *obj)
> +int drm_gem_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
>  {
> -	struct dma_buf_map map;
>  	int ret;
>  =

> -	if (!obj->funcs->vmap) {
> -		return ERR_PTR(-EOPNOTSUPP);
> +	if (!obj->funcs->vmap)
> +		return -EOPNOTSUPP;
>  =

> -	ret =3D obj->funcs->vmap(obj, &map);
> +	ret =3D obj->funcs->vmap(obj, map);
>  	if (ret)
> -		return ERR_PTR(ret);
> -	else if (dma_buf_map_is_null(&map))
> -		return ERR_PTR(-ENOMEM);
> +		return ret;
> +	else if (dma_buf_map_is_null(map))
> +		return -ENOMEM;
>  =

> -	return map.vaddr;
> +	return 0;
>  }
>  =

> -void drm_gem_vunmap(struct drm_gem_object *obj, void *vaddr)
> +void drm_gem_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map)
>  {
> -	struct dma_buf_map map =3D DMA_BUF_MAP_INIT_VADDR(vaddr);
> -
> -	if (!vaddr)
> +	if (dma_buf_map_is_null(map))
>  		return;
>  =

>  	if (obj->funcs->vunmap)
> -		obj->funcs->vunmap(obj, &map);
> +		obj->funcs->vunmap(obj, map);
> +
> +	/* Always set the mapping to NULL. Callers may rely on this. */
> +	dma_buf_map_clear(map);
>  }
>  =

>  /**
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_interna=
l.h
> index b65865c630b0..58832d75a9bd 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -33,6 +33,7 @@
>  =

>  struct dentry;
>  struct dma_buf;
> +struct dma_buf_map;
>  struct drm_connector;
>  struct drm_crtc;
>  struct drm_framebuffer;
> @@ -187,8 +188,8 @@ void drm_gem_print_info(struct drm_printer *p, unsign=
ed int indent,
>  =

>  int drm_gem_pin(struct drm_gem_object *obj);
>  void drm_gem_unpin(struct drm_gem_object *obj);
> -void *drm_gem_vmap(struct drm_gem_object *obj);
> -void drm_gem_vunmap(struct drm_gem_object *obj, void *vaddr);
> +int drm_gem_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
> +void drm_gem_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map);
>  =

>  /* drm_debugfs.c drm_debugfs_crc.c */
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 89e2a2496734..cb8fbeeb731b 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -667,21 +667,15 @@ EXPORT_SYMBOL(drm_gem_unmap_dma_buf);
>   *
>   * Sets up a kernel virtual mapping. This can be used as the &dma_buf_op=
s.vmap
>   * callback. Calls into &drm_gem_object_funcs.vmap for device specific h=
andling.
> + * The kernel virtual address is returned in map.
>   *
> - * Returns the kernel virtual address or NULL on failure.
> + * Returns 0 on success or a negative errno code otherwise.
>   */
>  int drm_gem_dmabuf_vmap(struct dma_buf *dma_buf, struct dma_buf_map *map)
>  {
>  	struct drm_gem_object *obj =3D dma_buf->priv;
> -	void *vaddr;
>  =

> -	vaddr =3D drm_gem_vmap(obj);
> -	if (IS_ERR(vaddr))
> -		return PTR_ERR(vaddr);
> -
> -	dma_buf_map_set_vaddr(map, vaddr);
> -
> -	return 0;
> +	return drm_gem_vmap(obj, map);
>  }
>  EXPORT_SYMBOL(drm_gem_dmabuf_vmap);
>  =

> @@ -697,7 +691,7 @@ void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, s=
truct dma_buf_map *map)
>  {
>  	struct drm_gem_object *obj =3D dma_buf->priv;
>  =

> -	drm_gem_vunmap(obj, map->vaddr);
> +	drm_gem_vunmap(obj, map);
>  }
>  EXPORT_SYMBOL(drm_gem_dmabuf_vunmap);

Some of the transitional stuff disappearing!

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>  =

> -- =

> 2.28.0
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
