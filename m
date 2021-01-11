Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7136AC433E6
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:00:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFEF2250F
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFEF2250F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6F3D9204B3;
	Mon, 11 Jan 2021 17:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EdRifkaGzLSj; Mon, 11 Jan 2021 17:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E73B20018;
	Mon, 11 Jan 2021 17:00:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D951C088B;
	Mon, 11 Jan 2021 17:00:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58E62C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4040B858BF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXqgYSdt8Ygt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:00:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DAE85858B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:00:46 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 3so539659wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 09:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2g3cL0wvqzFtjOXKvL27N3/6q4I3I6VjBCf04+f3nDE=;
 b=YSeFsVkQUGuMr6ClwjwgyiCvAMpCC8zdnAEfvKUnXOz1m8X1YoR8E6Ep7qChYjNulz
 wDn2DK37HTP8OCjHIFqqy7aqBu4NZnEbFccLp70XXGNqgl4xfWvDq8Tgdu68wSZ6bf6B
 1YvgKovLReX1CPlXQkswsENSMsfBD/xsMmOEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2g3cL0wvqzFtjOXKvL27N3/6q4I3I6VjBCf04+f3nDE=;
 b=ImIgOj7nK4eGdhKKjPv5V8UR4Wd6wHACpRLXo4OfDh5n73k5E52nvoycBYSTJ8wzRq
 M6IdIlNS+ooYZpPaoTUQtOz25PXZvStGocGRAktrSIRNi2rwFZReeG53BKWMXHmfZ8XQ
 VkbF6XtvI6nah0Iv/4ptpBPGUuxhGzoqugiHk2++dM9Jz8g7sKitfvqfTziGpIK135bZ
 gVkAsrgnIEzZLtbhZM+kaJmQw06ofTDqPmgsIRlI4razByYdoRSzuWXF99xjochgG81y
 JtsCqKyF2anbRM/jyFseUJCSwxoio8RPCkUg+8om/DcAvZXIktFp26dZPegDExdljFwK
 tY+w==
X-Gm-Message-State: AOAM5301dHuIIGyNFfNnKG1FEafXnQA/r2RJPTTRQv+rxMoNTSYMpB3c
 DuhjfR7CHenl70mKXzJgU1zwqw==
X-Google-Smtp-Source: ABdhPJyG0LrXbaUIyyZRlVK36Q2xpcxqNl5BuI6ZeTG2aGDwDFmf1Yi6zoWIMIlGAfmk+GjScniy3Q==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr590675wma.22.1610384445461;
 Mon, 11 Jan 2021 09:00:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id z13sm432713wmz.3.2021.01.11.09.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 09:00:44 -0800 (PST)
Date: Mon, 11 Jan 2021 18:00:42 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 06/13] drm/cirrus: Use drm_gem_shmem_vmap_local() in
 damage handling
Message-ID: <X/yEOiDNYmRo+17/@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-7-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108094340.15290-7-tzimmermann@suse.de>
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

On Fri, Jan 08, 2021 at 10:43:33AM +0100, Thomas Zimmermann wrote:
> Damage handling in cirrus requires a short-term mapping of the source
> BO. Use drm_gem_shmem_vmap_local().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Hm more possible errors that we don't report to userspace ... Why don't we
vmap/vunmap these in prepare/cleanup_fb? Generally we'd want a long-term
vmap here to make sure this all works nicely.

Since it's nothing new, on this patch:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/tiny/cirrus.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index a043e602199e..21cd7056d45f 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -315,6 +315,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
>  			       struct drm_rect *rect)
>  {
>  	struct cirrus_device *cirrus = to_cirrus(fb->dev);
> +	struct drm_gem_object *obj = fb->obj[0];
>  	struct dma_buf_map map;
>  	void *vmap;
>  	int idx, ret;
> @@ -323,9 +324,12 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
>  	if (!drm_dev_enter(&cirrus->dev, &idx))
>  		goto out;
>  
> -	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
> +	ret = dma_resv_lock(obj->resv, NULL);
>  	if (ret)
>  		goto out_dev_exit;
> +	ret = drm_gem_shmem_vmap_local(fb->obj[0], &map);
> +	if (ret)
> +		goto out_dma_resv_unlock;
>  	vmap = map.vaddr; /* TODO: Use mapping abstraction properly */
>  
>  	if (cirrus->cpp == fb->format->cpp[0])
> @@ -345,9 +349,11 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
>  	else
>  		WARN_ON_ONCE("cpp mismatch");
>  
> -	drm_gem_shmem_vunmap(fb->obj[0], &map);
>  	ret = 0;
>  
> +	drm_gem_shmem_vunmap_local(obj, &map);
> +out_dma_resv_unlock:
> +	dma_resv_unlock(obj->resv);
>  out_dev_exit:
>  	drm_dev_exit(idx);
>  out:
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
