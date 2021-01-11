Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F1C433DB
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:03:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34F022473
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 17:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34F022473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A0BC685D3D;
	Mon, 11 Jan 2021 17:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xeQHRqkSF1k1; Mon, 11 Jan 2021 17:03:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 069AD858DD;
	Mon, 11 Jan 2021 17:03:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF884C088B;
	Mon, 11 Jan 2021 17:03:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 973DCC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 652AA22621
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jlt5MpLvMAVT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:03:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by silver.osuosl.org (Postfix) with ESMTPS id F1DB2204E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 17:03:41 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id d26so465559wrb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ALtIbbdLffgue6tI4Zq52HkQm8jHa5cuL6H+tIYyZvw=;
 b=ON9Fdv13tvinQvVKGf0i/jKWuF/PWRDDEK2r2JYDitjAUwRTKDpqf4nufXzFYEAxsX
 vaN1mtOgXr0FDD2Qs9gTIFSK5vut7kwgRlCz5Vns/7LXRlrLXChAR/CToOVIGQqizCAl
 xeEu6htpOJh81BArqoLN2CQIS8Ltk6eWziloE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ALtIbbdLffgue6tI4Zq52HkQm8jHa5cuL6H+tIYyZvw=;
 b=dO9c9P5rI+zT4zh+1oSNTXPQX9d1O5DlO/CDRT+MChdSKjBVAabfzN1M1fl5PaA1pE
 JAu8nnhCdbq6G5CphBaUPjRVvEBnpXo3IPnIhCUYWm+y/SL4WJeTyfmdMdHftrmdu3uf
 MOqGZihMnkvGsmi2WMxo09HH/BVsZb4PWri8EzrV2tWIy/OWc6dZSopfiRWiX3TWgL+v
 izr7njyhG2EmXQcqRdCHFfl8w/bELGiJqIoF663piSRyLb0iFFuDLQJ7kDsHIRH2eyUF
 uJnlKciqhy1BrXu+O8IWY6n7k9kI0RRwpngRDNUaYqiDFfncxVSzv32l2mjrcKgIVDig
 O3xg==
X-Gm-Message-State: AOAM533lN07wgV24kKjuh4RBE7SUjdqHoBLXs2kJs01RINd0UUEn4btX
 NzBzSuTZkPy7Cmz5Nc2F8D7U6A==
X-Google-Smtp-Source: ABdhPJxFI7jKE0bGZWc1WaBEC3v4a5PjcJyxs5JgUHTFcbju1xWGCLxnPt0/We5va+1YMmoe1yCj3g==
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr77723wrs.155.1610384620424;
 Mon, 11 Jan 2021 09:03:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b12sm439139wmj.2.2021.01.11.09.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 09:03:39 -0800 (PST)
Date: Mon, 11 Jan 2021 18:03:37 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 06/13] drm/cirrus: Use drm_gem_shmem_vmap_local() in
 damage handling
Message-ID: <X/yE6bxLBpgXtiXy@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-7-tzimmermann@suse.de>
 <X/yEOiDNYmRo+17/@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/yEOiDNYmRo+17/@phenom.ffwll.local>
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

On Mon, Jan 11, 2021 at 06:00:42PM +0100, Daniel Vetter wrote:
> On Fri, Jan 08, 2021 at 10:43:33AM +0100, Thomas Zimmermann wrote:
> > Damage handling in cirrus requires a short-term mapping of the source
> > BO. Use drm_gem_shmem_vmap_local().
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Hm more possible errors that we don't report to userspace ... Why don't we
> vmap/vunmap these in prepare/cleanup_fb? Generally we'd want a long-term
> vmap here to make sure this all works nicely.
> 
> Since it's nothing new, on this patch:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Ok, also strike this r-b here. This is called from that atomic commit
paths, and we cannot call dma_resv_lock here. This should splat with
lockdep enabled against the dma-fence annotations I've merged, I'm kinda
surprised it doesn't?
-Daniel

> 
> > ---
> >  drivers/gpu/drm/tiny/cirrus.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> > index a043e602199e..21cd7056d45f 100644
> > --- a/drivers/gpu/drm/tiny/cirrus.c
> > +++ b/drivers/gpu/drm/tiny/cirrus.c
> > @@ -315,6 +315,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
> >  			       struct drm_rect *rect)
> >  {
> >  	struct cirrus_device *cirrus = to_cirrus(fb->dev);
> > +	struct drm_gem_object *obj = fb->obj[0];
> >  	struct dma_buf_map map;
> >  	void *vmap;
> >  	int idx, ret;
> > @@ -323,9 +324,12 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
> >  	if (!drm_dev_enter(&cirrus->dev, &idx))
> >  		goto out;
> >  
> > -	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
> > +	ret = dma_resv_lock(obj->resv, NULL);
> >  	if (ret)
> >  		goto out_dev_exit;
> > +	ret = drm_gem_shmem_vmap_local(fb->obj[0], &map);
> > +	if (ret)
> > +		goto out_dma_resv_unlock;
> >  	vmap = map.vaddr; /* TODO: Use mapping abstraction properly */
> >  
> >  	if (cirrus->cpp == fb->format->cpp[0])
> > @@ -345,9 +349,11 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
> >  	else
> >  		WARN_ON_ONCE("cpp mismatch");
> >  
> > -	drm_gem_shmem_vunmap(fb->obj[0], &map);
> >  	ret = 0;
> >  
> > +	drm_gem_shmem_vunmap_local(obj, &map);
> > +out_dma_resv_unlock:
> > +	dma_resv_unlock(obj->resv);
> >  out_dev_exit:
> >  	drm_dev_exit(idx);
> >  out:
> > -- 
> > 2.29.2
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
