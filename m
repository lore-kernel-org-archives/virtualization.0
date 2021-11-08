Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41BAC433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 20:55:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBA8619E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 20:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EBA8619E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 576DF80E4F;
	Mon,  8 Nov 2021 20:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNIOyMSN3Ljg; Mon,  8 Nov 2021 20:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3DBF80E04;
	Mon,  8 Nov 2021 20:55:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC751C0019;
	Mon,  8 Nov 2021 20:55:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB9EAC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D94A4402BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oM5aKr2YulvV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:55:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7A6D402AD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y8rIO5kDLiYYNdoUIRDD+j4k4YWMUxX5tNev7MxjleU=; b=M2m9a6idT9lFytz/OtUyN7hIR9
 eDR9I31bIP0xo3DWKBKsnb6ruY7QFjLF4GTmbtDY5NXOESXAFkzM6bNKrYHZ4TVeQUAGFHP2C5kTW
 MJopUwxQ9Nc7tkahv3gmBjPdPTPoVZbUuP87fIHX8kemrSCA7KlYSYHabsRFmzzm7YQ/0fILVEvRF
 kUroV1JSeK+G0uOrlTGgSU3ixcRi2k85mzIFQhqZufr+PLw46x3WYNZOJRKRrZ7B1E7Tjuk5AC5pD
 Ub733xEn5/juaebnLnS5DSzdRKQFhgi6NgeZRCWMCHgjz2z4F5X+004ATYySpFOrKczmu16cox9yN
 kBmkJeRg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:54997
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mkBgF-0000Kl-B8; Mon, 08 Nov 2021 21:55:51 +0100
Subject: Re: [PATCH v2 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-8-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <974e10bb-ae58-d1c1-a89e-881b39da4930@tronnes.org>
Date: Mon, 8 Nov 2021 21:55:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101141532.26655-8-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
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



Den 01.11.2021 15.15, skrev Thomas Zimmermann:
> Enable the FB_DAMAGE_CLIPS property to reduce display-update
> overhead. Also fixes a warning in the kernel log.
> 
>   simple-framebuffer simple-framebuffer.0: [drm] drm_plane_enable_fb_damage_clips() not called
> 
> Fix the computation of the blit rectangle. This wasn't an issue so
> far, as simpledrm always blitted the full framebuffer. The code now
> supports damage clipping and virtual screen sizes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/tiny/simpledrm.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> index 571f716ff427..e872121e9fb0 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -642,7 +642,7 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
>  	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
>  	struct drm_device *dev = &sdev->dev;
>  	void __iomem *dst = sdev->screen_base;
> -	struct drm_rect clip;
> +	struct drm_rect src_clip, dst_clip;
>  	int idx;
>  
>  	if (!fb)
> @@ -651,10 +651,14 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
>  	if (!drm_dev_enter(dev, &idx))
>  		return;
>  
> -	drm_rect_init(&clip, 0, 0, fb->width, fb->height);
> +	drm_rect_fp_to_int(&src_clip, &plane_state->src);
>  
> -	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &clip);
> -	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &clip);
> +	dst_clip = plane_state->dst;

I assume that src_clip and dst_clip are of the same size, since scaling
is not supported. What prevents dst_clip from being bigger than the
buffer that's being blitted into? Where is that bounds checking done?

Noralf.

> +	if (!drm_rect_intersect(&dst_clip, &src_clip))
> +		return;
> +
> +	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip);
> +	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &src_clip);
>  
>  	drm_dev_exit(idx);
>  }
> @@ -686,20 +690,28 @@ simpledrm_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
>  	struct drm_framebuffer *fb = plane_state->fb;
>  	struct drm_device *dev = &sdev->dev;
>  	void __iomem *dst = sdev->screen_base;
> -	struct drm_rect clip;
> +	struct drm_rect damage_clip, src_clip, dst_clip;
>  	int idx;
>  
>  	if (!fb)
>  		return;
>  
> -	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &clip))
> +	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage_clip))
> +		return;
> +
> +	drm_rect_fp_to_int(&src_clip, &plane_state->src);
> +	if (!drm_rect_intersect(&src_clip, &damage_clip))
> +		return;
> +
> +	dst_clip = plane_state->dst;
> +	if (!drm_rect_intersect(&dst_clip, &src_clip))
>  		return;
>  
>  	if (!drm_dev_enter(dev, &idx))
>  		return;
>  
> -	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &clip);
> -	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &clip);
> +	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip);
> +	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &src_clip);
>  
>  	drm_dev_exit(idx);
>  }
> @@ -794,6 +806,8 @@ static int simpledrm_device_init_modeset(struct simpledrm_device *sdev)
>  	if (ret)
>  		return ret;
>  
> +	drm_plane_enable_fb_damage_clips(&pipe->plane);
> +
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
