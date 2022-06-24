Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0450C433EF
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 20:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BB2C611DB;
	Fri, 24 Jun 2022 20:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BB2C611DB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=VYViBvea
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Dw5xX9s_g24; Fri, 24 Jun 2022 20:23:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ECDE4611CF;
	Fri, 24 Jun 2022 20:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECDE4611CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5515C0039;
	Fri, 24 Jun 2022 20:23:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7BA6C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 20:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7439C849D5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 20:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7439C849D5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=VYViBvea
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6B5WQ_FP3CJc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 20:23:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01FFE83E8B
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01FFE83E8B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 20:23:53 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id eq6so4974270edb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=rM6StsZ/3rmWNZ6eG3nFC9QNenxnUOTVwI/HAfEm2EQ=;
 b=VYViBveaMX2iHovNjImE8ft1aL8oby/bDvJodcDA4y4Eo+tutY1hGinHsM3aKTvLEE
 UKfzf6+eCMmxZ49Ku37S9pc+tHn/uh5pXrCXh3E8Ggw/FSYRFeIyB8RDclfGgyvtHmNh
 MqpcvSiLK6jgmcJHZD8u3uLJ1nBF6f8mOUmtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=rM6StsZ/3rmWNZ6eG3nFC9QNenxnUOTVwI/HAfEm2EQ=;
 b=o9HMZI7UDCYLecvSt4lNCDVLpkBEOE9P7+n+dKPltuAT5FlV4EEbBrS8WSrqagBMFn
 pF7vZMTfG6btqyY7a93R5WxI7SDT6Qjry0s0HqKxILXKrkdW4SBWPS9BbWqgppDF5Qr3
 /lW88vy5zNonw2dTy7l3LuRkgbafCzYhwcQHZRb0bhkceuuAzFQAv50Nzv+ztGmhzJLz
 5dyiDcFUzT4uwfQx4Fh+R8Pjf1dkig42rCW+t71Zd/xn0G7/r7ZeeHkTEBdcjOXLZXXQ
 /02rzLTnjLb+QZkVfQ3CwQPSCKGuP6eT12bJS1nxxnNaOn6USDQfg+EecC7ifnNeRERH
 7tsA==
X-Gm-Message-State: AJIora/KDnLf7mxQrO+HufjHTwOCWwfgx85VKg8CJiO176MBwC1lWECZ
 D1zJIK45dj+H8Pi1gJq0Y5OhIw==
X-Google-Smtp-Source: AGRyM1uJnErMjUto5d2AkMD9qcjjZpgW235kvjYxoK3tSLlU8a0umCcexISHAvYdIuLK226BGQhyeA==
X-Received: by 2002:a05:6402:4248:b0:435:9150:ccfb with SMTP id
 g8-20020a056402424800b004359150ccfbmr1101365edb.374.1656102232134; 
 Fri, 24 Jun 2022 13:23:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 z23-20020a170906435700b007094f98788csm1630637ejm.113.2022.06.24.13.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 13:23:51 -0700 (PDT)
Date: Fri, 24 Jun 2022 22:23:49 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v6 17/22] drm/shmem-helper: Add generic memory shrinker
Message-ID: <YrYdVRMjK4YS33hO@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Qiang Yu <yuq825@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 kernel@collabora.com
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-18-dmitry.osipenko@collabora.com>
 <CAF6AEGt61t2truYDCxm17hqUPV-UdEdHjLs+6vmj5RPoPuVBYg@mail.gmail.com>
 <3bb3dc53-69fc-8cdb-ae37-583b9b2660a3@collabora.com>
 <CAF6AEGus7R_i7RMWGmbawVi62xCk5mhLTWGq2QEkcWY+XaJBAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGus7R_i7RMWGmbawVi62xCk5mhLTWGq2QEkcWY+XaJBAQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Thierry Reding <thierry.reding@gmail.com>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-media@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, Qiang Yu <yuq825@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Mon, Jun 20, 2022 at 08:18:04AM -0700, Rob Clark wrote:
> On Mon, Jun 20, 2022 at 7:09 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> >
> > On 6/19/22 20:53, Rob Clark wrote:
> > ...
> > >> +static unsigned long
> > >> +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
> > >> +                                    struct shrink_control *sc)
> > >> +{
> > >> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
> > >> +       struct drm_gem_shmem_object *shmem;
> > >> +       unsigned long count = 0;
> > >> +
> > >> +       if (!mutex_trylock(&gem_shrinker->lock))
> > >> +               return 0;
> > >> +
> > >> +       list_for_each_entry(shmem, &gem_shrinker->lru_evictable, madv_list) {
> > >> +               count += shmem->base.size;
> > >> +
> > >> +               if (count >= SHRINK_EMPTY)
> > >> +                       break;
> > >> +       }
> > >> +
> > >> +       mutex_unlock(&gem_shrinker->lock);
> > >
> > > As I mentioned on other thread, count_objects, being approximate but
> > > lockless and fast is the important thing.  Otherwise when you start
> > > hitting the shrinker on many threads, you end up serializing them all,
> > > even if you have no pages to return to the system at that point.
> >
> > Daniel's point for dropping the lockless variant was that we're already
> > in trouble if we're hitting shrinker too often and extra optimizations
> > won't bring much benefits to us.
> 
> At least with zram swap (which I highly recommend using even if you
> are not using a physical swap file/partition), swapin/out is actually
> quite fast.  And if you are leaning on zram swap to fit 8GB of chrome
> browser on a 4GB device, the shrinker gets hit quite a lot.  Lower
> spec (4GB RAM) chromebooks can be under constant memory pressure and
> can quite easily get into a situation where you are hitting the
> shrinker on many threads simultaneously.  So it is pretty important
> for all shrinkers in the system (not just drm driver) to be as
> concurrent as possible.  As long as you avoid serializing reclaim on
> all the threads, performance can still be quite good, but if you don't
> performance will fall off a cliff.
> 
> jfwiw, we are seeing pretty good results (iirc 40-70% increase in open
> tab counts) with the combination of eviction + multigen LRU[1] +
> sizing zram swap to be 2x physical RAM
> 
> [1] https://lwn.net/Articles/856931/
> 
> > Alright, I'll add back the lockless variant (or will use yours
> > drm_gem_lru) in the next revision. The code difference is very small
> > after all.
> >
> > ...
> > >> +               /* prevent racing with the dma-buf importing/exporting */
> > >> +               if (!mutex_trylock(&gem_shrinker->dev->object_name_lock)) {
> > >> +                       *lock_contention |= true;
> > >> +                       goto resv_unlock;
> > >> +               }
> > >
> > > I'm not sure this is a good idea to serialize on object_name_lock.
> > > Purgeable buffers should never be shared (imported or exported).  So
> > > at best you are avoiding evicting and immediately swapping back in, in
> > > a rare case, at the cost of serializing multiple threads trying to
> > > reclaim pages in parallel.
> >
> > The object_name_lock shouldn't cause contention in practice. But objects
> > are also pinned on attachment, hence maybe this lock is indeed
> > unnecessary.. I'll re-check it.
> 
> I'm not worried about contention with export/import/etc, but
> contention between multiple threads hitting the shrinker in parallel.
> I guess since you are using trylock, it won't *block* the other
> threads hitting shrinker, but they'll just end up looping in
> do_shrink_slab() because they are hitting contention.
> 
> I'd have to do some experiments to see how it works out in practice,
> but my gut feel is that it isn't a good idea

Yeah trylock on anything else than the object lock is No Good in the
shrinker. And it really shouldn't be needed, since import/export should
pin stuff as needed. Which should be protected by the dma_resv object
lock. If not, we need to fix that.

Picking a random drm-internal lock like this is definitely no good design.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
