Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADE1C433FE
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 19:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 480B341548;
	Wed, 11 May 2022 19:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CoMsyTi6NSR1; Wed, 11 May 2022 19:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 865B6409F7;
	Wed, 11 May 2022 19:05:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61724C0039;
	Wed, 11 May 2022 19:05:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6120AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C32E41548
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYkQYPNUlPYI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:05:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AE92409F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:05:14 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id g20so3656762edw.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=4K/BqknQQ3B81Ri9IMPLTLrHNMzicKZVVfstqbcQoXw=;
 b=A/KCQGg5ugLO69SideOJEv3eS/RyBeILjrfEq1trEjYp4cb9RZCmIZVFqxyI7WsooG
 XsWzCAMH5B+G8qNASIFfM8v3cZTbZl3x5TWJGNd90LgqR8xJipz7OP0NHwqKYzKNE3I7
 MVIOk5NK+bWC0jwrLMNufBwoueLjBB6jdZuiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=4K/BqknQQ3B81Ri9IMPLTLrHNMzicKZVVfstqbcQoXw=;
 b=3wX70tHOg/5KHn2lzxIAnxrbZ5ya9UifHV4LHuyKw0LpBzsKwwx5siCAPw/UjP5OCz
 GVkYyhVA6oXIlUn4oqFq4rC5cSdb+TT9Nnqma44zrd40d5xGery/vz46dLXOcXYZcs9n
 LUYSFaLZ1OgVHHyLlK82xsUKG30DpnoaA1BvVJxSOIjqK/b8UKby48P3TTkwuq/QUduU
 A3P/GIrDerwXMzAU7rwKsbd5/ZNahe6cg58/hqdBNzF1vXw/XwPNGxNuRY/zDQXpahPN
 n6FFTA+zXHWBM04pTB/e/wWUm8ZezHReyXZ2jyM1PUCgkQdOWeiPGODDIxoTxGyMR8iu
 vE7g==
X-Gm-Message-State: AOAM531lrogaBXjZ7VFEm0ZPZ2L76EUyR9JF0hEHSRG8eS5SkIleizuR
 NixGlo4dVzCs0u+zNmAL1QP3og==
X-Google-Smtp-Source: ABdhPJxzbQWruH8VN9oOr7p/K2/W+DT07g4nY6eAZpa/3zcSLOTXAgDkDgKjcZvZEO42b/8vTn+Ifg==
X-Received: by 2002:a05:6402:278d:b0:42a:2dc0:744f with SMTP id
 b13-20020a056402278d00b0042a2dc0744fmr1951646ede.226.1652295912301; 
 Wed, 11 May 2022 12:05:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 i26-20020a1709063c5a00b006fa9384a0b5sm1259045ejg.61.2022.05.11.12.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 12:05:11 -0700 (PDT)
Date: Wed, 11 May 2022 21:05:09 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <YnwI5UX/zvmnAHvg@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Stone <daniel@fooishbar.org>,
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
References: <01506516-ab2f-cb6e-7507-f2a3295efb59@collabora.com>
 <YnOHAh9I1ds4+1J+@phenom.ffwll.local>
 <83e68918-68de-c0c6-6f9b-e94d34b19383@collabora.com>
 <YnkaUk0mZNuPsZ5r@phenom.ffwll.local>
 <4d08b382-0076-1ea2-b565-893d50b453cb@collabora.com>
 <YnuziJDmXVR09UzP@phenom.ffwll.local>
 <56787b70-fb64-64da-6006-d3aa3ed59d12@gmail.com>
 <3a362c32-870c-1d73-bba6-bbdcd62dc326@collabora.com>
 <YnvWUbh5QDDs6u2B@phenom.ffwll.local>
 <ba2836d0-9a3a-b879-cb1e-a48aed31637d@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba2836d0-9a3a-b879-cb1e-a48aed31637d@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
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

On Wed, May 11, 2022 at 06:40:32PM +0300, Dmitry Osipenko wrote:
> On 5/11/22 18:29, Daniel Vetter wrote:
> > On Wed, May 11, 2022 at 06:14:00PM +0300, Dmitry Osipenko wrote:
> >> On 5/11/22 17:24, Christian K=F6nig wrote:
> >>> Am 11.05.22 um 15:00 schrieb Daniel Vetter:
> >>>> On Tue, May 10, 2022 at 04:39:53PM +0300, Dmitry Osipenko wrote:
> >>>>> [SNIP]
> >>>>> Since vmapping implies implicit pinning, we can't use a separate lo=
ck in
> >>>>> drm_gem_shmem_vmap() because we need to protect the
> >>>>> drm_gem_shmem_get_pages(), which is invoked by drm_gem_shmem_vmap()=
 to
> >>>>> pin the pages and requires the dma_resv_lock to be locked.
> >>>>>
> >>>>> Hence the problem is:
> >>>>>
> >>>>> 1. If dma-buf importer holds the dma_resv_lock and invokes
> >>>>> dma_buf_vmap() -> drm_gem_shmem_vmap(), then drm_gem_shmem_vmap() s=
hall
> >>>>> not take the dma_resv_lock.
> >>>>>
> >>>>> 2. Since dma-buf locking convention isn't specified, we can't assume
> >>>>> that dma-buf importer holds the dma_resv_lock around dma_buf_vmap().
> >>>>>
> >>>>> The possible solutions are:
> >>>>>
> >>>>> 1. Specify the dma_resv_lock convention for dma-bufs and make all
> >>>>> drivers to follow it.
> >>>>>
> >>>>> 2. Make only DRM drivers to hold dma_resv_lock around dma_buf_vmap(=
).
> >>>>> Other non-DRM drivers will get the lockdep warning.
> >>>>>
> >>>>> 3. Make drm_gem_shmem_vmap() to take the dma_resv_lock and get dead=
lock
> >>>>> if dma-buf importer holds the lock.
> >>>>>
> >>>>> ...
> >>>> Yeah this is all very annoying.
> >>> Ah, yes that topic again :)
> >>>
> >>> I think we could relatively easily fix that by just defining and
> >>> enforcing that the dma_resv_lock must have be taken by the caller when
> >>> dma_buf_vmap() is called.
> >>>
> >>> A two step approach should work:
> >>> 1. Move the call to dma_resv_lock() into the dma_buf_vmap() function =
and
> >>> remove all lock taking from the vmap callback implementations.
> >>> 2. Move the call to dma_resv_lock() into the callers of dma_buf_vmap()
> >>> and enforce that the function is called with the lock held.
> >> I've doubts about the need to move out the dma_resv_lock() into the
> >> callers of dma_buf_vmap()..
> >>
> >> I looked through all the dma_buf_vmap() users and neither of them
> >> interacts with dma_resv_lock() at all, i.e. nobody takes the lock
> >> in/outside of dma_buf_vmap(). Hence it's easy and more practical to ma=
ke
> >> dma_buf_mmap/vmap() to take the dma_resv_lock by themselves.
> > i915_gem_dmabuf_vmap -> i915_gem_object_pin_map_unlocked ->
> >   i915_gem_object_lock -> dma_resv_lock
> > =

> > And all the ttm drivers should work similarly. So there's definitely
> > drivers which grab dma_resv_lock from their vmap callback.
> =

> Grr.. I'll take another look.
> =

> >> It's unclear to me which driver may ever want to do the mapping under
> >> the dma_resv_lock. But if we will ever have such a driver that will ne=
ed
> >> to map imported buffer under dma_resv_lock, then we could always add t=
he
> >> dma_buf_vmap_locked() variant of the function. In this case the locking
> >> rule will sound like this:
> >>
> >> "All dma-buf importers are responsible for holding the dma-reservation
> >> lock around the dmabuf->ops->mmap/vmap() calls."
> =

> Are you okay with this rule?

Yeah I think long-term it's where we want to be, just trying to find
clever ways to get there.

And I think Christian agrees with that?

> >>> It shouldn't be that hard to clean up. The last time I looked into it=
 my
> >>> main problem was that we didn't had any easy unit test for it.
> >> Do we have any tests for dma-bufs at all? It's unclear to me what you
> >> are going to test in regards to the reservation locks, could you please
> >> clarify?
> > Unfortunately not really :-/ Only way really is to grab a driver which
> > needs vmap (those are mostly display drivers) on an imported buffer, and
> > see what happens.
> > =

> > 2nd best is liberally sprinkling lockdep annotations all over the place
> > and throwing it at intel ci (not sure amd ci is accessible to the publi=
c)
> > and then hoping that's good enough. Stuff like might_lock and
> > dma_resv_assert_held.
> =

> Alright

So throwing it at intel-gfx-ci can't hurt I think, but that only covers
i915 so doesn't really help with the bigger issue of catching all the
drivers.

Cheers, Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
