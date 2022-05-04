Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D35C433FE
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 08:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECA2B4182C;
	Wed,  4 May 2022 08:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 51Mc3Yy74gss; Wed,  4 May 2022 08:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B7544415C5;
	Wed,  4 May 2022 08:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9493AC0039;
	Wed,  4 May 2022 08:24:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 355EEC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C02560B20
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1-0QldX5lBO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:24:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6502A607B0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:24:49 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id k23so1464417ejd.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 May 2022 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=Ovesdtp6wbhOkH+NcAMzlLg06s6VbGwva1kVuoINYQk=;
 b=TBvQi23u0ogQdfozTQtwQt2AfZ5O3wIws0IRua5JXBzopSxUT3lbN7m/1DjNfJXvbb
 bhip/kRJ31YoamHWRkngP1AfSwSYLUCx0oZMWSUfkVEa9W4HcI2MUNdHrcw95ipOL3No
 JNEBDEbjVnXssuNlGfnEmE/RIJ7lOhYZLQvsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=Ovesdtp6wbhOkH+NcAMzlLg06s6VbGwva1kVuoINYQk=;
 b=I6bCNLXlPJ40jdsJXucLDMYrZhijIGhpGFLV/Dldz7ibrF683qiXpMY/YC5PwRanc6
 c4r48wccWPhSRfOVafhXSdKuFqUosS6EOBXH6P//9EW0R8BmRgP2kpXEtJXyMTcCgBsX
 DoAbQU+LknstZokBjkk7DiPPYMXOpyquIPosDwGx7mva+u9SCRz0ytKxqcMawHhwCMZZ
 fHM3YRaaVcU2GOAl50uVedGUZpCwsUbC/HW/houdYf5Oj0WHkM9yrPwrxu4mkDU6Bhoo
 qIW55pvHRVKyMFNTp9M9LnHjJOHypSU9f5P4/z0YZQ2hAwsLFd/6kHRa+J6tYdNe+n5n
 zU8Q==
X-Gm-Message-State: AOAM531q8ZT3OJKaz6QUD61QvatTBJmVHVeL1p+4w/i+X4AG54+DJCAi
 cEXiZVUH+PBajfxUzJdqfjm+Pw==
X-Google-Smtp-Source: ABdhPJzszvDbjhJ+G30Fr1rXlh+x9ZnVp+UicNW3p16cXwuWbNNZegC0LHMS4cUpKPPzrzXMCysvOA==
X-Received: by 2002:a17:907:7f2a:b0:6f4:a358:c826 with SMTP id
 qf42-20020a1709077f2a00b006f4a358c826mr4773193ejc.404.1651652687434; 
 Wed, 04 May 2022 01:24:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 bf16-20020a0564021a5000b0042617ba63aesm8936084edb.56.2022.05.04.01.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 01:24:46 -0700 (PDT)
Date: Wed, 4 May 2022 10:24:45 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
Message-ID: <YnI4TRBkB6SaOVyu@phenom.ffwll.local>
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
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-12-dmitry.osipenko@collabora.com>
 <ebe3dfdb-04ac-9ab1-64ff-9d54f96afe57@suse.de>
 <7f497f99-f4c1-33d6-46cf-95bd90188fe3@collabora.com>
 <YmlbXoeaVds/bjYn@phenom.ffwll.local>
 <d0970dbd-e6e7-afa0-fdfd-b755008e371f@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d0970dbd-e6e7-afa0-fdfd-b755008e371f@collabora.com>
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

On Thu, Apr 28, 2022 at 09:20:15PM +0300, Dmitry Osipenko wrote:
> 27.04.2022 18:03, Daniel Vetter wrote:
> >> ...
> >>>> @@ -172,6 +172,41 @@ struct drm_gem_object_funcs {
> >>>> =A0=A0=A0=A0=A0=A0 * This is optional but necessary for mmap support.
> >>>> =A0=A0=A0=A0=A0=A0 */
> >>>> =A0=A0=A0=A0=A0 const struct vm_operations_struct *vm_ops;
> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @purge:
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * Releases the GEM object's allocated backing storage =
to the
> >>>> system.
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * Returns the number of pages that have been freed by =
purging
> >>>> the GEM object.
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * This callback is used by the GEM shrinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 unsigned long (*purge)(struct drm_gem_object *obj);
> > =

> > Hm I feel like drivers shouldn't need to know the difference here?
> > =

> > Like shmem helpers can track what's purgeable, and for eviction/purging
> > the driver callback should do the same?
> > =

> > The only difference is when we try to re-reserve the backing storage. W=
hen
> > the object has been evicted that should suceed, but when the object is
> > purged that will fail.
> > =

> > That's the difference between evict and purge for drivers?
> =

> When buffer is purged, we can permanently release the backing storage
> and the reserved IOV space, re-using the freed space by new BOs.
> =

> When buffer is evicted, the BO's IOV should be kept reserved and the
> re-reservation of the backing storage should succeed.

Yeah but what's the difference for driver callbacks? In both cases the
driver callback needs to tear down gpu mappings and pagetables. The only
difference happens after that in the shmem helper: For purge we ditch the
shmem object, for evict we keep it. Drivers shouldn't need to care about
that difference, hence why the two callbacks?

> =

> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @evict:
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * Unpins the GEM object's allocated backing storage, a=
llowing
> >>>> shmem pages
> >>>> +=A0=A0=A0=A0 * to be swapped out.
> >>>
> >>> What's the difference to the existing unpin() callback?
> >>
> >> Drivers need to do more than just unpinning pages when GEMs are evicte=
d.
> >> Unpinning is only a part of the eviction process. I'll improve the
> >> doc-comment in v5.
> >>
> >> For example, for VirtIO-GPU driver we need to to detach host from the
> >> guest's memory before pages are evicted [1].
> >>
> >> [1]
> >> https://gitlab.collabora.com/dmitry.osipenko/linux-kernel-rd/-/blob/93=
2eb03198bce3a21353b09ab71e95f1c19b84c2/drivers/gpu/drm/virtio/virtgpu_objec=
t.c#L145
> >>
> >> In case of Panfrost driver, we will need to remove mappings before pag=
es
> >> are evicted.
> > =

> > It might be good to align this with ttm, otoh that all works quite a bit
> > differently for ttm since ttm supports buffer moves and a lot more fancy
> > stuff.
> > =

> > I'm bringing this up since I have this fancy idea that eventually we co=
uld
> > glue shmem helpers into ttm in some cases for managing buffers when they
> > sit in system memory (as opposed to vram).
> =

> I'll take a look at ttm for v6.
> =

> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * Returns the number of pages that have been unpinned.
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * This callback is used by the GEM shrinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 unsigned long (*evict)(struct drm_gem_object *obj);
> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @swap_in:
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * Pins GEM object's allocated backing storage if it was
> >>>> previously evicted,
> >>>> +=A0=A0=A0=A0 * moving swapped out pages back to memory.
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * Returns 0 on success, or -errno on error.
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * This callback is used by the GEM shrinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 int (*swap_in)(struct drm_gem_object *obj);
> >>>
> >>> Why do you need swap_in()? This can be done on-demand as part of a pin
> >>> or vmap operation.
> >>
> >> Similarly to the unpinning, the pining of pages is only a part of what
> >> needs to be done for GPU drivers. Besides of returning pages back to
> >> memory, we also need to make them accessible to GPU and this is a
> >> driver-specific process. This why we need the additional callbacks.
> > =

> > This is a bit much midlayer. The way this works in ttm is you reserve a=
ll
> > the objects you need (which makes sure they're physically available
> > again), and then the driver goes through and makes sure the page tables
> > are all set up again.
> > =

> > Once you get towards gpu vm that's really the only approach, since your
> > swap_in has no idea for which vm it needs to restore pagetables (and
> > restoring it for all is a bit meh).
> > =

> > If drivers want to optimize this they can adjust/set any tracking
> > information from their evict callback as needed.
> =

> In practice, majority of BOs have only one mapping. Only shared BOs
> usually have extra mappings and shared BOs aren't evictable.

That seems like a fairly arbitrary limitations, and e.g. i915 doesn't have
this limitation, and also has a shrinker. I don't think it should be built
into the design.

> When memory pages are gone, then all the GPU mappings also should be
> gone. Perhaps it's indeed won't be a bad idea to move out the restoring
> of h/w VMs from the swap_in() and make drivers to handle the restoring
> by themselves, so swap_in() will be only about restoring the pages. I'll
> try to improve it in v6.

Sounds good.
-Daniel

> =

> >>>> =A0 };
> >>>> =A0 =A0 /**
> >>>> diff --git a/include/drm/drm_gem_shmem_helper.h
> >>>> b/include/drm/drm_gem_shmem_helper.h
> >>>> index 70889533962a..a65557b446e6 100644
> >>>> --- a/include/drm/drm_gem_shmem_helper.h
> >>>> +++ b/include/drm/drm_gem_shmem_helper.h
> >>>> @@ -6,6 +6,7 @@
> >>>> =A0 #include <linux/fs.h>
> >>>> =A0 #include <linux/mm.h>
> >>>> =A0 #include <linux/mutex.h>
> >>>> +#include <linux/shrinker.h>
> >>>> =A0 =A0 #include <drm/drm_file.h>
> >>>> =A0 #include <drm/drm_gem.h>
> >>>> @@ -15,8 +16,18 @@
> >>>> =A0 struct dma_buf_attachment;
> >>>> =A0 struct drm_mode_create_dumb;
> >>>> =A0 struct drm_printer;
> >>>> +struct drm_device;
> >>>> =A0 struct sg_table;
> >>>> =A0 +enum drm_gem_shmem_pages_state {
> >>>> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_PURGED =3D -2,
> >>>> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_EVICTED =3D -1,
> >>>> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_UNPINNED =3D 0,
> >>>> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_PINNED =3D 1,
> >>>> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_EVICTABLE =3D 2,
> >>>> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE =3D 3,
> >>>> +};
> >>>
> >>> These states can be detected by looking at the vmap and pin refcounts.
> >>> No need to store them explicitly.
> >>
> >> I'll try to revisit this, but I was finding that it's much more
> >> difficult to follow and debug code without the explicit states.
> > =

> > purgeable/purged needs some state, but pinned shouldn't be duplicated, =
so
> > I concur here a bit.
> > =

> >>> In your patch, they also come with a
> >>> big zoo of trivial helpers. None of that seems necessary AFAICT.
> >>
> >> There are couple functions which could be squashed, although this may
> >> hurt readability of the code a tad. I'll try to take another look at
> >> this for v5.
> >>
> >>> What's the difference between purge and evict BTW?
> >>
> >> The evicted pages are moved out from memory to a SWAP partition or fil=
e.
> >>
> >> The purged pages are destroyed permanently.
> >>
> >>>> +
> >>>> =A0 /**
> >>>> =A0=A0 * struct drm_gem_shmem_object - GEM object backed by shmem
> >>>> =A0=A0 */
> >>>> @@ -43,8 +54,8 @@ struct drm_gem_shmem_object {
> >>>> =A0=A0=A0=A0=A0=A0 * @madv: State for madvise
> >>>> =A0=A0=A0=A0=A0=A0 *
> >>>> =A0=A0=A0=A0=A0=A0 * 0 is active/inuse.
> >>>> +=A0=A0=A0=A0 * 1 is not-needed/can-be-purged
> >>>> =A0=A0=A0=A0=A0=A0 * A negative value is the object is purged.
> >>>> -=A0=A0=A0=A0 * Positive values are driver specific and not used by =
the helpers.
> >>>> =A0=A0=A0=A0=A0=A0 */
> >>>> =A0=A0=A0=A0=A0 int madv;
> >>>> =A0 @@ -91,6 +102,40 @@ struct drm_gem_shmem_object {
> >>>> =A0=A0=A0=A0=A0=A0 * @map_wc: map object write-combined (instead of =
using shmem
> >>>> defaults).
> >>>> =A0=A0=A0=A0=A0=A0 */
> >>>> =A0=A0=A0=A0=A0 bool map_wc;
> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @eviction_disable_count:
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * The shmem pages are disallowed to be evicted by the =
memory
> >>>> shrinker
> >>>> +=A0=A0=A0=A0 * while count is non-zero. Used internally by memory s=
hrinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 unsigned int eviction_disable_count;
> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @purging_disable_count:
> >>>> +=A0=A0=A0=A0 *
> >>>> +=A0=A0=A0=A0 * The shmem pages are disallowed to be purged by the m=
emory
> >>>> shrinker
> >>>> +=A0=A0=A0=A0 * while count is non-zero. Used internally by memory s=
hrinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 unsigned int purging_disable_count;
> > =

> > What are these disable counts for?
> =

> Some of BO types should stay pinned permanently, this applies to both
> VirtIO and Panfrost drivers that make use of the generic shrinker in
> this patchset. Hence I made objects unpurgeable and unevictable by defaul=
t.
> =

> Initially the idea of these counts was to allow drivers to explicitly
> disable purging and eviction, and do it multiple times. If driver
> disables eviction in two different places in the code, then we need to
> track the eviction-disable count.
> =

> In the v5 of this patchset drivers don't need to explicitly disable
> shrinking anymore, they only need to enable it. The counts are also used
> internally by DRM SHMEM core to track the vmappings and pinnings, but
> perhaps pages_use_count could be used for that instead. I'll revisit it
> for v6.
> =

> > The way purgeable works in other drivers is that userspace sets purgeab=
le
> > or not, and it's up to userspace to not make a mess of this.
> > =

> > There's also some interactions, and I guess a bunch of drivers get this
> > wrong in funny ways. Not sure how to best clean this up.
> > =

> > - Once you have a shrinker/dynamic memory management you should _not_ p=
in
> >   pages, except when it's truly permanent like for scanout. Instead
> >   drivers should attach dma_fence to the dma_resv to denote in-flight
> >   access.
> =

> By default pages are pinned when drm_gem_shmem_get_pages_sgt() is
> invoked by drivers during of BO creation time.
> =

> We could declare that pages_use_count=3D1 means the pages are allowed to
> be evicted and purged if shrinker is enabled. Then the further
> drm_gem_shmem_pin/vmap() calls will bump the pages_use_count,
> disallowing the eviction and purging, like you're suggesting, and we
> won't need the explicit counts.
> =

> > - A pinned buffer object is not allowed to be put into purgeable state,
> >   and a bo in purgeable state should not be allowed to be pinned.
> > =

> > - Drivers need to hold dma_resv_lock for long enough in their command
> >   submission, i.e. from the point where the reserve the buffers and make
> >   sure that mappings exists, to the point where the request is submitted
> >   to hw or drm/sched and fences are installed.
> > =

> > But I think a lot of current shmem users just pin as part of execbuf, so
> > this won't work quite so well right out of the box.
> =

> The current shmem users assume that BO is pinned permanently once it has
> been created.
> =

> > Anyway with that design I don't think there should ever be a need to
> > disable shrinking.
> =

> To me what you described mostly matches to what I did in the v5.
> =

> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @pages_state: Current state of shmem pages. Used int=
ernally by
> >>>> +=A0=A0=A0=A0 * memory shrinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 enum drm_gem_shmem_pages_state pages_state;
> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @evicted: True if shmem pages were evicted by the me=
mory
> >>>> shrinker.
> >>>> +=A0=A0=A0=A0 * Used internally by memory shrinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 bool evicted;
> >>>> +
> >>>> +=A0=A0=A0 /**
> >>>> +=A0=A0=A0=A0 * @pages_shrinkable: True if shmem pages can be evicte=
d or purged
> >>>> +=A0=A0=A0=A0 * by the memory shrinker. Used internally by memory sh=
rinker.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 bool pages_shrinkable;
> >>>
> >>> As commented before, this state can be foundby looking at existing
> >>> fields. No need to store it separately.
> >>
> >> When we're transitioning from "evictable" to a "purgeable" state, we
> >> must not add pages twice to the "shrinkable_count" variable. Hence this
> >> is not a state, but a variable which prevents the double accounting of
> >> the pages. Please see drm_gem_shmem_add_pages_to_shrinker() in this pa=
tch.
> >>
> >> Perhaps something like "pages_accounted_by_shrinker" could be a better
> >> name for the variable. I'll revisit this for v5.
> > =

> > Hm not sure we need to account this? Usually the shrinker just counts w=
hen
> > it's asked to do so, not practively maintain that count. Once you start
> > shrinking burning cpu time is generally not too terrible.
> =

> We could count pages on demand by walking up the "evictable" list, but
> then the shrinker's lock needs to be taken by the
> drm_gem_shmem_shrinker_count_objects() to protect the list.
> =

> Previously Rob Clark said that the profiling of freedreno's shrinker
> showed that it's worthwhile to reduce the locks as much as possible,
> including the case of counting shrinkable objects.

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
