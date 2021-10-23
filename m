Return-Path: <SRS0=Fxu4=PL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE6C433EF
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 07:45:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F95660FE7
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 07:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F95660FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8166403DC;
	Sat, 23 Oct 2021 07:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y4aJ3dlonnCC; Sat, 23 Oct 2021 07:45:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D5C4403DA;
	Sat, 23 Oct 2021 07:45:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2410DC0012;
	Sat, 23 Oct 2021 07:45:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD083C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4DAC606C7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQQjIFIo9vH6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:45:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com
 [91.221.196.228])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BEB9605BE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 07:45:02 +0000 (UTC)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
 by mx2.smtp.larsendata.com (Halon) with ESMTPS
 id 27a44a98-33d5-11ec-ac3c-0050568cd888;
 Sat, 23 Oct 2021 07:45:12 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net
 [80.162.45.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: sam@ravnborg.org)
 by mail01.mxhotel.dk (Postfix) with ESMTPSA id 8E0A8194B12;
 Sat, 23 Oct 2021 09:44:55 +0200 (CEST)
Date: Sat, 23 Oct 2021 09:44:54 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/9] drm/simpledrm: Enable damage clips and virtual screens
Message-ID: <YXO9dlQkdJFbUbvb@ravnborg.org>
References: <20211022132829.7697-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211022132829.7697-1-tzimmermann@suse.de>
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

On Fri, Oct 22, 2021 at 03:28:20PM +0200, Thomas Zimmermann wrote:
> Enable FB_DAMAGE_CLIPS with simpledrm for improved performance and/or
> less overhead. With this in place, add support for virtual screens
> (i.e., framebuffers that are larger than the display resolution). This
> also enables fbdev panning and page flipping.
> 
> After the discussion and bug fixing wrt to fbdev overallocation, I
> decided to add full support for this to simpledrm. Patches #1 to #5
> change the format-helper functions accordingly. Destination buffers
> are now clipped by the caller and all functions support a similar
> feature set. This has some fallout in various drivers.
> 
> Patch #6 change fbdev emulation to support overallocation with
> shadow buffers, even if the hardware buffer would be too small.
This change is very welcome - I hope it will solve the problem
Alistair experience - see:
https://lore.kernel.org/all/CAKmqyKPCP45O5_gjCFwUs8jU4NrDnjAeLs7OYAE4j-LEUw+Hzg@mail.gmail.com/

	Sam

> 
> Patch #7 and #8 update simpledrm to enable damage clipping and virtual
> screen sizes. Both feature go hand in hand, sort of. For shadow-
> buffered planes, the DRM framebuffer lives in system memory. So the
> maximum size of the virtual screen is somewhat arbitrary. We add two
> constants for resonable maximum width and height of 4096 each.
> 
> Patch #9 adds documentation and a TODO item.
> 
> Tested with simpledrm. I also ran the recently posted fbdev panning
> tests to make sure that the fbdev overallocation works correctly. [1]
> 
> [1] https://lists.freedesktop.org/archives/igt-dev/2021-October/036642.html
> 
> Thomas Zimmermann (9):
>   drm/format-helper: Export drm_fb_clip_offset()
>   drm/format-helper: Rework format-helper memcpy functions
>   drm/format-helper: Add destination-buffer pitch to drm_fb_swab()
>   drm/format-helper: Rework format-helper conversion functions
>   drm/format-helper: Streamline blit-helper interface
>   drm/fb-helper: Allocate shadow buffer of surface height
>   drm/simpledrm: Enable FB_DAMAGE_CLIPS property
>   drm/simpledrm: Support virtual screen sizes
>   drm: Clarify semantics of struct
>     drm_mode_config.{min,max}_{width,height}
> 
>  Documentation/gpu/todo.rst                  |  15 ++
>  drivers/gpu/drm/drm_fb_helper.c             |   2 +-
>  drivers/gpu/drm/drm_format_helper.c         | 236 ++++++++++----------
>  drivers/gpu/drm/drm_mipi_dbi.c              |   6 +-
>  drivers/gpu/drm/gud/gud_pipe.c              |  14 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |   5 +-
>  drivers/gpu/drm/mgag200/mgag200_mode.c      |   4 +-
>  drivers/gpu/drm/tiny/cirrus.c               |  24 +-
>  drivers/gpu/drm/tiny/repaper.c              |   2 +-
>  drivers/gpu/drm/tiny/simpledrm.c            |  41 +++-
>  drivers/gpu/drm/tiny/st7586.c               |   2 +-
>  include/drm/drm_format_helper.h             |  58 ++---
>  include/drm/drm_gem_atomic_helper.h         |  18 ++
>  include/drm/drm_mode_config.h               |  13 ++
>  14 files changed, 254 insertions(+), 186 deletions(-)
> 
> --
> 2.33.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
