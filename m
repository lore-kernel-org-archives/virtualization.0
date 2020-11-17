Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B73BC2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 10:01:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D631E2225E
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 10:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="itDdNhh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D631E2225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2073E20484;
	Tue, 17 Nov 2020 10:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6cgVWqP8jQH; Tue, 17 Nov 2020 10:01:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 623CA203FD;
	Tue, 17 Nov 2020 10:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48300C0800;
	Tue, 17 Nov 2020 10:01:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC6F4C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A665B2046F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8PqhzOvvaaRD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:01:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 11F7E203FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:01:42 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id a65so2650965wme.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 02:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Tvr1i8BbCmuVJQLalZ44/BhPFnHlVISYduMktrLuNCI=;
 b=itDdNhh6SSfakFwYmzALGlOUBg6O/56gi8Vi9q8ZDbDfX6vGGvyV3HJOM/9GK86Hye
 p4FfQMeGhvjyrK5wxacR4br6Quc1WhLJ/0/QsrlCEp8j8fccRueIbfPXJy4Gh0UahICZ
 Jt39bJP6M11G4y2NZ1NYMsVx4MNxKFL7m/c+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tvr1i8BbCmuVJQLalZ44/BhPFnHlVISYduMktrLuNCI=;
 b=SBqzUkj69uKHteeAXl4YinY0qpDr71ETo/xAbYtqPgEIa3fzvIjCEvQwlb7vV3gzJi
 6xwwVWEizBoiH3Y4Zgv/6ScnNZSu+T4dpJ1QfpY8oNSG05WvZwWXTwKuUKK7CAxgZTGX
 dhg2mQPoRxyo9e3wWCGe5FM/cChCvvftVmMswlEVRLepWmLfoFUgOfkb4+6tP+4TxbqI
 Taypy9R26hP1WMgOUrsxWQfmidXqzYdbYfAUDelYWcZfUHIGReVhsS64aNHPXlpWy/Z+
 UEPqRtwEqCMRaqG6aEYT3G8NPYJPXC/RxQoVrXj/C3vrJup1ssNASHJfy9L+xCkG8Jw6
 /kqQ==
X-Gm-Message-State: AOAM530552Apx6rL5UJT5xFe0NqfhG1d5kRGtzZ0qfhD9V2INgPdAIxq
 SnkfE8vPgZiaWNQUQ0yaelcLFQ==
X-Google-Smtp-Source: ABdhPJzFJDOMhOOhKeG9aRuj/uSvAxJjIiu9FlR+hB5CrkDmb40o5tJUkolWetSSD1v7XX0EYQtWfg==
X-Received: by 2002:a1c:44d4:: with SMTP id r203mr3440851wma.60.1605607301403; 
 Tue, 17 Nov 2020 02:01:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id c2sm28726842wrf.68.2020.11.17.02.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 02:01:40 -0800 (PST)
Date: Tue, 17 Nov 2020 11:01:38 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/qxl: Remove fbcon acceleration leftovers
Message-ID: <20201117100138.GI401619@phenom.ffwll.local>
References: <20201029101428.4058311-3-daniel.vetter@ffwll.ch>
 <20201029133347.4088884-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029133347.4088884-1-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>
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

On Thu, Oct 29, 2020 at 02:33:47PM +0100, Daniel Vetter wrote:
> These are leftovers from 13aff184ed9f ("drm/qxl: remove dead qxl fbdev
> emulation code").
> 
> v2: Somehow these structs provided the struct qxl_device pre-decl,
> reorder the header to not anger compilers.
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org

Entire series applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_drv.h | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 3602e8b34189..6239626503ef 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -166,20 +166,6 @@ struct qxl_drm_image {
>  	struct list_head chunk_list;
>  };
>  
> -struct qxl_fb_image {
> -	struct qxl_device *qdev;
> -	uint32_t pseudo_palette[16];
> -	struct fb_image fb_image;
> -	uint32_t visual;
> -};
> -
> -struct qxl_draw_fill {
> -	struct qxl_device *qdev;
> -	struct qxl_rect rect;
> -	uint32_t color;
> -	uint16_t rop;
> -};
> -
>  /*
>   * Debugfs
>   */
> @@ -188,8 +174,6 @@ struct qxl_debugfs {
>  	unsigned int num_files;
>  };
>  
> -int qxl_debugfs_fence_init(struct qxl_device *rdev);
> -
>  struct qxl_device {
>  	struct drm_device ddev;
>  
> @@ -271,6 +255,8 @@ struct qxl_device {
>  
>  #define to_qxl(dev) container_of(dev, struct qxl_device, ddev)
>  
> +int qxl_debugfs_fence_init(struct qxl_device *rdev);
> +
>  extern const struct drm_ioctl_desc qxl_ioctls[];
>  extern int qxl_max_ioctl;
>  
> -- 
> 2.28.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
