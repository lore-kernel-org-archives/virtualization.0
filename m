Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7D8C433DB
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 16:58:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750972242A
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 16:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750972242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CCD422226B;
	Mon, 11 Jan 2021 16:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-ceeXq5XCXF; Mon, 11 Jan 2021 16:58:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 723B0204B3;
	Mon, 11 Jan 2021 16:58:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 537EBC088B;
	Mon, 11 Jan 2021 16:58:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EBBFC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DF9B5204DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPWHSVjpQkGu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by silver.osuosl.org (Postfix) with ESMTPS id 7A01A204B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:58:17 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id 91so483038wrj.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4FqdUl+82w6WQ3AgKtaR9Ms7/D3PccxuSOkwBbIHSfQ=;
 b=gLQy7sdd++mPhIh7HsdZgDZ44VQV66IhNyV451vLAxIg3dfS1nbu5hONh7WShiRdt6
 hxqD7CVEtKcgBfagdN7Uu6VJjJvp3A+a6+CDvRuYPIMC32E6l2xL/idb0BPgfBKcYFn2
 IJsVDrwX/LtG9DxNZcwhZnO+ZAo6lap5GsSwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4FqdUl+82w6WQ3AgKtaR9Ms7/D3PccxuSOkwBbIHSfQ=;
 b=CaCtYLA410Cm1QcH8eopa3mVC8OZD8u/Hu0kii0GW1O5l2kKkvwJv4xQzYchYVKaxe
 pxNbtCnjimqWZ02QglfKmU0pKQz3Si6JtQxiOZuag3OnVSnX+SeeIZ6iSQvzgTK+R6j1
 U79RL+bJaZTWoTfRVCYaCXJ2Os5wK2uXY10nyBcshlcY4hvn6FV/5K+se6jo6jXkeuRB
 wsoKHQBwytToBStootE4WSy7BdDzEI+zbpq6VAgiYPgd1cCMzQxaV4WstwD2F2sFmhi4
 2Mj/7wxNfIkjrCu005HLPwckCYzF8Nddd2mvk5WKj1tIn1PfGlMjq72BMsWculeFz0CT
 JqpA==
X-Gm-Message-State: AOAM533RYoYJJAUTXTIR7j02L4HSWn0QRjfvHEZE07tdRQdNIPGTHtjx
 iiQMYBsrJpWy0g89842c6jnSeg==
X-Google-Smtp-Source: ABdhPJzUUtudaQHIkwtOF8q9nDHaJ26/sAlo6U/GtHff2RUsJVajVjlbhR+QS23CmuIMHVZP8Twt1Q==
X-Received: by 2002:adf:e406:: with SMTP id g6mr44798wrm.255.1610384296005;
 Mon, 11 Jan 2021 08:58:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id p15sm296486wrt.15.2021.01.11.08.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 08:58:15 -0800 (PST)
Date: Mon, 11 Jan 2021 17:58:13 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 05/13] drm/mgag200: Use drm_gem_shmem_vmap_local() in
 damage handling
Message-ID: <X/yDpZbtRhe2YlCp@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-6-tzimmermann@suse.de>
 <X/yClQZQ0B5AMfEP@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/yClQZQ0B5AMfEP@phenom.ffwll.local>
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

On Mon, Jan 11, 2021 at 05:53:41PM +0100, Daniel Vetter wrote:
> On Fri, Jan 08, 2021 at 10:43:32AM +0100, Thomas Zimmermann wrote:
> > Damage handling in mgag200 requires a short-term mapping of the source
> > BO. Use drm_gem_shmem_vmap_local().
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

On second thought, strike that r-b, I have a confused question.
> 
> > ---
> >  drivers/gpu/drm/mgag200/mgag200_mode.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> > index 1dfc42170059..a33e28d4c5e9 100644
> > --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> > +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> > @@ -1552,22 +1552,32 @@ mgag200_handle_damage(struct mga_device *mdev, struct drm_framebuffer *fb,
> >  		      struct drm_rect *clip)
> >  {
> >  	struct drm_device *dev = &mdev->base;
> > +	struct drm_gem_object *obj = fb->obj[0];
> >  	struct dma_buf_map map;
> >  	void *vmap;
> >  	int ret;
> >  
> > -	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
> > +	ret = dma_resv_lock(obj->resv, NULL);
> >  	if (drm_WARN_ON(dev, ret))
> > -		return; /* BUG: SHMEM BO should always be vmapped */
> > +		return;
> > +	ret = drm_gem_shmem_vmap_local(obj, &map);
> > +	if (drm_WARN_ON(dev, ret))
> > +		goto err_dma_resv_unlock; /* BUG: SHMEM BO should always be vmapped */

Why is this guaranteed? I tried to hunt for a vmap in mga200g code, and
dind't find any. I'd ahve expected something in prepare/finish_fb.

Also since this is not a vram-helper using driver, why convert it over to
vmap_local? I guess that should also be explained in the commit message a
bit better.
-Daniel

> >  	vmap = map.vaddr; /* TODO: Use mapping abstraction properly */
> >  
> >  	drm_fb_memcpy_dstclip(mdev->vram, vmap, fb, clip);
> >  
> > -	drm_gem_shmem_vunmap(fb->obj[0], &map);
> > +	drm_gem_shmem_vunmap_local(obj, &map);
> > +	dma_resv_unlock(obj->resv);
> >  
> >  	/* Always scanout image at VRAM offset 0 */
> >  	mgag200_set_startadd(mdev, (u32)0);
> >  	mgag200_set_offset(mdev, fb);
> > +
> > +	return;
> > +
> > +err_dma_resv_unlock:
> > +	dma_resv_unlock(obj->resv);
> >  }
> >  
> >  static void
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
