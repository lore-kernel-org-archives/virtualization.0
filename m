Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E4C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 15:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A316183DF1;
	Wed, 27 Apr 2022 15:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oLVY3Tif2o-o; Wed, 27 Apr 2022 15:04:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D47583280;
	Wed, 27 Apr 2022 15:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A3DC0039;
	Wed, 27 Apr 2022 15:04:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89DA0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 637C560B3D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZoK2zFW5Z36x
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:04:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2B1A60B3B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:04:02 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id y3so3951361ejo.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=9Itb0glNjLzsda2ha8Sg4vczWB8285tOkwDDoPJtWk8=;
 b=L0ydeR/2rcnWI7IC+FLalVfL5PrFO0wiIWSUmlTuFGoqbiX1PxEDzpqqF8NOitaTY6
 AJe7ePcHH60qzdiVbDk5gPhR2BTMdXJa4EMexGYPsLBdmg3Zf13+4BOSifpxn4jxBlhr
 UUzhzaqaeNoaNq7RaJ1t2XVN42jf1+tQKcmpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=9Itb0glNjLzsda2ha8Sg4vczWB8285tOkwDDoPJtWk8=;
 b=nsP3HBlUztE41AShMPYk042gjPU8rgw53rbUpqQ60WAl7NC+35a3U00IqFkOhVBRjr
 nGtMPlu3mJAW4tJSmmWQpqkFlamV6w92nu91cTOo+VNzJBcZsbD+dQ2PQOKYxB91RlWt
 HoerP6soUGOeCXPXzDXf+XmJbYkTVzOBuzS5kX2XOITP/4wJsABRk7Q601HVLoGc+q3Q
 IDXa7svDANcwOHcWcfICDrI95OcUt7oe2q8QfxVFq7UdsOdnCoglntVeunxQgZW+FdC3
 ibp8r3IyhTTkpNXWUzlGC/R0+VuImdGntbbTL5Afv4aUGS7KFF66ot9y4SooFEf25ECK
 xa5A==
X-Gm-Message-State: AOAM532qzOEXSzZH0rTT9/OFmfl95kiopvGER+tngxiCdxlRAD2WxUrF
 uKzyJoOZB0hRK83pcw/C0YOMXg==
X-Google-Smtp-Source: ABdhPJxn3J1YOjf7N2ftgkiOzZwCbB1eDMKJ2IPMJQ0cUJ4r8LLbOyG5qJSje406PmcIBG+D3tyDog==
X-Received: by 2002:a17:907:2daa:b0:6da:924e:955 with SMTP id
 gt42-20020a1709072daa00b006da924e0955mr26796476ejc.1.1651071841010; 
 Wed, 27 Apr 2022 08:04:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a170906124600b006e843964f9asm6811575eja.55.2022.04.27.08.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 08:04:00 -0700 (PDT)
Date: Wed, 27 Apr 2022 17:03:58 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
Message-ID: <YmlbXoeaVds/bjYn@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f497f99-f4c1-33d6-46cf-95bd90188fe3@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Tue, Apr 19, 2022 at 11:40:41PM +0300, Dmitry Osipenko wrote:
> On 4/19/22 10:22, Thomas Zimmermann wrote:
> > Hi
> > =

> > Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
> >> Introduce a common DRM SHMEM shrinker. It allows to reduce code
> >> duplication among DRM drivers that implement theirs own shrinkers.
> >> This is initial version of the shrinker that covers basic needs of
> >> GPU drivers, both purging and eviction of shmem objects are supported.
> >>
> >> This patch is based on a couple ideas borrowed from Rob's Clark MSM
> >> shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
> >>
> >> In order to start using DRM SHMEM shrinker drivers should:
> >>
> >> 1. Implement new purge(), evict() + swap_in() GEM callbacks.
> >> 2. Register shrinker using drm_gem_shmem_shrinker_register(drm_device).
> >> 3. Use drm_gem_shmem_set_purgeable_and_evictable(shmem) and alike API
> >> =A0=A0=A0 functions to activate shrinking of GEMs.
> >>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >> =A0 drivers/gpu/drm/drm_gem_shmem_helper.c | 765 +++++++++++++++++++++=
+++-
> >> =A0 include/drm/drm_device.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0=A0 4 +
> >> =A0 include/drm/drm_gem.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 35 ++
> >> =A0 include/drm/drm_gem_shmem_helper.h=A0=A0=A0=A0 | 105 +++-
> >> =A0 4 files changed, 877 insertions(+), 32 deletions(-)
> ...
> >> @@ -172,6 +172,41 @@ struct drm_gem_object_funcs {
> >> =A0=A0=A0=A0=A0=A0 * This is optional but necessary for mmap support.
> >> =A0=A0=A0=A0=A0=A0 */
> >> =A0=A0=A0=A0=A0 const struct vm_operations_struct *vm_ops;
> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @purge:
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * Releases the GEM object's allocated backing storage to=
 the
> >> system.
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * Returns the number of pages that have been freed by pu=
rging
> >> the GEM object.
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * This callback is used by the GEM shrinker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 unsigned long (*purge)(struct drm_gem_object *obj);

Hm I feel like drivers shouldn't need to know the difference here?

Like shmem helpers can track what's purgeable, and for eviction/purging
the driver callback should do the same?

The only difference is when we try to re-reserve the backing storage. When
the object has been evicted that should suceed, but when the object is
purged that will fail.

That's the difference between evict and purge for drivers?

> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @evict:
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * Unpins the GEM object's allocated backing storage, all=
owing
> >> shmem pages
> >> +=A0=A0=A0=A0 * to be swapped out.
> > =

> > What's the difference to the existing unpin() callback?
> =

> Drivers need to do more than just unpinning pages when GEMs are evicted.
> Unpinning is only a part of the eviction process. I'll improve the
> doc-comment in v5.
> =

> For example, for VirtIO-GPU driver we need to to detach host from the
> guest's memory before pages are evicted [1].
> =

> [1]
> https://gitlab.collabora.com/dmitry.osipenko/linux-kernel-rd/-/blob/932eb=
03198bce3a21353b09ab71e95f1c19b84c2/drivers/gpu/drm/virtio/virtgpu_object.c=
#L145
> =

> In case of Panfrost driver, we will need to remove mappings before pages
> are evicted.

It might be good to align this with ttm, otoh that all works quite a bit
differently for ttm since ttm supports buffer moves and a lot more fancy
stuff.

I'm bringing this up since I have this fancy idea that eventually we could
glue shmem helpers into ttm in some cases for managing buffers when they
sit in system memory (as opposed to vram).

> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * Returns the number of pages that have been unpinned.
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * This callback is used by the GEM shrinker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 unsigned long (*evict)(struct drm_gem_object *obj);
> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @swap_in:
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * Pins GEM object's allocated backing storage if it was
> >> previously evicted,
> >> +=A0=A0=A0=A0 * moving swapped out pages back to memory.
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * Returns 0 on success, or -errno on error.
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * This callback is used by the GEM shrinker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 int (*swap_in)(struct drm_gem_object *obj);
> > =

> > Why do you need swap_in()? This can be done on-demand as part of a pin
> > or vmap operation.
> =

> Similarly to the unpinning, the pining of pages is only a part of what
> needs to be done for GPU drivers. Besides of returning pages back to
> memory, we also need to make them accessible to GPU and this is a
> driver-specific process. This why we need the additional callbacks.

This is a bit much midlayer. The way this works in ttm is you reserve all
the objects you need (which makes sure they're physically available
again), and then the driver goes through and makes sure the page tables
are all set up again.

Once you get towards gpu vm that's really the only approach, since your
swap_in has no idea for which vm it needs to restore pagetables (and
restoring it for all is a bit meh).

If drivers want to optimize this they can adjust/set any tracking
information from their evict callback as needed.

> =

> >> =A0 };
> >> =A0 =A0 /**
> >> diff --git a/include/drm/drm_gem_shmem_helper.h
> >> b/include/drm/drm_gem_shmem_helper.h
> >> index 70889533962a..a65557b446e6 100644
> >> --- a/include/drm/drm_gem_shmem_helper.h
> >> +++ b/include/drm/drm_gem_shmem_helper.h
> >> @@ -6,6 +6,7 @@
> >> =A0 #include <linux/fs.h>
> >> =A0 #include <linux/mm.h>
> >> =A0 #include <linux/mutex.h>
> >> +#include <linux/shrinker.h>
> >> =A0 =A0 #include <drm/drm_file.h>
> >> =A0 #include <drm/drm_gem.h>
> >> @@ -15,8 +16,18 @@
> >> =A0 struct dma_buf_attachment;
> >> =A0 struct drm_mode_create_dumb;
> >> =A0 struct drm_printer;
> >> +struct drm_device;
> >> =A0 struct sg_table;
> >> =A0 +enum drm_gem_shmem_pages_state {
> >> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_PURGED =3D -2,
> >> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_EVICTED =3D -1,
> >> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_UNPINNED =3D 0,
> >> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_PINNED =3D 1,
> >> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_EVICTABLE =3D 2,
> >> +=A0=A0=A0 DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE =3D 3,
> >> +};
> > =

> > These states can be detected by looking at the vmap and pin refcounts.
> > No need to store them explicitly.
> =

> I'll try to revisit this, but I was finding that it's much more
> difficult to follow and debug code without the explicit states.

purgeable/purged needs some state, but pinned shouldn't be duplicated, so
I concur here a bit.

> > In your patch, they also come with a
> > big zoo of trivial helpers. None of that seems necessary AFAICT.
> =

> There are couple functions which could be squashed, although this may
> hurt readability of the code a tad. I'll try to take another look at
> this for v5.
> =

> > What's the difference between purge and evict BTW?
> =

> The evicted pages are moved out from memory to a SWAP partition or file.
> =

> The purged pages are destroyed permanently.
> =

> >> +
> >> =A0 /**
> >> =A0=A0 * struct drm_gem_shmem_object - GEM object backed by shmem
> >> =A0=A0 */
> >> @@ -43,8 +54,8 @@ struct drm_gem_shmem_object {
> >> =A0=A0=A0=A0=A0=A0 * @madv: State for madvise
> >> =A0=A0=A0=A0=A0=A0 *
> >> =A0=A0=A0=A0=A0=A0 * 0 is active/inuse.
> >> +=A0=A0=A0=A0 * 1 is not-needed/can-be-purged
> >> =A0=A0=A0=A0=A0=A0 * A negative value is the object is purged.
> >> -=A0=A0=A0=A0 * Positive values are driver specific and not used by th=
e helpers.
> >> =A0=A0=A0=A0=A0=A0 */
> >> =A0=A0=A0=A0=A0 int madv;
> >> =A0 @@ -91,6 +102,40 @@ struct drm_gem_shmem_object {
> >> =A0=A0=A0=A0=A0=A0 * @map_wc: map object write-combined (instead of us=
ing shmem
> >> defaults).
> >> =A0=A0=A0=A0=A0=A0 */
> >> =A0=A0=A0=A0=A0 bool map_wc;
> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @eviction_disable_count:
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * The shmem pages are disallowed to be evicted by the me=
mory
> >> shrinker
> >> +=A0=A0=A0=A0 * while count is non-zero. Used internally by memory shr=
inker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 unsigned int eviction_disable_count;
> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @purging_disable_count:
> >> +=A0=A0=A0=A0 *
> >> +=A0=A0=A0=A0 * The shmem pages are disallowed to be purged by the mem=
ory
> >> shrinker
> >> +=A0=A0=A0=A0 * while count is non-zero. Used internally by memory shr=
inker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 unsigned int purging_disable_count;

What are these disable counts for?

The way purgeable works in other drivers is that userspace sets purgeable
or not, and it's up to userspace to not make a mess of this.

There's also some interactions, and I guess a bunch of drivers get this
wrong in funny ways. Not sure how to best clean this up.

- Once you have a shrinker/dynamic memory management you should _not_ pin
  pages, except when it's truly permanent like for scanout. Instead
  drivers should attach dma_fence to the dma_resv to denote in-flight
  access.

- A pinned buffer object is not allowed to be put into purgeable state,
  and a bo in purgeable state should not be allowed to be pinned.

- Drivers need to hold dma_resv_lock for long enough in their command
  submission, i.e. from the point where the reserve the buffers and make
  sure that mappings exists, to the point where the request is submitted
  to hw or drm/sched and fences are installed.

But I think a lot of current shmem users just pin as part of execbuf, so
this won't work quite so well right out of the box.

Anyway with that design I don't think there should ever be a need to
disable shrinking.

> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @pages_state: Current state of shmem pages. Used inter=
nally by
> >> +=A0=A0=A0=A0 * memory shrinker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 enum drm_gem_shmem_pages_state pages_state;
> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @evicted: True if shmem pages were evicted by the memo=
ry
> >> shrinker.
> >> +=A0=A0=A0=A0 * Used internally by memory shrinker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 bool evicted;
> >> +
> >> +=A0=A0=A0 /**
> >> +=A0=A0=A0=A0 * @pages_shrinkable: True if shmem pages can be evicted =
or purged
> >> +=A0=A0=A0=A0 * by the memory shrinker. Used internally by memory shri=
nker.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 bool pages_shrinkable;
> > =

> > As commented before, this state can be foundby looking at existing
> > fields. No need to store it separately.
> =

> When we're transitioning from "evictable" to a "purgeable" state, we
> must not add pages twice to the "shrinkable_count" variable. Hence this
> is not a state, but a variable which prevents the double accounting of
> the pages. Please see drm_gem_shmem_add_pages_to_shrinker() in this patch.
> =

> Perhaps something like "pages_accounted_by_shrinker" could be a better
> name for the variable. I'll revisit this for v5.

Hm not sure we need to account this? Usually the shrinker just counts when
it's asked to do so, not practively maintain that count. Once you start
shrinking burning cpu time is generally not too terrible.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
