Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17CAC433F5
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 13:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83FEE813C5;
	Mon,  9 May 2022 13:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcD-vGm_UKhE; Mon,  9 May 2022 13:42:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE52C813B7;
	Mon,  9 May 2022 13:42:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 948C4C0032;
	Mon,  9 May 2022 13:42:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F770C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 13:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAA9F813B8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 13:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXMy0koL3Fxi
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 13:42:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D073813B7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 13:42:47 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id gh6so26967178ejb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 May 2022 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=Sw3X1IvartbYB0KHGJUY3ruuCDgguNnfxUDPf/paEoU=;
 b=Fp0TOFfXdyZrX9kqJ6ScQKvNpL2ENEpXFErSYpxZlrX/BXE/UgQATPXsLqrOxLVvGt
 gd59SZ9ejyuZuxhAhU1QtI2W4oMGnB2C92SW9k256cGT4MQ5hBzN2BRPLPDT0ecKzgVD
 UP0N6xAPTvW37XoT039JILqFu00XvZyAC5JUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=Sw3X1IvartbYB0KHGJUY3ruuCDgguNnfxUDPf/paEoU=;
 b=gjnr/PeCnQwsfl07r32MDx0AHMNktga+axkS+WywD0TGWlz6A8ZpWCS+3ph9mXoAlk
 VeXrd3p2RDS6u7hvCSBo2h3TvxzvjgS2VTPD1XFOea/MTnr1Xlvq+FEcK5D/QbTRvUWm
 AVZfKF3nmEVf5q7W8PZk3UPU85R1Ma1zHHpoBroKRxClPLZZ8jxaPzo1fU4s+DxTVcGn
 h4Ed3IeJcoXisPIMMGSjqmsyApkHzOUy1cBkOVIFXBYWfqeFgFP6MRSpBpJNu7o7CBsI
 +ZMOZKlJg8C7Fn/IVLPYUiOa3ATgMRcJO030ztz5EweW1lUNKuEepweWNNbTtT/3ITTG
 zXQQ==
X-Gm-Message-State: AOAM530E8UCungNw3kdyxo+8wahZ1m8+TQ6Am/+xdciFqj/GuBE0GFQ4
 IvcFZlVS4vqqofeyxbbTqlB9Qw==
X-Google-Smtp-Source: ABdhPJz1+/1GhzO9unpWf/pPYWTjTjoI2gshZAF+/OPndqdsPJfr1TO6/cGn1zz0Lo4HN84e1wqgoA==
X-Received: by 2002:a17:907:7242:b0:6f5:2ca3:f1cd with SMTP id
 ds2-20020a170907724200b006f52ca3f1cdmr13570151ejc.480.1652103765634; 
 Mon, 09 May 2022 06:42:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 j19-20020aa7c0d3000000b004275cef32efsm6327163edp.6.2022.05.09.06.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 06:42:44 -0700 (PDT)
Date: Mon, 9 May 2022 15:42:42 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <YnkaUk0mZNuPsZ5r@phenom.ffwll.local>
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
 <YnOHAh9I1ds4+1J+@phenom.ffwll.local>
 <83e68918-68de-c0c6-6f9b-e94d34b19383@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83e68918-68de-c0c6-6f9b-e94d34b19383@collabora.com>
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

On Fri, May 06, 2022 at 01:49:12AM +0300, Dmitry Osipenko wrote:
> On 5/5/22 11:12, Daniel Vetter wrote:
> > On Wed, May 04, 2022 at 06:56:09PM +0300, Dmitry Osipenko wrote:
> >> On 5/4/22 11:21, Daniel Vetter wrote:
> >> ...
> >>>>> - Maybe also do what you suggest and keep a separate lock for this,=
 but
> >>>>>   the fundamental issue is that this doesn't really work - if you s=
hare
> >>>>>   buffers both ways with two drivers using shmem helpers, then the
> >>>>>   ordering of this vmap_count_mutex vs dma_resv_lock is inconsisten=
t and
> >>>>>   you can get some nice deadlocks. So not a great approach (and als=
o the
> >>>>>   reason why we really need to get everyone to move towards dma_res=
v_lock
> >>>>>   as _the_ buffer object lock, since otherwise we'll never get a
> >>>>>   consistent lock nesting hierarchy).
> >>>>
> >>>> The separate locks should work okay because it will be always the
> >>>> exporter that takes the dma_resv_lock. But I agree that it's less id=
eal
> >>>> than defining the new rules for dma-bufs since sometime you will take
> >>>> the resv lock and sometime not, potentially hiding bugs related to l=
ockings.
> >>>
> >>> That's the issue, some importers need to take the dma_resv_lock for
> >>> dma_buf_vmap too (e.g. to first nail the buffer in place when it's a
> >>> dynamic memory manager). In practice it'll work as well as what we ha=
ve
> >>> currently, which is similarly inconsistent, except with per-driver lo=
cks
> >>> instead of shared locks from shmem helpers or dma-buf, so less obvious
> >>> that things are inconsistent.
> >>>
> >>> So yeah if it's too messy maybe the approach is to have a separate lo=
ck
> >>> for vmap for now, land things, and then fix up dma_buf_vmap in a foll=
ow up
> >>> series.
> >>
> >> The amdgpu driver was the fist who introduced the concept of movable
> >> memory for dma-bufs. Now we want to support it for DRM SHMEM too. For
> >> both amdgpu ttm and shmem drivers we will want to hold the reservation
> >> lock when we're touching moveable buffers. The current way of denoting
> >> that dma-buf is movable is to implement the pin/unpin callbacks of the
> >> dma-buf ops, should be doable for shmem.
> > =

> > Hm that sounds like a bridge too far? I don't think we want to start
> > adding moveable dma-bufs for shmem, thus far at least no one asked for
> > that. Goal here is just to streamline the locking a bit and align across
> > all the different ways of doing buffers in drm.
> > =

> > Or do you mean something else and I'm just completely lost?
> =

> I'm talking about aligning DRM locks with the dma-buf locks. The problem
> is that the convention of dma-bufs isn't specified yet. In particular
> there is no convention for the mapping operations.
> =

> If we want to switch vmapping of shmem to use reservation lock, then
> somebody will have to hold this lock for dma_buf_vmap() and the locking
> convention needs to be specified firmly.

Ah yes that makes sense.

> In case of dynamic buffers, we will also need to specify whether
> dma_buf_vmap() should imply the implicit pinning by exporter or the
> buffer must be pinned explicitly by importer before dma_buf_vmap() is
> invoked.
> =

> Perhaps I indeed shouldn't care about this for this patchset. The
> complete locking model of dma-bufs must be specified first.

Hm I thought vmap is meant to pin itself, and not rely on any other
pinning done already. And from a quick look through the long call chain
for amd (which is currently the only driver supporting dynamic dma-buf)
that seems to be the case.

But yeah the locking isn't specificied yet, and that makes it a bit a mess
:-(

> >> A day ago I found that mapping of imported dma-bufs is broken at least
> >> for the Tegra DRM driver (and likely for others too) because driver
> >> doesn't assume that anyone will try to mmap imported buffer and just
> >> doesn't handle this case at all, so we're getting a hard lockup on
> >> touching mapped memory because we're mapping something else than the
> >> dma-buf.
> > =

> > Huh that sounds bad, how does this happen? Pretty much all pieces of
> > dma-buf (cpu vmap, userspace mmap, heck even dma_buf_attach) are option=
al
> > or at least can fail for various reasons. So exporters not providing mm=
ap
> > support is fine, but importers then dying is not.
> =

> Those drivers that die don't have userspace that uses dma-bufs
> extensively. I noticed it only because was looking at this code too much
> for the last days.
> =

> Drivers that don't die either map imported BOs properly or don't allow
> mapping at all.

Ah yeah driver bugs as explanation makes sense :-/

> >> My plan is to move the dma-buf management code to the level of DRM core
> >> and make it aware of the reservation locks for the dynamic dma-bufs.
> >> This way we will get the proper locking for dma-bufs and fix mapping of
> >> imported dma-bufs for Tegra and other drivers.
> > =

> > So maybe we're completely talking past each another, or coffee is not
> > working here on my end, but I've no idea what you mean.
> > =

> > We do have some helpers for taking care of the dma_resv_lock dance, and
> > Christian K=F6nig has an rfc patch set to maybe unify this further. But=
 that
> > should be fairly orthogonal to reworking shmem (it might help a bit with
> > reworking shmem though).
> =

> The reservation lock itself doesn't help much shmem, IMO. It should help
> only in the context of dynamic dma-bufs and today we don't have a need
> in the dynamic shmem dma-bufs.
> =

> You were talking about making DRM locks consistent with dma-buf locks,
> so I thought that yours main point of making use of reservation locks
> for shmem is to prepare to the new locking scheme.
> =

> I wanted to try to specify the dma-buf locking convention for mapping
> operations because it's missing right now and it should affect how DRM
> should take the reservation locks, but this is not easy to do as I see no=
w.
> =

> Could you please point at the Christian's RFC patch? He posted too many
> patches, can't find it :) I'm curious to take a look.

https://lore.kernel.org/dri-devel/20220504074739.2231-1-christian.koenig@am=
d.com/

Wrt this patch series here I'm wondering whether we could do an interim
solution that side-steps the dma_buf_vmap mess.

- in shmem helpers pin any vmapped buffer (it's how dma-buf works too),
  and that pinning would be done under dma_resv_lock (like with other
  drivers using dma_resv_lock for bo protection)

- switch over everything else except vmap code to dma_resv_lock, but leave
  vmap locking as-is

- shrinker then only needs to trylock dma_resv_trylock in the shrinker,
  which can check for pinned buffer and that's good enough to exclude
  vmap'ed buffer. And it avoids mixing the vmap locking into the new
  shrinker code and driver interfaces.

This still leaves the vmap locking mess as-is, but I think that's a mess
that's orthogonal to shrinker work.

Thoughts?
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
