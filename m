Return-Path: <SRS0=Fxu4=PL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE02AC433EF
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 07:49:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAD160FE7
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 07:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BAD160FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E14180BE7;
	Sat, 23 Oct 2021 07:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TtQM5iEojF7g; Sat, 23 Oct 2021 07:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0377E80B73;
	Sat, 23 Oct 2021 07:49:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2408C0012;
	Sat, 23 Oct 2021 07:49:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00745C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB42C81D46
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dNiVb3i468w6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:49:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com
 [91.221.196.215])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D13CA81D3D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:49:05 +0000 (UTC)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
 by mx1.smtp.larsendata.com (Halon) with ESMTPS
 id b451e108-33d5-11ec-9c3f-0050568c148b;
 Sat, 23 Oct 2021 07:49:08 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net
 [80.162.45.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: sam@ravnborg.org)
 by mail01.mxhotel.dk (Postfix) with ESMTPSA id DAC4F194B21;
 Sat, 23 Oct 2021 09:49:01 +0200 (CEST)
Date: Sat, 23 Oct 2021 09:49:00 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/9] drm/format-helper: Export drm_fb_clip_offset()
Message-ID: <YXO+bGIW9sn9Rcfw@ravnborg.org>
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211022132829.7697-2-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, david@lechnology.com,
 michael+lkml@stapelberg.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, javierm@redhat.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, joshua@stroblindustries.com,
 drawat.floss@gmail.com, noralf@tronnes.org, arnd@arndb.de, daniel@ffwll.ch,
 dirty.ice.hu@gmail.com, airlied@redhat.com, aros@gmx.com,
 kernel@amanoeldawod.com
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

On Fri, Oct 22, 2021 at 03:28:21PM +0200, Thomas Zimmermann wrote:
> Provide a function that computes the offset into a blit destination
> buffer. This will allow to move destination-buffer clipping into the
> format-helper callers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 10 ++++++++--
>  include/drm/drm_format_helper.h     |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 69fde60e36b3..28e9d0d89270 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -17,12 +17,18 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_rect.h>
>  
> -static unsigned int clip_offset(struct drm_rect *clip,
> -				unsigned int pitch, unsigned int cpp)
> +static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
>  {
>  	return clip->y1 * pitch + clip->x1 * cpp;
>  }
>  
> +unsigned long drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
> +				 const struct drm_rect *clip)
> +{
> +	return clip_offset(clip, pitch, format->cpp[0]);
> +}
> +EXPORT_SYMBOL(drm_fb_clip_offset);

Exported functions are expected to have kernel-doc documentation.
Just copy more or less from the changelog I think.

Anywhere else (I looked in struct drm_framebuffer) we only need unsigned
int for offsets and width/length - so I cannot see why we do an unsigned
int => unsigned long conversion here.

	Sam

> +
>  /**
>   * drm_fb_memcpy - Copy clip buffer
>   * @dst: Destination buffer
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index e86925cf07b9..90b9bd9ecb83 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -6,9 +6,13 @@
>  #ifndef __LINUX_DRM_FORMAT_HELPER_H
>  #define __LINUX_DRM_FORMAT_HELPER_H
>  
> +struct drm_format_info;
>  struct drm_framebuffer;
>  struct drm_rect;
>  
> +unsigned long drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
> +				 const struct drm_rect *clip);
> +
>  void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
>  		   struct drm_rect *clip);
>  void drm_fb_memcpy_dstclip(void __iomem *dst, unsigned int dst_pitch, void *vaddr,
> -- 
> 2.33.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
