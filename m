Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC21C433ED
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 11:16:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA51561155
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 11:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA51561155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88AD884D72;
	Thu,  8 Apr 2021 11:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPOTG_lZcp62; Thu,  8 Apr 2021 11:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3638883A51;
	Thu,  8 Apr 2021 11:16:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19EACC000B;
	Thu,  8 Apr 2021 11:16:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BA49C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0212784D6B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-6fBvkAgYRr
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:16:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBD2083A51
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:16:50 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 g18-20020a7bc4d20000b0290116042cfdd8so2716776wmk.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Apr 2021 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2rGXrZ6/Y1EiQNPy9lkbFWL4CJZGqYO2LJVNvjD1io4=;
 b=OHopb0BGApE+w2iQb+y029BFxSz9rLKFQjmM26EOnFqolAo53AqcdxDPcgH4GGshsx
 BDo2R1Ngn8YhwFfhU1bRXkxhUkC8+CvFuLK4r/rDY/d45eKlxh8hkZKuhBPd4fzNvmq9
 9HQn1Z6vWXn5rxmfhIbP53Ja69zxlwtLV+/WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2rGXrZ6/Y1EiQNPy9lkbFWL4CJZGqYO2LJVNvjD1io4=;
 b=kB/SNTBWjzDhiTHrBN+WQzANxGpuDITj0+OclnGFJQ2giZJSbg9klie2KY1PqRjLZc
 NWHvhIyRaoFDD4Ic1oPopv68gDRrS7duk7h8p+4ztz2Z01jWDJkUenPwdjweEmo6RzK5
 0GQP3x5oVd/i1tLirgMy/Lg2DVr98lrgpM/ouYeo174IYfJPfr92d3d4Di+TnaBA6hGL
 Qm4gAoabbRr6IJr/pjvvBQk0RnV8HXwyvr9VJ1H6g1TGGlKFccysD50Oq+BNZeoxLH5N
 uBVyeouQBVm9JRtuOJi/QwryMP3RG9L1Hd2SFzaMAF1d5cqo/hMKI5IYEZrEvaaMI0GK
 OrSQ==
X-Gm-Message-State: AOAM533PhijS1VPVIXWCvVUYo0YWRVwB88f+6UVlXpsK3I7dy+yj8/br
 qIO+k/KSb6a4vHWXoEsx+Od4rA==
X-Google-Smtp-Source: ABdhPJxQtEIMNNWiroexEm/m5G85YkQS1wiT3VlgjBBAAWlukovDIO0E7vB7vyBxMtzOmujVy8JS4g==
X-Received: by 2002:a05:600c:89a:: with SMTP id
 l26mr7826257wmp.179.1617880609163; 
 Thu, 08 Apr 2021 04:16:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b6sm9577334wrv.12.2021.04.08.04.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 04:16:48 -0700 (PDT)
Date: Thu, 8 Apr 2021 13:16:46 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/4] drm: Generic dumb_map_offset for TTM-based drivers
Message-ID: <YG7mHvmhPZIPA37B@phenom.ffwll.local>
References: <20210406082942.24049-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406082942.24049-1-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: airlied@linux.ie, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, virtualization@lists.linux-foundation.org, daniel@ffwll.ch,
 spice-devel@lists.freedesktop.org, bskeggs@redhat.com
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

On Tue, Apr 06, 2021 at 10:29:38AM +0200, Thomas Zimmermann wrote:
> The implementation of drm_driver.dumb_map_offset is the same for several
> TTM-based drivers. Provide a common function in GEM-TTM helpers.

Out of curiosity, why does this not fit for radeon/amdgpu?
-Daniel

> 
> Thomas Zimmermann (4):
>   drm/gem-ttm-helper: Provide helper for struct
>     drm_driver.dumb_map_offset
>   drm/vram-helper: Use drm_gem_ttm_dumb_map_offset()
>   drm/nouveau: Use drm_gem_ttm_dumb_map_offset()
>   drm/qxl: Use drm_gem_ttm_dumb_map_offset()
> 
>  drivers/gpu/drm/drm_gem_ttm_helper.c      | 33 ++++++++++++++++
>  drivers/gpu/drm/drm_gem_vram_helper.c     | 48 -----------------------
>  drivers/gpu/drm/nouveau/nouveau_display.c | 18 ---------
>  drivers/gpu/drm/nouveau/nouveau_display.h |  2 -
>  drivers/gpu/drm/nouveau/nouveau_drm.c     |  3 +-
>  drivers/gpu/drm/qxl/qxl_drv.c             |  3 +-
>  drivers/gpu/drm/qxl/qxl_drv.h             |  3 --
>  drivers/gpu/drm/qxl/qxl_dumb.c            | 17 --------
>  drivers/gpu/drm/qxl/qxl_ioctl.c           |  4 +-
>  drivers/gpu/drm/qxl/qxl_object.h          |  5 ---
>  include/drm/drm_gem_ttm_helper.h          |  5 ++-
>  include/drm/drm_gem_vram_helper.h         |  7 +---
>  12 files changed, 45 insertions(+), 103 deletions(-)
> 
> --
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
