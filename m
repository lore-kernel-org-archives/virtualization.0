Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036CEC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 11:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DADC824CE;
	Wed, 10 Aug 2022 11:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DADC824CE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=BZC3Ko+e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6tpNGlBtP92F; Wed, 10 Aug 2022 11:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 22B8581CDC;
	Wed, 10 Aug 2022 11:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22B8581CDC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED852C0033;
	Wed, 10 Aug 2022 11:47:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AACFAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 11:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8542881DBF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 11:47:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8542881DBF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F2iLcq4ROnVv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 11:47:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56B0981CDC
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56B0981CDC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 11:47:16 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id
 k6-20020a05600c1c8600b003a54ecc62f6so849016wms.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc;
 bh=BaeZbBum+4I2jOGaqSAi7IFGsiLy5fQf1iTIfmWWOdI=;
 b=BZC3Ko+eQnZVoFMw/NtIXSIKWwBGZ5JnUirPvLbP6MeZ9lAjcs7/NqIUBAAVmnmfsc
 yjF8l5SAxV6c+aoMIfXu59H8J8pu0tA1mzIb5wnr2Jep7gRbo+no+ZileVc8DHsw3Cca
 WqOuT1Cl+srXtRh0H8IL02PLB6XJFXq2TL9WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc;
 bh=BaeZbBum+4I2jOGaqSAi7IFGsiLy5fQf1iTIfmWWOdI=;
 b=A9LQBOhGq70nYdasrYgQFq/S8tTsk/BtzSMPTyP+a9pY4Nq2QwA/41rJeZ+MD51b2H
 BJucKRVKCTQJm5tyZAGKqUiwRB30M1RMoFLCuTKJ3i5/Bpy6QcwUNwL3WPm7j3qQDTOi
 Ks69Wt11xgsrbzzKxcbVbz1S5gCVJgHo6M9ZjPchKItR5KAszmeCNTHyVzvyyhoACkOJ
 tJf7X6B765E1nyHOKfNrfZpBroehlVRkO368dcGL3pMF3Qc5R8ElsLOkcvsmYKutqPGP
 oY999JVQbAFDN9UXzLXgt09tdNkIfFIDy9Yq2WMZG+VltFukBCapdPDse07/KyMl0ncP
 eA1g==
X-Gm-Message-State: ACgBeo0PHM7Tx/nsRgUrSyMlAkweQmA1CLntSSzM/l/Dew4lkPaajo8i
 DLSfMIoiwgGwmtLUFeX/4WVh+w==
X-Google-Smtp-Source: AA6agR74SoyJ7WCFqoZzbBzJESlrpKgFu1tQjTIechrYDCzQN1w2VaiNKABFBaMCcdYBj6DRC+PfJA==
X-Received: by 2002:a05:600c:4e86:b0:3a3:2edc:bcb4 with SMTP id
 f6-20020a05600c4e8600b003a32edcbcb4mr2207476wmq.85.1660132034314; 
 Wed, 10 Aug 2022 04:47:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a5d6dc2000000b002235eb9d200sm5647242wrz.10.2022.08.10.04.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 04:47:13 -0700 (PDT)
Date: Wed, 10 Aug 2022 13:47:11 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
Message-ID: <YvOav/vF2awVWIu0@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robdclark@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: dri-devel <dri-devel@lists.freedesktop.org>, kernel@collabora.com,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

On Wed, Jul 06, 2022 at 10:02:07AM +0300, Dmitry Osipenko wrote:
> On 7/6/22 00:48, Rob Clark wrote:
> > On Tue, Jul 5, 2022 at 4:51 AM Christian K=F6nig <christian.koenig@amd.=
com> wrote:
> >>
> >> Am 01.07.22 um 11:02 schrieb Dmitry Osipenko:
> >>> Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don't
> >>> handle imported dma-bufs properly, which results in mapping of someth=
ing
> >>> else than the imported dma-buf. On NVIDIA Tegra we get a hard lockup =
when
> >>> userspace writes to the memory mapping of a dma-buf that was imported=
 into
> >>> Tegra's DRM GEM.
> >>>
> >>> Majority of DRM drivers prohibit mapping of the imported GEM objects.
> >>> Mapping of imported GEMs require special care from userspace since it
> >>> should sync dma-buf because mapping coherency of the exporter device =
may
> >>> not match the DRM device. Let's prohibit the mapping for all DRM driv=
ers
> >>> for consistency.
> >>>
> >>> Suggested-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> >>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>
> >> I'm pretty sure that this is the right approach, but it's certainly mo=
re
> >> than possible that somebody abused this already.
> > =

> > I suspect that this is abused if you run deqp cts on android.. ie. all
> > winsys buffers are dma-buf imports from gralloc.  And then when you
> > hit readpix...
> > =

> > You might only hit this in scenarios with separate gpu and display (or
> > dGPU+iGPU) because self-imports are handled differently in
> > drm_gem_prime_import_dev().. and maybe not in cases where you end up
> > with a blit from tiled/compressed to linear.. maybe that narrows the
> > scope enough to just fix it in userspace?
> =

> Given that that only drivers which use DRM-SHMEM potentially could've
> map imported dma-bufs (Panfrost, Lima) and they already don't allow to
> do that, I think we're good.

So can I have an ack from Rob here or are there still questions that this
might go boom?

Dmitry, since you have a bunch of patches merged now I think would also be
good to get commit rights so you can drive this more yourself. I've asked
Daniel Stone to help you out with getting that.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
