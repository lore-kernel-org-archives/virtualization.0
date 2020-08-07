Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D51C433E0
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 13:35:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36AE20866
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 13:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L751dIlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36AE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A16B887C5;
	Fri,  7 Aug 2020 13:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCrAHVumHZLe; Fri,  7 Aug 2020 13:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BFAC2887AF;
	Fri,  7 Aug 2020 13:35:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8A61C0051;
	Fri,  7 Aug 2020 13:35:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 839A4C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5D42988A19
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HKThtXXjO3dq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:35:22 +0000 (UTC)
X-Greylist: delayed 00:17:41 by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0224588A00
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:35:21 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id i6so1282982edy.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Aug 2020 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=h/9NLZ4ReA+HnaQVY6McKcG5jzY2nrGCSkB9IBxfWTk=;
 b=L751dIlgU27AYm2WGwfGweb8D0uvZR0rzfBZfvm5T1K7Tx2mDct5RcUgWLMjcXRCNG
 tDPSWr01eY0/HIpmUGdOygtzTm7gakHH5C0DHtsZIbDfxSofwaIJbihrxTV6xGEwXvy1
 my1Ws0TjqSRnIzGH1L7Ua8XDjiA07YBpegYHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=h/9NLZ4ReA+HnaQVY6McKcG5jzY2nrGCSkB9IBxfWTk=;
 b=oro+OxtYBbdrabhpNjfjxERSd162uzRRTMGe21yUY+ZXRy5ZqMB0MYHZqP9Jm5jeIV
 XhjOEjs4niHVMiyBSX9VMUawBQPjcSa3ye3tevUOkjTd2lDtCeLzcCD56gJoUNYlIQqh
 YWmhXeMugH5oQM6KiBst3Lc00bzKngQEd2qze7GQNcRl5ci+R/ceQ7vrwpw7dMLVJ2zP
 uibyTEHV6I0ShZdY3yEj5sf7mNiaNNtJABWhc3oZ54+IbfM6qVgqqaVxO/ZFMXpbGl02
 m9sr1ymOY9ErwR/i9fI3KW5XXYgCFW60KjUqoSOvrmk8sjOBjxrqBxMdLzMPyYtCaS7N
 JSzw==
X-Gm-Message-State: AOAM530L9sUI9J+ENHeSObWtXLs4hR0BSYus8+eqox+s37puZaMdR60V
 OcS4g9kj9gGKBbhlUH685/vfZm3HK30=
X-Google-Smtp-Source: ABdhPJzRC3u1EBaYAkd2FdtfLOXeNU8Du4KwE6MIjBntk/q16CUg6W1Gjnc0iKsJubIdyof6+6wssA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr12124520wrs.297.1596805799195; 
 Fri, 07 Aug 2020 06:09:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id d7sm10840945wra.29.2020.08.07.06.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 06:09:58 -0700 (PDT)
Date: Fri, 7 Aug 2020 15:09:56 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: fix unblank
Message-ID: <20200807130956.GE2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel@lists.freedesktop.org, 1882851@bugs.launchpad.net,
 David Airlie <airlied@linux.ie>, Chia-I Wu <olvaffe@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20200807105429.24208-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807105429.24208-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Fri, Aug 07, 2020 at 12:54:29PM +0200, Gerd Hoffmann wrote:
> When going through a disable/enable cycle without changing the
> framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
> skip set_scanout if framebuffer didn't change") causes the screen stay
> blank.  Add a bool to force an update to fix that.
> 
> Cc: 1882851@bugs.launchpad.net
> Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
>  drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
>  drivers/gpu/drm/virtio/virtgpu_plane.c   | 4 +++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9ff9f4ac0522..7b0c319f23c9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -138,6 +138,7 @@ struct virtio_gpu_output {
>  	int cur_x;
>  	int cur_y;
>  	bool enabled;
> +	bool need_update;
>  };
>  #define drm_crtc_to_virtio_gpu_output(x) \
>  	container_of(x, struct virtio_gpu_output, crtc)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index cc7fd957a307..378be5956b30 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -100,6 +100,7 @@ static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
>  	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
>  
>  	output->enabled = true;
> +	output->need_update = true;
>  }
>  
>  static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 52d24179bcec..5948031a9ce8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -163,7 +163,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  	    plane->state->src_w != old_state->src_w ||
>  	    plane->state->src_h != old_state->src_h ||
>  	    plane->state->src_x != old_state->src_x ||
> -	    plane->state->src_y != old_state->src_y) {
> +	    plane->state->src_y != old_state->src_y ||
> +	    output->need_update) {

Uh instead of hand-rolling what's essentially a drm_crtc_needs_modeset
check, why not use that one? atomic helpers try to keep the usual suspects
for state transitions already handy, to avoid every driver rolling their
own. Or do I miss something here?
-Daniel


>  		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
>  			  bo->hw_res_handle,
>  			  plane->state->crtc_w, plane->state->crtc_h,
> @@ -178,6 +179,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  					   plane->state->src_h >> 16,
>  					   plane->state->src_x >> 16,
>  					   plane->state->src_y >> 16);
> +		output->need_update = false;
>  	}
>  
>  	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
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
