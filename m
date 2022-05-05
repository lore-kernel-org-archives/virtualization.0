Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE4C433FE
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 08:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF9C482730;
	Thu,  5 May 2022 08:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FNtr8oUN0Esy; Thu,  5 May 2022 08:12:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 559948278F;
	Thu,  5 May 2022 08:12:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17937C0032;
	Thu,  5 May 2022 08:12:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D727C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6432F8278F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pzC1ghX9a2vs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:12:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26B0082730
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:12:54 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id dk23so7231795ejb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=HGg12g7rqV6st3fX8w/ctnDqBvDsC80/xO++kQycD7o=;
 b=W6QD2uraJIvioMM9fyC+0Oiy7cWSHGHMC5pGskeQFPUekBSjtiKm3A70QIEWNq7Sh5
 VHhAw8hpfYagzTcrcMnO/hTb04SOcTe5+Mfj4gD6ifM0bAYMuh0fCSo7taWQKTU+4m31
 dnKZxrmpJh8nR6mgozp6BQibK09vKIbIrpwKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=HGg12g7rqV6st3fX8w/ctnDqBvDsC80/xO++kQycD7o=;
 b=DyrmFRHxO9d1hM2lUsEarzCmBlwxzOQUJjAeyMRlyz2pfve0O/GPnhf7jJJvAORGFR
 wB5bsS8v2DicvRUpXRnDC0K38iv5264bDlKrgDbwlPQr2d6wqvae7pW0dJND2tuIJKWx
 nRmLUFKF+yVpJ2PeaynqqT5xFLpYabf/x0g9qDW/K70ODUp+C8SRbeCi8F46J8YPk86k
 uEKOOYVgaZZ0JPjL468pHSFXqiq51m/lcjWzBgzIxQEqOt6avyLWWmbzhqS/lhHpMP17
 W1RNT4SEBjp5lg9Jo8kNhHkc5cADEOn6Lm7SMtMn1J+D+j4JPuEkVyoTRDZ+iTdhuecN
 fJMg==
X-Gm-Message-State: AOAM533PTkIVcnMIthm1M4Z02FG6kpEnBAZUnv/ks54A+yHr65FmSBf6
 q2BRaVDDBDj5Xn48rEGDq1cgEQ==
X-Google-Smtp-Source: ABdhPJy/OlYDHV4abt2gnWtLXTtgDhEwCbc9MHayNWwoiurjDqvY2ogAsYMRzgyNYsm6uejfvxCNrQ==
X-Received: by 2002:a17:907:2cc6:b0:6f0:2de3:9446 with SMTP id
 hg6-20020a1709072cc600b006f02de39446mr24511672ejc.690.1651738373298; 
 Thu, 05 May 2022 01:12:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 gz14-20020a170907a04e00b006f3ef214e62sm447457ejc.200.2022.05.05.01.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 01:12:52 -0700 (PDT)
Date: Thu, 5 May 2022 10:12:50 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <YnOHAh9I1ds4+1J+@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Clark <robdclark@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-11-dmitry.osipenko@collabora.com>
 <248083d2-b8f2-a4d7-099d-70a7e7859c11@suse.de>
 <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
 <YmlYHNlcmNMfOeyy@phenom.ffwll.local>
 <8f932ab0-bb72-8fea-4078-dc59e9164bd4@collabora.com>
 <YnI3lE0TxLfZaQjE@phenom.ffwll.local>
 <01506516-ab2f-cb6e-7507-f2a3295efb59@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01506516-ab2f-cb6e-7507-f2a3295efb59@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, May 04, 2022 at 06:56:09PM +0300, Dmitry Osipenko wrote:
> On 5/4/22 11:21, Daniel Vetter wrote:
> ...
> >>> - Maybe also do what you suggest and keep a separate lock for this, b=
ut
> >>>   the fundamental issue is that this doesn't really work - if you sha=
re
> >>>   buffers both ways with two drivers using shmem helpers, then the
> >>>   ordering of this vmap_count_mutex vs dma_resv_lock is inconsistent =
and
> >>>   you can get some nice deadlocks. So not a great approach (and also =
the
> >>>   reason why we really need to get everyone to move towards dma_resv_=
lock
> >>>   as _the_ buffer object lock, since otherwise we'll never get a
> >>>   consistent lock nesting hierarchy).
> >>
> >> The separate locks should work okay because it will be always the
> >> exporter that takes the dma_resv_lock. But I agree that it's less ideal
> >> than defining the new rules for dma-bufs since sometime you will take
> >> the resv lock and sometime not, potentially hiding bugs related to loc=
kings.
> > =

> > That's the issue, some importers need to take the dma_resv_lock for
> > dma_buf_vmap too (e.g. to first nail the buffer in place when it's a
> > dynamic memory manager). In practice it'll work as well as what we have
> > currently, which is similarly inconsistent, except with per-driver locks
> > instead of shared locks from shmem helpers or dma-buf, so less obvious
> > that things are inconsistent.
> > =

> > So yeah if it's too messy maybe the approach is to have a separate lock
> > for vmap for now, land things, and then fix up dma_buf_vmap in a follow=
 up
> > series.
> =

> The amdgpu driver was the fist who introduced the concept of movable
> memory for dma-bufs. Now we want to support it for DRM SHMEM too. For
> both amdgpu ttm and shmem drivers we will want to hold the reservation
> lock when we're touching moveable buffers. The current way of denoting
> that dma-buf is movable is to implement the pin/unpin callbacks of the
> dma-buf ops, should be doable for shmem.

Hm that sounds like a bridge too far? I don't think we want to start
adding moveable dma-bufs for shmem, thus far at least no one asked for
that. Goal here is just to streamline the locking a bit and align across
all the different ways of doing buffers in drm.

Or do you mean something else and I'm just completely lost?

> A day ago I found that mapping of imported dma-bufs is broken at least
> for the Tegra DRM driver (and likely for others too) because driver
> doesn't assume that anyone will try to mmap imported buffer and just
> doesn't handle this case at all, so we're getting a hard lockup on
> touching mapped memory because we're mapping something else than the
> dma-buf.

Huh that sounds bad, how does this happen? Pretty much all pieces of
dma-buf (cpu vmap, userspace mmap, heck even dma_buf_attach) are optional
or at least can fail for various reasons. So exporters not providing mmap
support is fine, but importers then dying is not.

> My plan is to move the dma-buf management code to the level of DRM core
> and make it aware of the reservation locks for the dynamic dma-bufs.
> This way we will get the proper locking for dma-bufs and fix mapping of
> imported dma-bufs for Tegra and other drivers.

So maybe we're completely talking past each another, or coffee is not
working here on my end, but I've no idea what you mean.

We do have some helpers for taking care of the dma_resv_lock dance, and
Christian K=F6nig has an rfc patch set to maybe unify this further. But that
should be fairly orthogonal to reworking shmem (it might help a bit with
reworking shmem though).
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
