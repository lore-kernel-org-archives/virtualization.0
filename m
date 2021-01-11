Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C13C433E6
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 16:53:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD84C2242A
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 16:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD84C2242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A2611870C3;
	Mon, 11 Jan 2021 16:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ARqkF0ZNeGOO; Mon, 11 Jan 2021 16:53:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E74186BE2;
	Mon, 11 Jan 2021 16:53:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9157AC088B;
	Mon, 11 Jan 2021 16:53:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 614E3C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5C824867F0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id doP8gY3dSiHO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:53:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 34974867E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:53:46 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id v14so422188wml.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 08:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BKC0evkXZWcyXdGHOdDWdLxv+2YIG23jjrv2ITmXGIQ=;
 b=f2cIISkhKkxD+6ziwoDlFIC/KnEne4zqVI9ATW8WxcwU7HfEthL+03Wj3lkxUchqS3
 /WGreq/q3CYEM1yc7ykmE2LcR8/EDk3++qTMvmg2dDKFRxjFyuVKdjbu82HfncPHeu2C
 4Mqi+7z550gOUOI+aHrTfXZ2RuzUNOGr1tf3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BKC0evkXZWcyXdGHOdDWdLxv+2YIG23jjrv2ITmXGIQ=;
 b=Si45EwlpdDJMZMzHcgdiiowH9EAza3jylt5BsjOBNa+1QEpWuvAMuyFSv1qcB2AzJQ
 /sXlMVy3iyuV+PWiLOEDVuBcCqYnhip/9RbHloaDehvw4YzwMjESwmFiYaYEH7AazMNN
 CIsXNfigJtGcgyLrBk1lXyTdSOs34a0V4IlFqL3d9cTEIZ/Om98UwWa7yxIaudaOiCRC
 bQACuj+ZS5TW5OQRbiAPVT91N9NQJP1/pArLbCmxXaVergMaN49o9MPqf28Jl+LVkwqR
 R5+KJu6xUIiRM86oJQPz2Rhu4IQzmxCdHjvvhEhX4RxuOQ9k6RZWNDO9x6nNmOvihUQf
 SxfA==
X-Gm-Message-State: AOAM533EgI+x4fYY4JfcXXXabM/RtU58rhSWpgm3JErmtaKZtP/hB2dp
 VPI1Hu9UsgBpjsPM5QX+lTQtUA==
X-Google-Smtp-Source: ABdhPJyVeudWNsRG/VKpD0MFuEfV8F2YrsSfFQ/sscFBJ0jdG0Vu75xdwPKdNjqVKbdnVXqp/usYtQ==
X-Received: by 2002:a1c:2182:: with SMTP id h124mr545791wmh.25.1610384024539; 
 Mon, 11 Jan 2021 08:53:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u83sm440737wmu.12.2021.01.11.08.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 08:53:43 -0800 (PST)
Date: Mon, 11 Jan 2021 17:53:41 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 05/13] drm/mgag200: Use drm_gem_shmem_vmap_local() in
 damage handling
Message-ID: <X/yClQZQ0B5AMfEP@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108094340.15290-6-tzimmermann@suse.de>
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

On Fri, Jan 08, 2021 at 10:43:32AM +0100, Thomas Zimmermann wrote:
> Damage handling in mgag200 requires a short-term mapping of the source
> BO. Use drm_gem_shmem_vmap_local().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/mgag200/mgag200_mode.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 1dfc42170059..a33e28d4c5e9 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -1552,22 +1552,32 @@ mgag200_handle_damage(struct mga_device *mdev, struct drm_framebuffer *fb,
>  		      struct drm_rect *clip)
>  {
>  	struct drm_device *dev = &mdev->base;
> +	struct drm_gem_object *obj = fb->obj[0];
>  	struct dma_buf_map map;
>  	void *vmap;
>  	int ret;
>  
> -	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
> +	ret = dma_resv_lock(obj->resv, NULL);
>  	if (drm_WARN_ON(dev, ret))
> -		return; /* BUG: SHMEM BO should always be vmapped */
> +		return;
> +	ret = drm_gem_shmem_vmap_local(obj, &map);
> +	if (drm_WARN_ON(dev, ret))
> +		goto err_dma_resv_unlock; /* BUG: SHMEM BO should always be vmapped */
>  	vmap = map.vaddr; /* TODO: Use mapping abstraction properly */
>  
>  	drm_fb_memcpy_dstclip(mdev->vram, vmap, fb, clip);
>  
> -	drm_gem_shmem_vunmap(fb->obj[0], &map);
> +	drm_gem_shmem_vunmap_local(obj, &map);
> +	dma_resv_unlock(obj->resv);
>  
>  	/* Always scanout image at VRAM offset 0 */
>  	mgag200_set_startadd(mdev, (u32)0);
>  	mgag200_set_offset(mdev, fb);
> +
> +	return;
> +
> +err_dma_resv_unlock:
> +	dma_resv_unlock(obj->resv);
>  }
>  
>  static void
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
