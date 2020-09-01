Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343DBC433E2
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 10:20:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0355206FA
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 10:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XFND8mCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0355206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 803AA86BF2;
	Tue,  1 Sep 2020 10:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dSxRtmQILdf2; Tue,  1 Sep 2020 10:20:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A22586BAC;
	Tue,  1 Sep 2020 10:20:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE1EC088B;
	Tue,  1 Sep 2020 10:20:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBC59C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 10:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BAB1185EA5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 10:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zBa1mT_FGSxk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 10:20:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 926A285E25
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 10:20:11 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id u18so589864wmc.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Sep 2020 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=3GIpy2hsxgFsBlpT+dsHbTbTluNWsmd1rZYjI09Uxc8=;
 b=XFND8mCwVNeeDtS+fg/HptRv9VEH756A1a+vj+5/P2wZZxyQEM2/bjCp/FcbmjsIPk
 r64cPgQLvDI8oXcy561SiPfA8aV7kY+UBcCu0AQ8GiBSuWvXWuc3bEsCZpZl1y0NbLne
 1C+QAYiqTPu98hOOlMgeWNFespOaXxl3tzfzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=3GIpy2hsxgFsBlpT+dsHbTbTluNWsmd1rZYjI09Uxc8=;
 b=Vofk5gKFuSjl21+za8i5PZl5dsAIBk24QwhWNBQa8gKUCz+Of0xkrPeVKWhjSCv+Wg
 lklEpmbI77Hx+Nf0C1BBL/AQ4eQgf5nHuw5tKQlykt07AQ33sm5jXN1QN428LO6+XOyH
 GBbq0EeFsKfs5k0E+P2Gqz1PbjanEDFZGhaltBIlv8y2b+MNZ0yJzNPj2yvE4RY94rZX
 5yNZRcxW3Fzo8Ye8L+UVO130md3kxuPfK9CPJPTGPY5NV7/+v3GGYRiS1syJr/daBqzK
 NPSP5DoOI/6eAPl3dX0F6GOUqBiHrYBmx3mpk+h7lgIXjTfDin/kvTi+pcQ7/bDc4Hqb
 YDFw==
X-Gm-Message-State: AOAM531cq/4JYlb/f9LLnQK0FvAx9ApbqkJhS1R4dfjLUYpUJRFvXj78
 sXHcgoKePlTnteuWXiL+/Fu+Rw==
X-Google-Smtp-Source: ABdhPJy0gJSV+RL3QsNU+fR8THpAo9rjW3MvBEvOVXFmBzuJReNfV54lLhSlHCW2A7mUll0ZBu5M0g==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr1096430wmc.22.1598955609706;
 Tue, 01 Sep 2020 03:20:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id m3sm800807wmb.26.2020.09.01.03.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:20:08 -0700 (PDT)
Date: Tue, 1 Sep 2020 12:20:06 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/2] drm/virtio: fix unblank
Message-ID: <20200901102006.GZ2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel@lists.freedesktop.org, 1882851@bugs.launchpad.net,
 David Airlie <airlied@linux.ie>, Chia-I Wu <olvaffe@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20200818072511.6745-1-kraxel@redhat.com>
 <20200818072511.6745-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818072511.6745-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
 1882851@bugs.launchpad.net
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

On Tue, Aug 18, 2020 at 09:25:10AM +0200, Gerd Hoffmann wrote:
> When going through a disable/enable cycle without changing the
> framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
> skip set_scanout if framebuffer didn't change") causes the screen stay
> blank.  Add a bool to force an update to fix that.
> 
> v2: use drm_atomic_crtc_needs_modeset() (Daniel).
> 
> Cc: 1882851@bugs.launchpad.net
> Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  1 +
>  drivers/gpu/drm/virtio/virtgpu_display.c | 11 +++++++++++
>  drivers/gpu/drm/virtio/virtgpu_plane.c   |  4 +++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9ff9f4ac0522..4ab1b0ba2925 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -138,6 +138,7 @@ struct virtio_gpu_output {
>  	int cur_x;
>  	int cur_y;
>  	bool enabled;
> +	bool needs_modeset;

Maybe for a follow-up in -next: The clean atomic way of doing this is to
put this into a virtio_crtc_state, compute it in atomic_check, and then
fish it out (through old_state->state lookup, somewhat contrived I know)
in the commit side. Putting random atomic commit state tracking stuff into
non-state structures without appropriate amounts of locks is kinda iffy
and means more work for reviewers pondering whether it all works
correctly.

Cheers, Daniel


>  };
>  #define drm_crtc_to_virtio_gpu_output(x) \
>  	container_of(x, struct virtio_gpu_output, crtc)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 2c2742b8d657..6c26b41f4e0d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -123,6 +123,17 @@ static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
>  static void virtio_gpu_crtc_atomic_flush(struct drm_crtc *crtc,
>  					 struct drm_crtc_state *old_state)
>  {
> +	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
> +
> +	/*
> +	 * virtio-gpu can't do modeset and plane update operations
> +	 * independant from each other.  So the actual modeset happens
> +	 * in the plane update callback, and here we just check
> +	 * whenever we must force the modeset.
> +	 */
> +	if (drm_atomic_crtc_needs_modeset(crtc->state)) {
> +		output->needs_modeset = true;
> +	}
>  }
>  
>  static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 52d24179bcec..65757409d9ed 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -163,7 +163,9 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  	    plane->state->src_w != old_state->src_w ||
>  	    plane->state->src_h != old_state->src_h ||
>  	    plane->state->src_x != old_state->src_x ||
> -	    plane->state->src_y != old_state->src_y) {
> +	    plane->state->src_y != old_state->src_y ||
> +	    output->needs_modeset) {
> +		output->needs_modeset = false;
>  		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
>  			  bo->hw_res_handle,
>  			  plane->state->crtc_w, plane->state->crtc_h,
> -- 
> 2.18.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
