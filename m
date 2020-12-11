Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5164C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 10:14:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFD323C18
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 10:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFD323C18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B64B8726D;
	Fri, 11 Dec 2020 10:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nfPnRskk4nb6; Fri, 11 Dec 2020 10:14:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EEAEB87224;
	Fri, 11 Dec 2020 10:14:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC2D9C0FA7;
	Fri, 11 Dec 2020 10:14:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E35FEC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C4BE086856
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vshynw9podjh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:14:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AAC7E86F80
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 10:14:48 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id y23so8050933wmi.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tFibnX3/+2uQLJigmsH9b8s5hxcI5Nnzsyfczlow2uY=;
 b=dGhq32YMkTjWI/ie2Hq+RdFI2qUl+7/r+2hNI1hmc7rqmjb1bUxt3I38/+V1gaz4Bi
 tpO9bNBaMSzFzrAzfieUISFFy1nzZP5xUTiHgEVpnG8Edk2NmeOVM06D8pAO9yjnKpZu
 f+AcH6sPBkStWxgnvgOfJo3dI+Mu2HsWk3EYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tFibnX3/+2uQLJigmsH9b8s5hxcI5Nnzsyfczlow2uY=;
 b=OQp9kH/XtphSYRDVBS+88NEHHe6kKd+dTcDNJ3YgGrJgJ79Jo9dRLDfVLblNYd93Lp
 F+MEGfnVRi+ReHQ7WdseM2lpZupRzhioT2e2AVkhIdUEctJEGXDT4osFJ9zzmSW4T1l3
 4WcLOaHTXF/2F3ws2rqPzq6Nvv8BBXPOlLK9bT27kqZURDeCmpe9K+Np2FBlwH79T1wk
 poiSNcMUimWrpOfkDrs6DCmpfaCLf3PEjO5JvJFoBuVYTRCkhtLjyKtIci2phBHILh9I
 LAKfJEcHFiKZCERtco1q1ltpVK3B4qQyYejlcr97KvGE+4l5JwtGrxs9Jrj+JwtoWJyv
 AKAw==
X-Gm-Message-State: AOAM533eKKlInMG2LenUsgDeXtTaWLf9Nyx9byLfVvS/4vLhX0rr2ACz
 SNxWZAKBTGATtZsIc/NuhPofdA==
X-Google-Smtp-Source: ABdhPJyVgqHgjlCiunOK9t3N8S0FIge5kEeCAE3w010OLYNrBIfSd131FdYBTILVWy8GablsJBC0KA==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr12989334wmk.14.1607681687220; 
 Fri, 11 Dec 2020 02:14:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y2sm13440927wma.6.2020.12.11.02.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 02:14:46 -0800 (PST)
Date: Fri, 11 Dec 2020 11:14:44 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 1/8] drm/ast: Don't pin cursor source BO explicitly
 during update
Message-ID: <20201211101444.GP401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209142527.26415-2-tzimmermann@suse.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Dec 09, 2020 at 03:25:20PM +0100, Thomas Zimmermann wrote:
> Vmapping the cursor source BO contains an implicit pin operation,
> so there's no need to do this manually.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/ast/ast_cursor.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
> index 742d43a7edf4..68bf3d33f1ed 100644
> --- a/drivers/gpu/drm/ast/ast_cursor.c
> +++ b/drivers/gpu/drm/ast/ast_cursor.c
> @@ -180,12 +180,9 @@ int ast_cursor_blit(struct ast_private *ast, struct drm_framebuffer *fb)
>  
>  	gbo = drm_gem_vram_of_gem(fb->obj[0]);
>  
> -	ret = drm_gem_vram_pin(gbo, 0);
> -	if (ret)
> -		return ret;
>  	ret = drm_gem_vram_vmap(gbo, &map);
>  	if (ret)
> -		goto err_drm_gem_vram_unpin;
> +		return ret;
>  	src = map.vaddr; /* TODO: Use mapping abstraction properly */
>  
>  	dst = ast->cursor.map[ast->cursor.next_index].vaddr_iomem;
> @@ -194,13 +191,8 @@ int ast_cursor_blit(struct ast_private *ast, struct drm_framebuffer *fb)
>  	update_cursor_image(dst, src, fb->width, fb->height);
>  
>  	drm_gem_vram_vunmap(gbo, &map);
> -	drm_gem_vram_unpin(gbo);
>  
>  	return 0;
> -
> -err_drm_gem_vram_unpin:
> -	drm_gem_vram_unpin(gbo);
> -	return ret;
>  }
>  
>  static void ast_cursor_set_base(struct ast_private *ast, u64 address)
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
