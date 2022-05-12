Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236CDC433EF
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 14:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C61EE60F83;
	Thu, 12 May 2022 14:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ADB56EGaIGyU; Thu, 12 May 2022 14:15:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5186560E19;
	Thu, 12 May 2022 14:15:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F63AC0032;
	Thu, 12 May 2022 14:15:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 236F6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 14:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1031D4199E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 14:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qmb3bAoce-Tk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 14:15:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF22A4199C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 14:15:42 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id d5so7474264wrb.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=n/7pYmQpfwFthS/9oBJ6j9sdvjU7gecjyTu7MlWAR7k=;
 b=kUmh1oG60Fx0A6U56QVurQQLGKQ7477RCDCtn29lmcK1mpvRBMpGiD6hdcAaMvFXmV
 qOGgXhg3PVoHSSWjxbVmU5G5zNZqptA0VHiElu7Vy6cSSsGOyRC0I3lk0Tn4mIUNZlAw
 AsnpIb4hk5Q+SIPopSbDEj41i4yu8DkWC+t4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=n/7pYmQpfwFthS/9oBJ6j9sdvjU7gecjyTu7MlWAR7k=;
 b=vVbm4eRdIsKz8ThH2WGFEdUbYlbCtDxDGvc9OyCULJ+PwBUF2Tm56CZpnWHKYJmE3h
 xGxyKqFJ2R/VdJhNX5S/FEY5c8Ipbh7LBUfLivsoIlZq7vKfuCXYhF3WtG2A1y4aei9w
 /SDGdh13e4pGp1khUN3i8uHaEBf18DFv7fUN4yTrEa4QffMBPL5xCtdmJ7c8r/fALG1L
 DI1Ok7ije+y7/NDYTFJ8ivfu3iHHEt0aKofdQM2rjfVi45r1bLB2+ay6Br8BSNTcHEwJ
 872/KLHnimwXnti67X2n6nOQcVGCkD0F76AdtFO87j1ug3ZJwfPa5OE66yV9dGHRSIkH
 53Pg==
X-Gm-Message-State: AOAM533JYmV3RFU+fnvcKm54yL8Xgl2Jn67ZOdNXe/aVNydtuPkMQMgV
 V1yC7MFzO5KTVc00iELTd2m4MA==
X-Google-Smtp-Source: ABdhPJxgE25FTVTyKaDpk3JLkWltkhrtfTRyeVsxBvMnjZwfuCI1/qUzdN0GY0T1EvfVBkrJ5o12Vw==
X-Received: by 2002:a5d:6d8d:0:b0:20c:5f60:d551 with SMTP id
 l13-20020a5d6d8d000000b0020c5f60d551mr27919826wrs.427.1652364940783; 
 Thu, 12 May 2022 07:15:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 c13-20020adfed8d000000b0020c5253d8d7sm4428980wro.35.2022.05.12.07.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 07:15:39 -0700 (PDT)
Date: Thu, 12 May 2022 16:15:37 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <Yn0WicACq5Y46DGU@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
References: <83e68918-68de-c0c6-6f9b-e94d34b19383@collabora.com>
 <YnkaUk0mZNuPsZ5r@phenom.ffwll.local>
 <4d08b382-0076-1ea2-b565-893d50b453cb@collabora.com>
 <YnuziJDmXVR09UzP@phenom.ffwll.local>
 <56787b70-fb64-64da-6006-d3aa3ed59d12@gmail.com>
 <3a362c32-870c-1d73-bba6-bbdcd62dc326@collabora.com>
 <YnvWUbh5QDDs6u2B@phenom.ffwll.local>
 <ba2836d0-9a3a-b879-cb1e-a48aed31637d@collabora.com>
 <YnwI5UX/zvmnAHvg@phenom.ffwll.local>
 <f6e42cfb-0252-1273-2ba3-76af818e0799@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f6e42cfb-0252-1273-2ba3-76af818e0799@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Chia-I Wu <olvaffe@gmail.com>,
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

On Thu, May 12, 2022 at 09:29:35AM +0200, Christian K=F6nig wrote:
> Am 11.05.22 um 21:05 schrieb Daniel Vetter:
> > [SNIP]
> > > > > It's unclear to me which driver may ever want to do the mapping u=
nder
> > > > > the dma_resv_lock. But if we will ever have such a driver that wi=
ll need
> > > > > to map imported buffer under dma_resv_lock, then we could always =
add the
> > > > > dma_buf_vmap_locked() variant of the function. In this case the l=
ocking
> > > > > rule will sound like this:
> > > > > =

> > > > > "All dma-buf importers are responsible for holding the dma-reserv=
ation
> > > > > lock around the dmabuf->ops->mmap/vmap() calls."
> > > Are you okay with this rule?
> > Yeah I think long-term it's where we want to be, just trying to find
> > clever ways to get there.
> > =

> > And I think Christian agrees with that?
> =

> Yes, completely.
> =

> A design where most DMA-buf functions are supposed to be called with the
> reservation lock held is exactly what I have in mind for the long term.
> =

> > > > > > It shouldn't be that hard to clean up. The last time I looked i=
nto it my
> > > > > > main problem was that we didn't had any easy unit test for it.
> > > > > Do we have any tests for dma-bufs at all? It's unclear to me what=
 you
> > > > > are going to test in regards to the reservation locks, could you =
please
> > > > > clarify?
> > > > Unfortunately not really :-/ Only way really is to grab a driver wh=
ich
> > > > needs vmap (those are mostly display drivers) on an imported buffer=
, and
> > > > see what happens.
> > > > =

> > > > 2nd best is liberally sprinkling lockdep annotations all over the p=
lace
> > > > and throwing it at intel ci (not sure amd ci is accessible to the p=
ublic)
> > > > and then hoping that's good enough. Stuff like might_lock and
> > > > dma_resv_assert_held.
> > > Alright
> > So throwing it at intel-gfx-ci can't hurt I think, but that only covers
> > i915 so doesn't really help with the bigger issue of catching all the
> > drivers.
> =

> BTW: We have now somebody working on converting the existing libdrm_amdgpu
> unit tests over to igt.

This sounds awesome.

/me throws a happy dance

Cheers, Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
