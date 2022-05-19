Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC173C433EF
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 14:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66B4D40C44;
	Thu, 19 May 2022 14:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mt8p6ApS8Wb7; Thu, 19 May 2022 14:13:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A04A740C3D;
	Thu, 19 May 2022 14:13:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C0CC0039;
	Thu, 19 May 2022 14:13:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90753C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8723241D1C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s5GdWOCLPbzZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:13:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C96B341D09
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:13:12 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id i19so10184880eja.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=vi8FLHHiPPyioIPEKRDcfMPiA7dt4CZBFdLz0VkHkSk=;
 b=Mx5msflnyEjn+csTnt3GB7T0omMZFuDuJt7I780xq0LRIqO3vUafELKRJ45PUXaNWe
 74jJLzwXPU5CgbeFr1a9MeQK0ecteG6FKSVVqxfaiPerXonPNrppBNzGbGGPw2wGKJkR
 cyIQrFBNlKaA9Wm1gRyO0YEqUWg5RB3TROUSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=vi8FLHHiPPyioIPEKRDcfMPiA7dt4CZBFdLz0VkHkSk=;
 b=Odp0rpM9V7M9JfZulk03Uhae6s8ftOWycpKB+1mz1TvYE7xqjZO59jeZCcUoJ7sfzt
 CFJSH+rEU0bbWR7LPZjv+O+7lBQbpShxN+GUQYJ6luIr9Bl0KEQn1VkRb+ce5Jd0tXcC
 z02zszgbK5NxGsYSXzNxoBowgKr3DCPXb/3RRUsqdOba4KSZWsmZWKFsLFRs4J3gWt+Y
 +Ktlbd3TOTSauoodbxV0hhKmMQbgMErX0ulcTxNW+zcrFfIo2VLkyqFDShK/Dt+mBKFM
 DGMSkumd25bT8RnR9VU4P9nkDReeZ1MtO013wDSK6ibr2y1/19DUC12mE4sKXvU0urSC
 KpMg==
X-Gm-Message-State: AOAM533eOwH1mw3O85blSkguSVoGgqujbmDPvc7FBYwfDlmsWLDDAVK/
 pIWf2kg+CxpOVFIHXjMshnC+TQ==
X-Google-Smtp-Source: ABdhPJz9BtWjj+WYurQcEsKgxbPJP2pEo6IeWwthzj+3hSJfKwWkIq7YhB5ln3V0VbEOPMseCwcIsg==
X-Received: by 2002:a17:907:628c:b0:6ee:70cf:d59 with SMTP id
 nd12-20020a170907628c00b006ee70cf0d59mr4580472ejc.402.1652969590886; 
 Thu, 19 May 2022 07:13:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 i2-20020aa7c702000000b0042617ba6380sm2894441edq.10.2022.05.19.07.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 07:13:09 -0700 (PDT)
Date: Thu, 19 May 2022 16:13:07 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
Message-ID: <YoZQc4fsPAiboTtC@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
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
References: <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
 <ff97790a-fb64-1e15-74b4-59c807bce0b9@collabora.com>
 <Ynkb1U2nNWYPML88@phenom.ffwll.local>
 <5fdf5232-e2b2-b444-5a41-f1db7e6a04da@collabora.com>
 <Ynu1k5lH+xvqtObG@phenom.ffwll.local>
 <3429a12f-9fbe-b66b-dbbd-94a1df54714e@collabora.com>
 <YnwJ0kLwLS7RxuwS@phenom.ffwll.local>
 <0ae6fed7-b166-d2b8-0e42-84b94b777c20@collabora.com>
 <CAKMK7uGS3PSwbkW7gj1hd2pz591HwY6Gbb=P_X4N5KOM5+X85w@mail.gmail.com>
 <31bc7a14-ff30-6961-b4fc-0aad83551df9@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31bc7a14-ff30-6961-b4fc-0aad83551df9@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Thu, May 12, 2022 at 10:04:53PM +0300, Dmitry Osipenko wrote:
> On 5/12/22 20:04, Daniel Vetter wrote:
> > On Thu, 12 May 2022 at 13:36, Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 5/11/22 22:09, Daniel Vetter wrote:
> >>> On Wed, May 11, 2022 at 07:06:18PM +0300, Dmitry Osipenko wrote:
> >>>> On 5/11/22 16:09, Daniel Vetter wrote:
> >>>>>>>>> I'd like to ask you to reduce the scope of the patchset and build the
> >>>>>>>>> shrinker only for virtio-gpu. I know that I first suggested to build
> >>>>>>>>> upon shmem helpers, but it seems that it's easier to do that in a later
> >>>>>>>>> patchset.
> >>>>>>>> The first version of the VirtIO shrinker didn't support memory eviction.
> >>>>>>>> Memory eviction support requires page fault handler to be aware of the
> >>>>>>>> evicted pages, what should we do about it? The page fault handling is a
> >>>>>>>> part of memory management, hence to me drm-shmem is already kinda a MM.
> >>>>>>> Hm I still don't get that part, why does that also not go through the
> >>>>>>> shmem helpers?
> >>>>>> The drm_gem_shmem_vm_ops includes the page faults handling, it's a
> >>>>>> helper by itself that is used by DRM drivers.
> >>>>>>
> >>>>>> I could try to move all the shrinker logic to the VirtIO and re-invent
> >>>>>> virtio_gem_shmem_vm_ops, but what is the point of doing this for each
> >>>>>> driver if we could have it once and for all in the common drm-shmem code?
> >>>>>>
> >>>>>> Maybe I should try to factor out all the shrinker logic from drm-shmem
> >>>>>> into a new drm-shmem-shrinker that could be shared by drivers? Will you
> >>>>>> be okay with this option?
> >>>>> I think we're talking past each another a bit. I'm only bringing up the
> >>>>> purge vs eviction topic we discussed in the other subthread again.
> >>>>
> >>>> Thomas asked to move the whole shrinker code to the VirtIO driver and
> >>>> I's saying that this is not a great idea to me, or am I misunderstanding
> >>>> the Thomas' suggestion? Thomas?
> >>>
> >>> I think it was just me creating a confusion here.
> >>>
> >>> fwiw I do also think that shrinker in shmem helpers makes sense, just in
> >>> case that was also lost in confusion.
> >>
> >> Okay, good that we're on the same page now.
> >>
> >>>>>>> I'm still confused why drivers need to know the difference
> >>>>>>> between evition and purging. Or maybe I'm confused again.
> >>>>>> Example:
> >>>>>>
> >>>>>> If userspace uses IOV addresses, then these addresses must be kept
> >>>>>> reserved while buffer is evicted.
> >>>>>>
> >>>>>> If BO is purged, then we don't need to retain the IOV space allocated
> >>>>>> for the purged BO.
> >>>>> Yeah but is that actually needed by anyone? If userspace fails to allocate
> >>>>> another bo because of lack of gpu address space then it's very easy to
> >>>>> handle that:
> >>>>>
> >>>>> 1. Make a rule that "out of gpu address space" gives you a special errno
> >>>>> code like ENOSPC
> >>>>>
> >>>>> 2. If userspace gets that it walks the list of all buffers it marked as
> >>>>> purgeable and nukes them (whether they have been evicted or not). Then it
> >>>>> retries the bo allocation.
> >>>>>
> >>>>> Alternatively you can do step 2 also directly from the bo alloc ioctl in
> >>>>> step 1. Either way you clean up va space, and actually a lot more (you
> >>>>> potentially nuke all buffers marked as purgeable, not just the ones that
> >>>>> have been purged already) and only when va cleanup is actually needed
> >>>>>
> >>>>> Trying to solve this problem at eviction time otoh means:
> >>>>> - we have this difference between eviction and purging
> >>>>> - it's still not complete, you still need to glue step 2 above into your
> >>>>>   driver somehow, and once step 2 above is glued in doing additional
> >>>>>   cleanup in the purge function is just duplicated logic
> >>>>>
> >>>>> So at least in my opinion this isn't the justification we need. And we
> >>>>> should definitely not just add that complication "in case, for the
> >>>>> future", if we don't have a real need right now. Adding it later on is
> >>>>> easy, removing it later on because it just gets in the way and confuses is
> >>>>> much harder.
> >>>>
> >>>> The IOVA space is only one example.
> >>>>
> >>>> In case of the VirtIO driver, we may have two memory allocation for a
> >>>> BO. One is the shmem allcation in guest and the other is in host's vram.
> >>>> If we will only release the guest's memory on purge, then the vram will
> >>>> remain allocated until BO is destroyed, which unnecessarily sub-optimal.
> >>>
> >>> Hm but why don't you just nuke the memory on the host side too when you
> >>> evict? Allowing the guest memory to be swapped out while keeping the host
> >>> memory allocation alive also doesn't make a lot of sense for me. Both can
> >>> be recreated (I guess at least?) on swap-in.
> >>
> >> Shouldn't be very doable or at least worth the efforts. It's userspace
> >> that manages data uploading, kernel only provides transport for the
> >> virtio-gpu commands.
> >>
> >> Drivers are free to use the same function for both purge() and evict()
> >> callbacks if they want. Getting rid of the purge() callback creates more
> >> problems than solves, IMO.
> > 
> > Hm this still sounds pretty funny and defeats the point of
> > purgeable/evictable buffers a bit I think. But also I guess we'd
> > pushed this bikeshed to the max, so I think if you make ->purge
> > optional and just call ->evict if that's not present, and document it
> > all in the kerneldoc, then I think that's good.
> 
> This is a good enough compromise to me.
> 
> > I just don't think that encouraging drivers to distinguish between
> > evict/purge is a good idea for almost all of them.
> 
> Intel's shrinker checks the "madvise" status of BOs and then decides
> what to do based on it. Perhaps we could move the decision-making about
> purging to drivers and then it will be single evict() callback, but will
> drivers really ever need to be responsible for this decision-making or
> this will be an unnecessary boilerplate code in the drivers? I'll think
> more about this.

tbh I wouldn't worry about details, you've convinced me that some
differentiation between evict and purged makes sense. And yeah maybe
drivers should have a helper to check that instead of explicit argument,
but that's a bikeshed color choice which should be fairly easy to adjust
later on still.

> Thank you all for taking time to look at this patchset. I'm preparing
> the new version.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
