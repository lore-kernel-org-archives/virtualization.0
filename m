Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EF3C00140
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 17:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB24C408B7;
	Fri,  5 Aug 2022 17:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB24C408B7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=Gamf2hz8;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=r8sdVmnR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hMngpXJhoIu; Fri,  5 Aug 2022 17:52:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C97740298;
	Fri,  5 Aug 2022 17:52:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C97740298
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA2F1C0033;
	Fri,  5 Aug 2022 17:52:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA547C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DACBC83E60
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:52:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DACBC83E60
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=Gamf2hz8; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=r8sdVmnR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7QQczchbkwYp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:52:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A96D383E5F
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com
 (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A96D383E5F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
 message-id:subject:cc:to:from:date:from;
 bh=ftAwZ++mdcxKPdKhik4xoJUk/80Q6jo7HipKzZB6FB0=;
 b=Gamf2hz84h58aV31UYLbq+O2B+/GC6tTyh2TM4K1iyetiV1UgMU7865DuYqMoQS8aBEG+Hdum156e
 Ve82kNqHCduL6fruZn4QObYhOkmzbo5/ROqLiCGEhcY/3Jfs0IQ3Fo9MLsrFn8ysvtB5Ncpk33t+Yh
 0BWYh9Dj0uZtnjopZZW5fIc1e4X33zcJ0bDcASrZIgPvqPNrI+VhCxJ3lFujuKr4Lwb4NxAC2nKyl7
 k1oBiBXdWhfW+1vLapTL82WjB/QPzHgCc2xVRVi77fgniykZepkz9Wv1h8XzCkHtvD7Iol55npO/at
 1bcUPUwWE7EUBKbBBnx/yqz4dFKLqHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
 message-id:subject:cc:to:from:date:from;
 bh=ftAwZ++mdcxKPdKhik4xoJUk/80Q6jo7HipKzZB6FB0=;
 b=r8sdVmnR4v+eQnbgwaseVF2x0Df0+mlxjrrEasP4UTypQLLDhRqTBqv5JOC1mcmKjJFJi4iijbqxv
 aNyewfQBw==
X-HalOne-Cookie: 263fd95a98dc585b1a1e06b295ca0b988c269500
X-HalOne-ID: 6bb1c18c-14e7-11ed-be82-d0431ea8bb03
Received: from mailproxy2.cst.dirpod4-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 6bb1c18c-14e7-11ed-be82-d0431ea8bb03;
 Fri, 05 Aug 2022 17:52:49 +0000 (UTC)
Date: Fri, 5 Aug 2022 19:52:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 12/12] drm/format-helper: Move destination-buffer
 handling into internal helper
Message-ID: <Yu1Y8JZCd+wuV2R1@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-13-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-13-tzimmermann@suse.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Thomas,

On Wed, Jul 27, 2022 at 01:33:12PM +0200, Thomas Zimmermann wrote:
> The format-convertion helpers handle several cases for different
> values of destination buffer and pitch. Move that code into the
> internal helper drm_fb_xfrm() and avoid quite a bit of duplucation.

This is very nice patch that should come before all the conversion
patches - but then you have had to come up with another name.
So I think this is fine.

A few comments below, mostly in the same area as the comments from Jos=E9.

	Sam

> =

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 169 +++++++++++-----------------
>  1 file changed, 64 insertions(+), 105 deletions(-)
> =

> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_fo=
rmat_helper.c
> index d296d181659d..35aebdb90165 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -41,11 +41,11 @@ unsigned int drm_fb_clip_offset(unsigned int pitch, c=
onst struct drm_format_info
>  }
>  EXPORT_SYMBOL(drm_fb_clip_offset);
>  =

> -/* TODO: Make this functon work with multi-plane formats. */
> -static int drm_fb_xfrm(void *dst, unsigned long dst_pitch, unsigned long=
 dst_pixsize,
> -		       const void *vaddr, const struct drm_framebuffer *fb,
> -		       const struct drm_rect *clip, bool vaddr_cached_hint,
> -		       void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int np=
ixels))
> +/* TODO: Make this function work with multi-plane formats. */
> +static int __drm_fb_xfrm(void *dst, unsigned long dst_pitch, unsigned lo=
ng dst_pixsize,
> +			 const void *vaddr, const struct drm_framebuffer *fb,
> +			 const struct drm_rect *clip, bool vaddr_cached_hint,
> +			 void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels=
))
>  {
>  	unsigned long linepixels =3D drm_rect_width(clip);
>  	unsigned long lines =3D drm_rect_height(clip);
> @@ -84,11 +84,11 @@ static int drm_fb_xfrm(void *dst, unsigned long dst_p=
itch, unsigned long dst_pix
>  	return 0;
>  }
>  =

> -/* TODO: Make this functon work with multi-plane formats. */
> -static int drm_fb_xfrm_toio(void __iomem *dst, unsigned long dst_pitch, =
unsigned long dst_pixsize,
> -			    const void *vaddr, const struct drm_framebuffer *fb,
> -			    const struct drm_rect *clip, bool vaddr_cached_hint,
> -			    void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npix=
els))
> +/* TODO: Make this function work with multi-plane formats. */
> +static int __drm_fb_xfrm_toio(void __iomem *dst, unsigned long dst_pitch=
, unsigned long dst_pixsize,
> +			      const void *vaddr, const struct drm_framebuffer *fb,
> +			      const struct drm_rect *clip, bool vaddr_cached_hint,
> +			      void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int np=
ixels))
>  {
>  	unsigned long linepixels =3D drm_rect_width(clip);
>  	unsigned long lines =3D drm_rect_height(clip);
> @@ -129,6 +129,29 @@ static int drm_fb_xfrm_toio(void __iomem *dst, unsig=
ned long dst_pitch, unsigned
>  	return 0;
>  }
>  =

> +/* TODO: Make this function work with multi-plane formats. */
> +static int drm_fb_xfrm(struct iosys_map *dst,
> +		       const unsigned int *dst_pitch, const u8 *dst_pixsize,
> +		       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +		       const struct drm_rect *clip, bool vaddr_cached_hint,
> +		       void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int np=
ixels))
> +{
Just to repeat myself a little, this assumes src (vmap) is always system
memory (not io).

> +	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> +		0, 0, 0, 0
> +	};
> +
> +	if (!dst_pitch)
> +		dst_pitch =3D default_dst_pitch;
> +
> +	if (dst[0].is_iomem)
> +		return __drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], dst_pixsiz=
e[0],
> +					  vmap[0].vaddr, fb, clip, false, xfrm_line);
> +	else
> +		return __drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], dst_pixsize[0],
> +				     vmap[0].vaddr, fb, clip, false, xfrm_line);

It looks like vaddr_cached_hint is always false, so can we remove it?

> +}
> +
> +
>  /**
>   * drm_fb_memcpy - Copy clip buffer
>   * @dst: Array of destination buffers
> @@ -213,14 +236,10 @@ void drm_fb_swab(struct iosys_map *dst, const unsig=
ned int *dst_pitch,
>  		 const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  		 const struct drm_rect *clip, bool cached)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> -	};
>  	const struct drm_format_info *format =3D fb->format;
> -	u8 cpp =3D format->cpp[0];
>  	void (*swab_line)(void *dbuf, const void *sbuf, unsigned int npixels);
>  =

> -	switch (cpp) {
> +	switch (format->cpp[0]) {
>  	case 4:
>  		swab_line =3D drm_fb_swab32_line;
>  		break;
> @@ -230,21 +249,10 @@ void drm_fb_swab(struct iosys_map *dst, const unsig=
ned int *dst_pitch,
>  	default:
>  		drm_warn_once(fb->dev, "Format %p4cc has unsupported pixel size.\n",
>  			      &format->format);
> -		swab_line =3D NULL;
> -		break;
> -	}
> -	if (!swab_line)
>  		return;
> +	}
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst->is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], cpp,
> -				 vmap[0].vaddr, fb, clip, cached, swab_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], cpp, vmap[0].vaddr, fb,
> -			    clip, cached, swab_line);
> +	drm_fb_xfrm(dst, dst_pitch, format->cpp, vmap, fb, clip, cached, swab_l=
ine);

In this case we pass fb->format-cpp as dst_pitch - so we could retreive
is via the fb pointer.

>  }
>  EXPORT_SYMBOL(drm_fb_swab);
>  =

> @@ -277,19 +285,12 @@ void drm_fb_xrgb8888_to_rgb332(struct iosys_map *ds=
t, const unsigned int *dst_pi
>  			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			       const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] =3D {
> +		1,
>  	};
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 1, vmap[0].vaddr, f=
b, clip,
> -				 false, drm_fb_xrgb8888_to_rgb332_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 1, vmap[0].vaddr, fb, clip,
> -			    false, drm_fb_xrgb8888_to_rgb332_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_rgb332_line);

Here we construct the dst_pixsize.
What is needed to make us trust fb->format->cpp so we can just fetch the
info from format_info and drop dst_pixsize?

I do not see any lookup being necessary here or in the functions below.

If we use cpp (or even better using a helper function that avoid the
deprecated cpp), then adding support for planes is simpler. For now
dst_pixsize only pass the size for the first plane and there are a lot
of updates required to support additional planes.

Maybe I miss something obvious?!?


>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb332);
>  =

> @@ -344,9 +345,10 @@ void drm_fb_xrgb8888_to_rgb565(struct iosys_map *dst=
, const unsigned int *dst_pi
>  			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			       const struct drm_rect *clip, bool swab)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] =3D {
> +		2,
>  	};
> +
>  	void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels);
>  =

>  	if (swab)
> @@ -354,15 +356,7 @@ void drm_fb_xrgb8888_to_rgb565(struct iosys_map *dst=
, const unsigned int *dst_pi
>  	else
>  		xfrm_line =3D drm_fb_xrgb8888_to_rgb565_line;
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 2, vmap[0].vaddr, f=
b, clip,
> -				 false, xfrm_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 2, vmap[0].vaddr, fb, clip,
> -			    false, xfrm_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false, xfrm_li=
ne);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
>  =

> @@ -396,19 +390,12 @@ void drm_fb_xrgb8888_to_rgb888(struct iosys_map *ds=
t, const unsigned int *dst_pi
>  			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			       const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] =3D {
> +		3,
>  	};
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 3, vmap[0].vaddr, f=
b,
> -				 clip, false, drm_fb_xrgb8888_to_rgb888_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 3, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_xrgb8888_to_rgb888_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_rgb888_line);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888);
>  =

> @@ -435,19 +422,12 @@ static void drm_fb_rgb565_to_xrgb8888(struct iosys_=
map *dst, const unsigned int
>  				      const struct drm_framebuffer *fb,
>  				      const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] =3D {
> +		4,
>  	};
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, f=
b,
> -				 clip, false, drm_fb_rgb565_to_xrgb8888_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_rgb565_to_xrgb8888_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_rgb565_to_xrgb8888_line);
>  }
>  =

>  static void drm_fb_rgb888_to_xrgb8888_line(void *dbuf, const void *sbuf,=
 unsigned int pixels)
> @@ -470,19 +450,12 @@ static void drm_fb_rgb888_to_xrgb8888(struct iosys_=
map *dst, const unsigned int
>  				      const struct drm_framebuffer *fb,
>  				      const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] =3D {
> +		4,
>  	};
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, f=
b,
> -				 clip, false, drm_fb_rgb888_to_xrgb8888_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_rgb888_to_xrgb8888_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_rgb888_to_xrgb8888_line);
>  }
>  =

>  static void drm_fb_xrgb8888_to_xrgb2101010_line(void *dbuf, const void *=
sbuf, unsigned int pixels)
> @@ -518,19 +491,12 @@ void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_ma=
p *dst, const unsigned int *d
>  				    const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  				    const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] =3D {
> +		4,
>  	};
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, f=
b,
> -				 clip, false, drm_fb_xrgb8888_to_xrgb2101010_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_xrgb8888_to_xrgb2101010_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_xrgb2101010_line);
>  }
>  =

>  static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, =
unsigned int pixels)
> @@ -571,19 +537,12 @@ void drm_fb_xrgb8888_to_gray8(struct iosys_map *dst=
, const unsigned int *dst_pit
>  			      const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			      const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] =3D {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] =3D {
> +		1,
>  	};
>  =

> -	if (!dst_pitch)
> -		dst_pitch =3D default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 1, vmap[0].vaddr, f=
b,
> -				 clip, false, drm_fb_xrgb8888_to_gray8_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 1, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_xrgb8888_to_gray8_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_gray8_line);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
>  =

> -- =

> 2.37.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
