Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E329C43381
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:06:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D1622AAD
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D1622AAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8DA586D52;
	Mon, 11 Jan 2021 17:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ONvwm5nmwuoH; Mon, 11 Jan 2021 17:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D1BF86D51;
	Mon, 11 Jan 2021 17:06:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB73C088B;
	Mon, 11 Jan 2021 17:06:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 075E3C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E4AB920338
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:06:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07pT+Iih6ESK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:06:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by silver.osuosl.org (Postfix) with ESMTPS id E8DC420009
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:06:27 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id t16so540069wra.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p7Uc2OyCpbZc27r6+RhlQios2u1l6dYrQyaRRy//21k=;
 b=kuotTnsOzNzbbq3i4nOilnPGqxJC4JBrJeu+7gf3kPgh40xQZWqDosulRpinytv8op
 TTL/t4wkczzGW71GV/L28Dg0id7cqSdsvZbAOTxpr7v0PTUsbHHCb0DHjRigdiOpDuku
 oiFMysSetGPniYcfzDCXrOR0tVdsXrhgUU7a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p7Uc2OyCpbZc27r6+RhlQios2u1l6dYrQyaRRy//21k=;
 b=RsdF/dbzEuwmME3/uCUB0j/Ve2YMkG43pqlJnnozMI2fjMO8dyOung63lapDrFLP36
 S09VToaZN1U7QLKf3dw3WIM//OqTATz1RGK6jArFGGOlTYchFJ4bPQCRAMTkMqsm/687
 QkJ7vo3cwZDPaAyLvDukI53IUMPclXvuWOv0zm5OAY2bTpGoPzGNHe/SdS5va0qHBATB
 IJjDupF/lkildU43Z+MCoLDeBD7eTxW5D4PscJhuDInKpEPgTxvS+E3tIPV0TdP1kh3y
 pV5l1sI2xFVPXcUAYpPYw9z7+YIsgxqoVQRYv3NtqFBnAHaQQj8EWfgps5Sxh/NnD6c0
 HiSw==
X-Gm-Message-State: AOAM533BuSLh+y+qMvQUi1oRexkJqLv7gZ9MnJIwqI/oP3Xl7ul+p6zK
 ylY1kVPweeCFbhznsIV0FvIPdA==
X-Google-Smtp-Source: ABdhPJyegMlvqCqOihCDnGvYO+RAtSicUNBZxCpbQB3gvjm2ZoKp8GO/MFPQDu1494yGCJmdOUhrwg==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr122544wra.252.1610384786298; 
 Mon, 11 Jan 2021 09:06:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id r20sm326591wrg.66.2021.01.11.09.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 09:06:25 -0800 (PST)
Date: Mon, 11 Jan 2021 18:06:23 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 11/13] drm/vboxvideo: Use drm_gem_vram_vmap_local() in
 cursor update
Message-ID: <X/yFj9zIdW52UKk4@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-12-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108094340.15290-12-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: eric@anholt.net, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org, hdegoede@redhat.com,
 daniel@ffwll.ch, airlied@redhat.com, virtualization@lists.linux-foundation.org,
 sean@poorly.run, sumit.semwal@linaro.org, linux-media@vger.kernel.org
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

On Fri, Jan 08, 2021 at 10:43:38AM +0100, Thomas Zimmermann wrote:
> Cursor updates in vboxvideo require a short-term mapping of the
> source BO. Use drm_gem_vram_vmap_local() and avoid the pinning
> operations.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

All these drivers patches break the dma_resv_lock vs
dma_fence_begin/end_signalling nesting rules, so this doesn't work.

Generally this is what the prepare/cleanup_fb hooks are for, that's where
mappings (including vmaps) are meant to be set up, permanently.

I'm kinda not clear on why we need all these changes, I thought the
locking problem is just in the fb helper paths, because it's outside of
the atomic path and could conflict with an atomic update at the same time?
So only that one should get the vmap_local treatment, everything else
should keep the normal vmap treatment.
-Daniel
> ---
>  drivers/gpu/drm/vboxvideo/vbox_mode.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> index dbc0dd53c69e..215b37c78c10 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> @@ -381,7 +381,8 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
>  		container_of(plane->dev, struct vbox_private, ddev);
>  	struct vbox_crtc *vbox_crtc = to_vbox_crtc(plane->state->crtc);
>  	struct drm_framebuffer *fb = plane->state->fb;
> -	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(fb->obj[0]);
> +	struct drm_gem_object *obj = fb->obj[0];
> +	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(obj);
>  	u32 width = plane->state->crtc_w;
>  	u32 height = plane->state->crtc_h;
>  	size_t data_size, mask_size;
> @@ -401,11 +402,12 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
>  
>  	vbox_crtc->cursor_enabled = true;
>  
> -	ret = drm_gem_vram_vmap(gbo, &map);
> +	ret = dma_resv_lock(obj->resv, NULL);
> +	if (ret)
> +		return;
> +	ret = drm_gem_vram_vmap_local(gbo, &map);
>  	if (ret) {
> -		/*
> -		 * BUG: we should have pinned the BO in prepare_fb().
> -		 */
> +		dma_resv_unlock(obj->resv);
>  		mutex_unlock(&vbox->hw_mutex);
>  		DRM_WARN("Could not map cursor bo, skipping update\n");
>  		return;
> @@ -421,7 +423,8 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
>  	data_size = width * height * 4 + mask_size;
>  
>  	copy_cursor_image(src, vbox->cursor_data, width, height, mask_size);
> -	drm_gem_vram_vunmap(gbo, &map);
> +	drm_gem_vram_vunmap_local(gbo, &map);
> +	dma_resv_unlock(obj->resv);
>  
>  	flags = VBOX_MOUSE_POINTER_VISIBLE | VBOX_MOUSE_POINTER_SHAPE |
>  		VBOX_MOUSE_POINTER_ALPHA;
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
