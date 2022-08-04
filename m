Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8C3C25B06
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 20:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47CC4831FB;
	Thu,  4 Aug 2022 20:15:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47CC4831FB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=TCfgUXEU;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=VhXfE8Bp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f0_cdfWaR1Xm; Thu,  4 Aug 2022 20:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C7A30831AC;
	Thu,  4 Aug 2022 20:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7A30831AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A60DC0033;
	Thu,  4 Aug 2022 20:15:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38F76C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB3DB41CF4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB3DB41CF4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=TCfgUXEU; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=VhXfE8Bp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZyLXgzUyvhm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:15:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB6B641CF3
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com
 (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB6B641CF3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=XQ+kkmE4Ic07chp0AfJlC9OlFc9+61+pKDSgSKBxebA=;
 b=TCfgUXEUFJ19oq7/funrOIu+L7gd0wRcTbgHqf94s6fkDRsfnewHHvJoJhxjDiQodMJYBQdv3C3Gs
 eOAs2tRs9ZBZW8lL4wuITmNLY2/GMUe7h+njBD7+VFraadwdCqckGxWKKF8JX/j2nokaCxNTLUmgyw
 SjRJ75B2AsoPK6GmyuaZHyvQTdQyvl52QNJlWgP1RYBFT1MtjNftSXfjnWPYZCczDLbBUqSqqK5I5T
 vz9FIjJPJaFoqerWaV24w9wznrXWNpmHXudIDI057U+ZQFrn52zUgWKSgQygYt7ZlZ14n9hZnw1uIO
 DMSR9j4pcXUhJuHsrThRjLK7OpPG9Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=XQ+kkmE4Ic07chp0AfJlC9OlFc9+61+pKDSgSKBxebA=;
 b=VhXfE8BpE6rR/ibzr7tFyWrYtPx5VN1SNhRdc2dXgDRyRcO2Mjs/ydHMboQMt6ffH6Vw+fgb/XTG0
 o3QMju0Cg==
X-HalOne-Cookie: 9aca289c7c13756da8167dac35c4f69f9101c708
X-HalOne-ID: 28663d94-1432-11ed-be81-d0431ea8bb03
Received: from mailproxy4.cst.dirpod3-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 28663d94-1432-11ed-be81-d0431ea8bb03;
 Thu, 04 Aug 2022 20:15:18 +0000 (UTC)
Date: Thu, 4 Aug 2022 22:15:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 07/12] drm/format-helper: Rework RGB565-to-XRGB8888
 conversion
Message-ID: <Yuwo1J6UPEDBirQC@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-8-tzimmermann@suse.de>
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

On Wed, Jul 27, 2022 at 01:33:07PM +0200, Thomas Zimmermann wrote:
> Update RGB565-to-XRGB8888 conversion to support struct iosys_map
> and convert all users. Although these are single-plane color formats,
> the new interface supports multi-plane formats for consistency with
> drm_fb_blit().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 4edab44336d8..5ef06f696657 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -430,12 +430,24 @@ static void drm_fb_rgb565_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigne
>  	}
>  }
>  
> -static void drm_fb_rgb565_to_xrgb8888_toio(void __iomem *dst, unsigned int dst_pitch,
> -					   const void *vaddr, const struct drm_framebuffer *fb,
> -					   const struct drm_rect *clip)
> +static void drm_fb_rgb565_to_xrgb8888(struct iosys_map *dst, const unsigned int *dst_pitch,
> +				      const struct iosys_map *vmap,
> +				      const struct drm_framebuffer *fb,
> +				      const struct drm_rect *clip)
>  {
> -	drm_fb_xfrm_toio(dst, dst_pitch, 4, vaddr, fb, clip, false,
> -			 drm_fb_rgb565_to_xrgb8888_line);
> +	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> +		0, 0, 0, 0
> +	};
> +
> +	if (!dst_pitch)
> +		dst_pitch = default_dst_pitch;
> +
> +	if (dst[0].is_iomem)
> +		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, fb,
> +				 clip, false, drm_fb_rgb565_to_xrgb8888_line);
> +	else
> +		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> +			    clip, false, drm_fb_rgb565_to_xrgb8888_line);
>  }
>  
>  static void drm_fb_rgb888_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
> @@ -600,8 +612,7 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
>  						       vmap[0].vaddr, fb, clip);
>  			return 0;
>  		} else if (fb_format == DRM_FORMAT_RGB565) {
> -			drm_fb_rgb565_to_xrgb8888_toio(dst[0].vaddr_iomem, dst_pitch[0],
> -						       vmap[0].vaddr, fb, clip);
> +			drm_fb_rgb565_to_xrgb8888(dst, dst_pitch, vmap, fb, clip);
>  			return 0;
>  		}
>  	} else if (dst_format == DRM_FORMAT_XRGB2101010) {
> -- 
> 2.37.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
