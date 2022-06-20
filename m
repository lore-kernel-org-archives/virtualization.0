Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8C7C433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 15:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38837827C6;
	Mon, 20 Jun 2022 15:18:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38837827C6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qK7K5LcM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eCCoY5OR_GIl; Mon, 20 Jun 2022 15:18:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8987D8278F;
	Mon, 20 Jun 2022 15:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8987D8278F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56A90C0039;
	Mon, 20 Jun 2022 15:18:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47619C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 15:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1225140AEE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 15:18:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1225140AEE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=qK7K5LcM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yRqgzaR6Uq-2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 15:18:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C4BD404D3
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C4BD404D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 15:18:00 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id e25so11268552wrc.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HLrdK2cHg8a+WfynFvGYZTk9JjHbb/Ti/PUAmWDEXmQ=;
 b=qK7K5LcM7dyr13i14ftD313nslG8YxjHQmfv8LjV7Tk1r8ybUhZ5AI0jn5rTqQhgmm
 i59iso5WlVRzUdhMyAPWt7eltJkNSfRGyu0jYjEV010WarFWgUS3zKaSaYaJfYgDz//T
 pid5V6gslaCrjWsjULnAXS530hiyltR47EnpCo8fvT4ma6uRB5F+KGSfmkgW+IZhEhRU
 OHPH8eR5Bncckxj2xyb0u6lbCoknZypydnAtyGNuGpMe8xIqnmVyJNbKWPMhsWl15p7Z
 MAziNE52C7w3j7WtmrVuXvwuEgzAYrB48BIKNyK7u2dralOWnRbA4it6ts7mRM3p0T0z
 PUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HLrdK2cHg8a+WfynFvGYZTk9JjHbb/Ti/PUAmWDEXmQ=;
 b=Eoj7U4FmiSrbB1HuqSfDz4RhJdJeVfKrD1IwGLwFjOvxi4Z3h8+F4KsSaA9seoQc8R
 jNEhu4iQ0BbTWtJLs4LKPl1Lbop+iXru7SM7AB+l9gQ2PwZoFxZJHCQqUxQqLWH7OTIu
 NYzHZZg9p3snRO4kjt7lHlHIr8yYMtw3mKSvQul7KPMuwVa04NR3WBNdBz0fNXQOZfmx
 XR7FDG5+b4AHJs8+9vXpwZ38yHlLwZbyEe137nVkbpzd/M4Yt+2yl1FdHq3eLcXQtgKV
 lheqTzAdrP/vVEifM+mrsfWfYot5Kii6dbFaUYNb//4gE4ZNNcmaNJOu+gz2+TGwoGoK
 HqRQ==
X-Gm-Message-State: AJIora/7Wf8dJF7+MRm98RrW80Z5JLImJ2OU6Qtq+QhPGGchL3vsBLlX
 KMhOTdbeE+SfblNwZQLmD5OmZkmG1FJ4ikMeBYA=
X-Google-Smtp-Source: AGRyM1uYeX1HSZm/HHpeWSpFPQwaEg25u16yH1bR8gO/m6+hhlHkAUqlKQD3fntq2L6SbV4iQSzZCmeHt3/fGRnXHoE=
X-Received: by 2002:adf:eb45:0:b0:21a:efae:4b9f with SMTP id
 u5-20020adfeb45000000b0021aefae4b9fmr17379320wrn.585.1655738278721; Mon, 20
 Jun 2022 08:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-18-dmitry.osipenko@collabora.com>
 <CAF6AEGt61t2truYDCxm17hqUPV-UdEdHjLs+6vmj5RPoPuVBYg@mail.gmail.com>
 <3bb3dc53-69fc-8cdb-ae37-583b9b2660a3@collabora.com>
In-Reply-To: <3bb3dc53-69fc-8cdb-ae37-583b9b2660a3@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 20 Jun 2022 08:18:04 -0700
Message-ID: <CAF6AEGus7R_i7RMWGmbawVi62xCk5mhLTWGq2QEkcWY+XaJBAQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/22] drm/shmem-helper: Add generic memory shrinker
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Thierry Reding <thierry.reding@gmail.com>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Jun 20, 2022 at 7:09 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 6/19/22 20:53, Rob Clark wrote:
> ...
> >> +static unsigned long
> >> +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
> >> +                                    struct shrink_control *sc)
> >> +{
> >> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
> >> +       struct drm_gem_shmem_object *shmem;
> >> +       unsigned long count = 0;
> >> +
> >> +       if (!mutex_trylock(&gem_shrinker->lock))
> >> +               return 0;
> >> +
> >> +       list_for_each_entry(shmem, &gem_shrinker->lru_evictable, madv_list) {
> >> +               count += shmem->base.size;
> >> +
> >> +               if (count >= SHRINK_EMPTY)
> >> +                       break;
> >> +       }
> >> +
> >> +       mutex_unlock(&gem_shrinker->lock);
> >
> > As I mentioned on other thread, count_objects, being approximate but
> > lockless and fast is the important thing.  Otherwise when you start
> > hitting the shrinker on many threads, you end up serializing them all,
> > even if you have no pages to return to the system at that point.
>
> Daniel's point for dropping the lockless variant was that we're already
> in trouble if we're hitting shrinker too often and extra optimizations
> won't bring much benefits to us.

At least with zram swap (which I highly recommend using even if you
are not using a physical swap file/partition), swapin/out is actually
quite fast.  And if you are leaning on zram swap to fit 8GB of chrome
browser on a 4GB device, the shrinker gets hit quite a lot.  Lower
spec (4GB RAM) chromebooks can be under constant memory pressure and
can quite easily get into a situation where you are hitting the
shrinker on many threads simultaneously.  So it is pretty important
for all shrinkers in the system (not just drm driver) to be as
concurrent as possible.  As long as you avoid serializing reclaim on
all the threads, performance can still be quite good, but if you don't
performance will fall off a cliff.

jfwiw, we are seeing pretty good results (iirc 40-70% increase in open
tab counts) with the combination of eviction + multigen LRU[1] +
sizing zram swap to be 2x physical RAM

[1] https://lwn.net/Articles/856931/

> Alright, I'll add back the lockless variant (or will use yours
> drm_gem_lru) in the next revision. The code difference is very small
> after all.
>
> ...
> >> +               /* prevent racing with the dma-buf importing/exporting */
> >> +               if (!mutex_trylock(&gem_shrinker->dev->object_name_lock)) {
> >> +                       *lock_contention |= true;
> >> +                       goto resv_unlock;
> >> +               }
> >
> > I'm not sure this is a good idea to serialize on object_name_lock.
> > Purgeable buffers should never be shared (imported or exported).  So
> > at best you are avoiding evicting and immediately swapping back in, in
> > a rare case, at the cost of serializing multiple threads trying to
> > reclaim pages in parallel.
>
> The object_name_lock shouldn't cause contention in practice. But objects
> are also pinned on attachment, hence maybe this lock is indeed
> unnecessary.. I'll re-check it.

I'm not worried about contention with export/import/etc, but
contention between multiple threads hitting the shrinker in parallel.
I guess since you are using trylock, it won't *block* the other
threads hitting shrinker, but they'll just end up looping in
do_shrink_slab() because they are hitting contention.

I'd have to do some experiments to see how it works out in practice,
but my gut feel is that it isn't a good idea

BR,
-R

> --
> Best regards,
> Dmitry
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
