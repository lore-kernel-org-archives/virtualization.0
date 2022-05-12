Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F7FC433FE
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 17:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F278060B1D;
	Thu, 12 May 2022 17:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jz4yt5ggoZIP; Thu, 12 May 2022 17:05:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5940560761;
	Thu, 12 May 2022 17:05:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA0BC0032;
	Thu, 12 May 2022 17:05:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC03DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA09D82C84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9x4jdbJatEpj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:05:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3BB182C3E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:04:59 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id l16so7170553oil.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=chTQPE8s2XiI033YuqzMveiHeBofeKqYbLvthAkBmTo=;
 b=Ep4hhtVsOOvso0K4dDn5rqLsCgloqgBDkJIBretQ9s4UJqD5BY+MBB6oa1r4eLjk+t
 vM2tGcqz4sQfzLtff14nL3YYdLipq5/FU0mfGYLVlyLguGNbpbvmVvq31x8Wcd1Icw1e
 tOCvyAz/evcOx2MRPkcBsbyg7KsbSVHS2bYOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=chTQPE8s2XiI033YuqzMveiHeBofeKqYbLvthAkBmTo=;
 b=h61NkDxlkg8fQF9mbNSDpmIjjlaAErgJEIaRKAmFiZKONceMIrZ799w8aRKqq/oetb
 d4q5NemWPxqTD4779U2lQ5O5CIZkF+B37c2xKkw8PwsJZw9vo0loGUeBAKmWFJDVoh+/
 S+HWDF+bPm79ZTtDt/4flrf89siYvEFxD+eEDP79qOxLQAVPnHzoUPzpDaPH5Ops7jxN
 3nXC8MssibzH5ZS8uLaRFrAzxXDGUEdjb5v9JoKrPdbi3JHuZx4HncxRgtQnAoC+vaP3
 9B5ZBvB5P/Cb1HWCvUMmZrjYN9yu89TU/TlmJWvc8UwysFDEI1kSRK9Z6cAa08XNde19
 cOqg==
X-Gm-Message-State: AOAM532nZeo2Km6LvOTKcAsJ9AJ+cbJqCW3GlvkkArWIxL4k0Q9/GKKj
 zPDT1j7xpEaIQ/OHFlpsAhpihp5a1k+909RAXGMEWQ==
X-Google-Smtp-Source: ABdhPJzRyMZhGiuFkuqzg39xxxmhA96f9Tcd0cbFtk1OH5x7cRguRLX0Vl9KPPxWSrz95Xti0+3ONFcOVR+IlJ9RYpY=
X-Received: by 2002:a05:6808:1314:b0:326:e438:d8cd with SMTP id
 y20-20020a056808131400b00326e438d8cdmr5966587oiv.228.1652375098764; Thu, 12
 May 2022 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-12-dmitry.osipenko@collabora.com>
 <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
 <ff97790a-fb64-1e15-74b4-59c807bce0b9@collabora.com>
 <Ynkb1U2nNWYPML88@phenom.ffwll.local>
 <5fdf5232-e2b2-b444-5a41-f1db7e6a04da@collabora.com>
 <Ynu1k5lH+xvqtObG@phenom.ffwll.local>
 <3429a12f-9fbe-b66b-dbbd-94a1df54714e@collabora.com>
 <YnwJ0kLwLS7RxuwS@phenom.ffwll.local>
 <0ae6fed7-b166-d2b8-0e42-84b94b777c20@collabora.com>
In-Reply-To: <0ae6fed7-b166-d2b8-0e42-84b94b777c20@collabora.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 12 May 2022 19:04:47 +0200
Message-ID: <CAKMK7uGS3PSwbkW7gj1hd2pz591HwY6Gbb=P_X4N5KOM5+X85w@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 12 May 2022 at 13:36, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 5/11/22 22:09, Daniel Vetter wrote:
> > On Wed, May 11, 2022 at 07:06:18PM +0300, Dmitry Osipenko wrote:
> >> On 5/11/22 16:09, Daniel Vetter wrote:
> >>>>>>> I'd like to ask you to reduce the scope of the patchset and build the
> >>>>>>> shrinker only for virtio-gpu. I know that I first suggested to build
> >>>>>>> upon shmem helpers, but it seems that it's easier to do that in a later
> >>>>>>> patchset.
> >>>>>> The first version of the VirtIO shrinker didn't support memory eviction.
> >>>>>> Memory eviction support requires page fault handler to be aware of the
> >>>>>> evicted pages, what should we do about it? The page fault handling is a
> >>>>>> part of memory management, hence to me drm-shmem is already kinda a MM.
> >>>>> Hm I still don't get that part, why does that also not go through the
> >>>>> shmem helpers?
> >>>> The drm_gem_shmem_vm_ops includes the page faults handling, it's a
> >>>> helper by itself that is used by DRM drivers.
> >>>>
> >>>> I could try to move all the shrinker logic to the VirtIO and re-invent
> >>>> virtio_gem_shmem_vm_ops, but what is the point of doing this for each
> >>>> driver if we could have it once and for all in the common drm-shmem code?
> >>>>
> >>>> Maybe I should try to factor out all the shrinker logic from drm-shmem
> >>>> into a new drm-shmem-shrinker that could be shared by drivers? Will you
> >>>> be okay with this option?
> >>> I think we're talking past each another a bit. I'm only bringing up the
> >>> purge vs eviction topic we discussed in the other subthread again.
> >>
> >> Thomas asked to move the whole shrinker code to the VirtIO driver and
> >> I's saying that this is not a great idea to me, or am I misunderstanding
> >> the Thomas' suggestion? Thomas?
> >
> > I think it was just me creating a confusion here.
> >
> > fwiw I do also think that shrinker in shmem helpers makes sense, just in
> > case that was also lost in confusion.
>
> Okay, good that we're on the same page now.
>
> >>>>> I'm still confused why drivers need to know the difference
> >>>>> between evition and purging. Or maybe I'm confused again.
> >>>> Example:
> >>>>
> >>>> If userspace uses IOV addresses, then these addresses must be kept
> >>>> reserved while buffer is evicted.
> >>>>
> >>>> If BO is purged, then we don't need to retain the IOV space allocated
> >>>> for the purged BO.
> >>> Yeah but is that actually needed by anyone? If userspace fails to allocate
> >>> another bo because of lack of gpu address space then it's very easy to
> >>> handle that:
> >>>
> >>> 1. Make a rule that "out of gpu address space" gives you a special errno
> >>> code like ENOSPC
> >>>
> >>> 2. If userspace gets that it walks the list of all buffers it marked as
> >>> purgeable and nukes them (whether they have been evicted or not). Then it
> >>> retries the bo allocation.
> >>>
> >>> Alternatively you can do step 2 also directly from the bo alloc ioctl in
> >>> step 1. Either way you clean up va space, and actually a lot more (you
> >>> potentially nuke all buffers marked as purgeable, not just the ones that
> >>> have been purged already) and only when va cleanup is actually needed
> >>>
> >>> Trying to solve this problem at eviction time otoh means:
> >>> - we have this difference between eviction and purging
> >>> - it's still not complete, you still need to glue step 2 above into your
> >>>   driver somehow, and once step 2 above is glued in doing additional
> >>>   cleanup in the purge function is just duplicated logic
> >>>
> >>> So at least in my opinion this isn't the justification we need. And we
> >>> should definitely not just add that complication "in case, for the
> >>> future", if we don't have a real need right now. Adding it later on is
> >>> easy, removing it later on because it just gets in the way and confuses is
> >>> much harder.
> >>
> >> The IOVA space is only one example.
> >>
> >> In case of the VirtIO driver, we may have two memory allocation for a
> >> BO. One is the shmem allcation in guest and the other is in host's vram.
> >> If we will only release the guest's memory on purge, then the vram will
> >> remain allocated until BO is destroyed, which unnecessarily sub-optimal.
> >
> > Hm but why don't you just nuke the memory on the host side too when you
> > evict? Allowing the guest memory to be swapped out while keeping the host
> > memory allocation alive also doesn't make a lot of sense for me. Both can
> > be recreated (I guess at least?) on swap-in.
>
> Shouldn't be very doable or at least worth the efforts. It's userspace
> that manages data uploading, kernel only provides transport for the
> virtio-gpu commands.
>
> Drivers are free to use the same function for both purge() and evict()
> callbacks if they want. Getting rid of the purge() callback creates more
> problems than solves, IMO.

Hm this still sounds pretty funny and defeats the point of
purgeable/evictable buffers a bit I think. But also I guess we'd
pushed this bikeshed to the max, so I think if you make ->purge
optional and just call ->evict if that's not present, and document it
all in the kerneldoc, then I think that's good.

I just don't think that encouraging drivers to distinguish between
evict/purge is a good idea for almost all of them.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
