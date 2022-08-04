Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9602FC19F2A
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 20:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24C9860BA8;
	Thu,  4 Aug 2022 20:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24C9860BA8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=CqVKUxcF;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=PDZyiGPn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7FwiLLuxtSk; Thu,  4 Aug 2022 20:08:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B87961191;
	Thu,  4 Aug 2022 20:08:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B87961191
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30B50C0032;
	Thu,  4 Aug 2022 20:08:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13019C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF6D84030D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:08:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF6D84030D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=CqVKUxcF; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=PDZyiGPn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9v-1uvbCTkW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:08:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06569402C4
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com
 (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06569402C4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=Fjk2df4EwkGZG0yEovVPsN6OukyS/nnOR2oioz+wFPc=;
 b=CqVKUxcFGOkLW7efEbCUEKlfkmR0gzbVk55mE/+jHBXl/VHNI8yAO8qPQ9IfL+zHbQ2uWssLAu7pz
 ZM2t7Y+sc91YZQlqlRTWz5ci7RHoP79/W8MoUElRbZ58/T7aH9CbGwCXHxYCLf5MdVEUfPktoU+zug
 /OexApmx0orATcf94q5vAyHlr/IhiIn8J5/LiaOAd8ecKkKfMMbl8CJgkTnpEo7aeVW2gS4/4OaR4D
 bN+y3PZrA/A8YV3SGQP7tFB3sXfuixaO8zqcAwA738Q7cQnu/Ow4WwT4MvAFGcMN2RxhMFgfCFxibn
 7MmBrqeviYxiqMJHVoScIrPACBFXeEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=Fjk2df4EwkGZG0yEovVPsN6OukyS/nnOR2oioz+wFPc=;
 b=PDZyiGPneBY72u+fdbekIBvSgzDqEsTXCDgi/EJuAgSUVfLbdvoHH/50nRb0RlOp05Q6MVcqY+nRX
 PK0dciWBQ==
X-HalOne-Cookie: be7b70d1db1aa684346e3c8ebb12fbb4eb9f3817
X-HalOne-ID: 2bf79417-1431-11ed-8244-d0431ea8bb10
Received: from mailproxy1.cst.dirpod3-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 2bf79417-1431-11ed-8244-d0431ea8bb10;
 Thu, 04 Aug 2022 20:08:14 +0000 (UTC)
Date: Thu, 4 Aug 2022 22:08:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 03/12] drm/format-helper: Convert drm_fb_swab() to struct
 iosys_map
Message-ID: <YuwnLBICShrjMg2Y@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-4-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, david@lechnology.com, airlied@linux.ie,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 javierm@redhat.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, drawat.floss@gmail.com,
 noralf@tronnes.org, daniel@ffwll.ch, jose.exposito89@gmail.com,
 airlied@redhat.com
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

Hi Thomas,

On Wed, Jul 27, 2022 at 01:33:03PM +0200, Thomas Zimmermann wrote:
> Convert drm_fb_swab() to use struct iosys_map() and convert users. The
> new interface supports multi-plane color formats.
It swabs only plane[0], sbut this is maybe enough to say so.

A few comments in the following.

	Sam

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 38 +++++++++++++++++++++--------
>  drivers/gpu/drm/drm_mipi_dbi.c      |  2 +-
>  drivers/gpu/drm/gud/gud_pipe.c      |  2 +-
>  include/drm/drm_format_helper.h     |  6 ++---
>  4 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 49589b442f18..fa22d3cb11e8 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -196,9 +196,9 @@ static void drm_fb_swab32_line(void *dbuf, const void *sbuf, unsigned int pixels
>  
>  /**
>   * drm_fb_swab - Swap bytes into clip buffer
> - * @dst: Destination buffer
> - * @dst_pitch: Number of bytes between two consecutive scanlines within dst
> - * @src: Source buffer
> + * @dst: Array of destination buffers
> + * @dst_pitch: Array of numbers of bytes between two consecutive scanlines within dst
Document that it may be NULL?

> + * @vmap: Array of source buffers
Prefer that the source is named src, and vmap smells like system
(virtual) memory to me.
Also vmap must be system memory - but this is maybe fixed later.


>   * @fb: DRM framebuffer
>   * @clip: Clip rectangle area to copy
>   * @cached: Source buffer is mapped cached (eg. not write-combined)
> @@ -209,24 +209,42 @@ static void drm_fb_swab32_line(void *dbuf, const void *sbuf, unsigned int pixels
>   * This function does not apply clipping on dst, i.e. the destination
>   * is at the top-left corner.
>   */
> -void drm_fb_swab(void *dst, unsigned int dst_pitch, const void *src,
> -		 const struct drm_framebuffer *fb, const struct drm_rect *clip,
> -		 bool cached)
> +void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
> +		 const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +		 const struct drm_rect *clip, bool cached)
>  {
> -	u8 cpp = fb->format->cpp[0];
> +	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> +		0, 0, 0, 0
> +	};
> +	const struct drm_format_info *format = fb->format;
> +	u8 cpp = format->cpp[0];
	u8 cpp = drm_format_info_bpp(format, 0) / 8;

> +	void (*swab_line)(void *dbuf, const void *sbuf, unsigned int npixels);
>  
>  	switch (cpp) {
>  	case 4:
> -		drm_fb_xfrm(dst, dst_pitch, cpp, src, fb, clip, cached, drm_fb_swab32_line);
> +		swab_line = drm_fb_swab32_line;
>  		break;
>  	case 2:
> -		drm_fb_xfrm(dst, dst_pitch, cpp, src, fb, clip, cached, drm_fb_swab16_line);
> +		swab_line = drm_fb_swab16_line;
>  		break;
>  	default:
>  		drm_warn_once(fb->dev, "Format %p4cc has unsupported pixel size.\n",
> -			      &fb->format->format);
> +			      &format->format);
> +		swab_line = NULL;
>  		break;
>  	}
> +	if (!swab_line)
> +		return;
> +
> +	if (!dst_pitch)
> +		dst_pitch = default_dst_pitch;
> +
> +	if (dst->is_iomem)
> +		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], cpp,
> +				 vmap[0].vaddr, fb, clip, cached, swab_line);
> +	else
> +		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], cpp, vmap[0].vaddr, fb,
> +			    clip, cached, swab_line);
Here vmap is assumes system memory, not IO. I assume this is fixed
later.

>  }
>  EXPORT_SYMBOL(drm_fb_swab);
>  
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
> index 22451806fb5c..973a75585cad 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -221,7 +221,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  	switch (fb->format->format) {
>  	case DRM_FORMAT_RGB565:
>  		if (swap)
> -			drm_fb_swab(dst, 0, src, fb, clip, !gem->import_attach);
> +			drm_fb_swab(&dst_map, NULL, data, fb, clip, !gem->import_attach);
>  		else
>  			drm_fb_memcpy(&dst_map, NULL, data, fb, clip);
>  		break;
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 449c95a4aee0..a15cda9ba058 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -205,7 +205,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
>  			len = gud_xrgb8888_to_color(buf, format, vaddr, fb, rect);
>  		}
>  	} else if (gud_is_big_endian() && format->cpp[0] > 1) {
> -		drm_fb_swab(buf, 0, vaddr, fb, rect, !import_attach);
> +		drm_fb_swab(&dst, NULL, map_data, fb, rect, !import_attach);
>  	} else if (compression && !import_attach && pitch == fb->pitches[0]) {
>  		/* can compress directly from the framebuffer */
>  		buf = vaddr + rect->y1 * pitch;
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index 8af6a2717bc9..60944feaa936 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -17,9 +17,9 @@ unsigned int drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info
>  void drm_fb_memcpy(struct iosys_map *dst, const unsigned int *dst_pitch,
>  		   const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  		   const struct drm_rect *clip);
> -void drm_fb_swab(void *dst, unsigned int dst_pitch, const void *src,
> -		 const struct drm_framebuffer *fb, const struct drm_rect *clip,
> -		 bool cached);
> +void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
> +		 const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +		 const struct drm_rect *clip, bool cached);
>  void drm_fb_xrgb8888_to_rgb332(void *dst, unsigned int dst_pitch, const void *vaddr,
>  			       const struct drm_framebuffer *fb, const struct drm_rect *clip);
>  void drm_fb_xrgb8888_to_rgb565(void *dst, unsigned int dst_pitch, const void *vaddr,
> -- 
> 2.37.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
