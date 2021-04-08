Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB7FC433B4
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 11:39:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04DA61157
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 11:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04DA61157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A78F160703;
	Thu,  8 Apr 2021 11:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WoseY5Ij1wBK; Thu,  8 Apr 2021 11:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 582F76069C;
	Thu,  8 Apr 2021 11:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39016C000B;
	Thu,  8 Apr 2021 11:39:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED8E6C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7D08839E7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sEXHnM0y9klU
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:39:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2AC5839E4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:39:22 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id s7so1650744wru.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Apr 2021 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=3KNkyx85LPCD228SCseTYxmoSL60uBwuVlcm/wUgEOA=;
 b=fHGvn4RtOh030q1DAmBBWDlKqWYLlxDGmURjTv7oVbTa5wMtYSFRpbek/G42R0PKpV
 aE0TKiuldac6kmvfVsttDQeduCm7/kh7ppKbQ0OqqEOcC7bQsGh95+j0VPHH6dfpbXtI
 7Frxo16mo7e2jtV4VAoUmPi9ONL3w7YDQ9Thg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3KNkyx85LPCD228SCseTYxmoSL60uBwuVlcm/wUgEOA=;
 b=joRhiYOsAbB3actaNpgA9K7kJsZtCSiks0Ihtk3IvuXgsW7io3gYtoCAoj2WnVOHn2
 0UUfyLwcI9C949UO354lIaDI835nu6nHk2GmhE5EK0uMc8CQ+ZEWxiiBLPWjnjH5VBYb
 ti0w+vtdyP/vclGqYILxrtrUHZQYhEbKC46MrdC62RWu7TZwXCT3yOLHzwWGVjLLqmyL
 df+aRuKgvHXAIQfJS/gUFutRZ3f4bK+TwrdruxqwMwc98MPwuf8gjEEeo1gXjwXg8iC+
 Js7T7FLLgFYXY1bP7PdNf2o1P8ykw1GQbeOIHF7+BTNq0miAjvKXOEUryfteR1+C2yXE
 chZQ==
X-Gm-Message-State: AOAM532SjAhh52B+T2J9rp8EvD7Loj87lp7bESgTWQ/+mpHBPHlLkz4I
 yQ4jWDT/VbQ+xSxfpXtT5QlOTw==
X-Google-Smtp-Source: ABdhPJzUf3HqHqqyVAN4SVwOvO1MafejNTLSa8pbE71k+GrvSgkhvWynSqpxLaLkX8Qygt5PkZkkjA==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr10783874wrw.292.1617881961181; 
 Thu, 08 Apr 2021 04:39:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k131sm11817858wmf.39.2021.04.08.04.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 04:39:20 -0700 (PDT)
Date: Thu, 8 Apr 2021 13:39:18 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/4] drm: Generic dumb_map_offset for TTM-based drivers
Message-ID: <YG7rZiF0IgbTDVPM@phenom.ffwll.local>
References: <20210406082942.24049-1-tzimmermann@suse.de>
 <YG7mHvmhPZIPA37B@phenom.ffwll.local>
 <52dd3e3f-a893-3d90-e642-df01a033490a@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52dd3e3f-a893-3d90-e642-df01a033490a@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: airlied@linux.ie, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org,
 bskeggs@redhat.com
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

On Thu, Apr 08, 2021 at 01:34:03PM +0200, Thomas Zimmermann wrote:
> Hi
> =

> Am 08.04.21 um 13:16 schrieb Daniel Vetter:
> > On Tue, Apr 06, 2021 at 10:29:38AM +0200, Thomas Zimmermann wrote:
> > > The implementation of drm_driver.dumb_map_offset is the same for seve=
ral
> > > TTM-based drivers. Provide a common function in GEM-TTM helpers.
> > =

> > Out of curiosity, why does this not fit for radeon/amdgpu?
> =

> These drivers perform additional permission checks in their implementatio=
ns.
> =

> But those checks are also part of the actual mmap code. I want to propose=
 a
> patch to use the generic drm_gem_ttm_map_offset in amdgpu/radeon, and then
> rely on mmap to fail if necessary. It might result in a longer discussion,
> so that's for another patchset.

Ah cool, makes sense.
-Daniel

> =

> Best regards
> Thomas
> =

> > -Daniel
> > =

> > > =

> > > Thomas Zimmermann (4):
> > >    drm/gem-ttm-helper: Provide helper for struct
> > >      drm_driver.dumb_map_offset
> > >    drm/vram-helper: Use drm_gem_ttm_dumb_map_offset()
> > >    drm/nouveau: Use drm_gem_ttm_dumb_map_offset()
> > >    drm/qxl: Use drm_gem_ttm_dumb_map_offset()
> > > =

> > >   drivers/gpu/drm/drm_gem_ttm_helper.c      | 33 ++++++++++++++++
> > >   drivers/gpu/drm/drm_gem_vram_helper.c     | 48 --------------------=
---
> > >   drivers/gpu/drm/nouveau/nouveau_display.c | 18 ---------
> > >   drivers/gpu/drm/nouveau/nouveau_display.h |  2 -
> > >   drivers/gpu/drm/nouveau/nouveau_drm.c     |  3 +-
> > >   drivers/gpu/drm/qxl/qxl_drv.c             |  3 +-
> > >   drivers/gpu/drm/qxl/qxl_drv.h             |  3 --
> > >   drivers/gpu/drm/qxl/qxl_dumb.c            | 17 --------
> > >   drivers/gpu/drm/qxl/qxl_ioctl.c           |  4 +-
> > >   drivers/gpu/drm/qxl/qxl_object.h          |  5 ---
> > >   include/drm/drm_gem_ttm_helper.h          |  5 ++-
> > >   include/drm/drm_gem_vram_helper.h         |  7 +---
> > >   12 files changed, 45 insertions(+), 103 deletions(-)
> > > =

> > > --
> > > 2.30.2
> > > =

> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> =





-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
