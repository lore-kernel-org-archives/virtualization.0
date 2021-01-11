Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D7C433E0
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:01:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA17C2242A
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA17C2242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8A97E858BF;
	Mon, 11 Jan 2021 17:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk4vInFXX_vg; Mon, 11 Jan 2021 17:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 820F9858DD;
	Mon, 11 Jan 2021 17:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AFB7C088B;
	Mon, 11 Jan 2021 17:01:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E33F6C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D25DA858DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0fsRmSVQyIdl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 098AD85F7B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:01:08 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id c133so427069wme.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 09:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=h0Vcdr3u2Wixid8zktcI7cI+5TKj52I2FHlTJKRSBHc=;
 b=kIa/HvmC5VFVR+bpiDN8EWfF1Ft5f8oGplJEb1RRZB5iSBFjlp6S+gufUJW/+0Sg9p
 gEk7J80sOTVLe9dP0l7xmrvNCNZZtUvOKJ1YtJ+zgKhzTyL2EnZ/Q/8XISk0mNO4J2IQ
 CU/YWPaRXAbEo28w2H72Bj4Ao5TZKb+EhUuvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h0Vcdr3u2Wixid8zktcI7cI+5TKj52I2FHlTJKRSBHc=;
 b=OP1QdCcaLl7v+dlFGE3+EoUR1T5fBj+sJWMD3AGUtzVYYunVtkTmANGzt8oA9ah3gv
 XxjvhZMaufQyp6EXgOVSoSqSvrc9zagZvHcCTGYhF85B48pOfZa+UAczBLhpupaJ1Nb2
 yHw2oQAaOADK/MjEDpGszIIE5OFDX3/GHFdace7AN2ODOqW+JZlCkiJ/szGMSwKgmGhZ
 6kcXV0U8MX/9f3bmmQ/jls+TsGNmJCwFlpXp6A+waO7bOeNCuL7j8RdKbbzyyT2vN3YU
 pZ+010GpXLhk7XvlVa4pARia2kZS5hhlMGyE7Iztq4qX6023QKtU1RwyO+tQS+nE+FH7
 QmKQ==
X-Gm-Message-State: AOAM531DKv1gJZh2ZFvW0Yukx6opLU2zd9nlbJz83k+clHlnLTOBn/C9
 t9ZAqPLhIpVPZoeCr3VrUCbwxw==
X-Google-Smtp-Source: ABdhPJwL/K8/fonepgQIrr8Jh7d27AlEEHxuAM3nq6S2KLm42gWIC6KhBdKdioyLbnmUAZH47MqlaQ==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr577402wmj.88.1610384466811;
 Mon, 11 Jan 2021 09:01:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b12sm431296wmj.2.2021.01.11.09.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 09:01:06 -0800 (PST)
Date: Mon, 11 Jan 2021 18:01:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 07/13] drm/gm12u320: Use drm_gem_shmem_vmap_local() in
 damage handling
Message-ID: <X/yEUPX+H66Q129T@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108094340.15290-8-tzimmermann@suse.de>
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

On Fri, Jan 08, 2021 at 10:43:34AM +0100, Thomas Zimmermann wrote:
> Damage handling in gm12u320 requires a short-term mapping of the source
> BO. Use drm_gem_shmem_vmap_local().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/tiny/gm12u320.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index 33f65f4626e5..b0c6e350f2b3 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -265,11 +265,16 @@ static void gm12u320_copy_fb_to_blocks(struct gm12u320_device *gm12u320)
>  	y1 = gm12u320->fb_update.rect.y1;
>  	y2 = gm12u320->fb_update.rect.y2;
>  
> -	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
> +	ret = dma_resv_lock(fb->obj[0]->resv, NULL);
>  	if (ret) {
> -		GM12U320_ERR("failed to vmap fb: %d\n", ret);
> +		GM12U320_ERR("failed to reserve fb: %d\n", ret);
>  		goto put_fb;
>  	}
> +	ret = drm_gem_shmem_vmap_local(fb->obj[0], &map);
> +	if (ret) {
> +		GM12U320_ERR("failed to vmap fb: %d\n", ret);
> +		goto unlock_resv;
> +	}
>  	vaddr = map.vaddr; /* TODO: Use mapping abstraction properly */
>  
>  	if (fb->obj[0]->import_attach) {
> @@ -321,8 +326,11 @@ static void gm12u320_copy_fb_to_blocks(struct gm12u320_device *gm12u320)
>  		if (ret)
>  			GM12U320_ERR("dma_buf_end_cpu_access err: %d\n", ret);
>  	}
> +
> +unlock_resv:
> +	dma_resv_unlock(fb->obj[0]->resv);

Unlock before vunmap.
-Daniel

>  vunmap:
> -	drm_gem_shmem_vunmap(fb->obj[0], &map);
> +	drm_gem_shmem_vunmap_local(fb->obj[0], &map);
>  put_fb:
>  	drm_framebuffer_put(fb);
>  	gm12u320->fb_update.fb = NULL;
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
