Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9969DC636D7
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 22:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04E0A60B50;
	Thu, 16 Feb 2023 22:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04E0A60B50
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=jB5QcbTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBbOlCv93qk4; Thu, 16 Feb 2023 22:08:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 47A5A60ABB;
	Thu, 16 Feb 2023 22:08:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47A5A60ABB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15405C0033;
	Thu, 16 Feb 2023 22:08:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D425C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 22:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65620418EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 22:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65620418EC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=jB5QcbTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8sqrY-_QAdq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 22:08:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F554418C9
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F554418C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 22:08:09 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id p5so2630228wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1676585287;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPtKJo9uzlMbqFwgogBCaidam3IFBJ25DbmRZejTbw8=;
 b=jB5QcbTg7E/RoJswPQ07QlMEw+zeu2daTGLLLuDm9I6Od5VmBkY17pMFFuKFoD0jTA
 xoM0CpBh1hiyBe3YgAdQ7njuyr5aXbf179ad0kV05vSJX5UKxBa8Q6Jxxv6TrxqDWzUI
 iZWl9MLy9BPnaPG2rmybso0dqRp8TRloXzCwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1676585287;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JPtKJo9uzlMbqFwgogBCaidam3IFBJ25DbmRZejTbw8=;
 b=ft8ZKbmuUev1YYxZgZ988+r39I2xvs8N5Ck0exr0NxqXWh5YNxf96Jj4iM08I+wT9C
 +wBhcebuzKJSJKD05CYfuGxtNnbjAwkzmq3M3fvC4Zn1dT1iTmhdTq0Y4mdfS+nrmM12
 d8aDMm5emRDCN1gAsl33ngcqhGwG68o5buCHWvnTzB+nOj4ynvoceg1YoqNgmq3/Lq0F
 qxCBsueofT12QAESIEnpVQxxf6Ekwq7GjAWvQkmH/Ys+7/nX37ISh9WYRzNx1pFMZRgf
 5aD8fgEKGrSOsvQOT8idOTufTo1LNcLg+pACcMo2jJzEQBBpnJrm0wFMEJ91GS9TLGTC
 he2A==
X-Gm-Message-State: AO0yUKXKhEBz4TT4gmwhnLZutzIa2zQ0HR48eFGL2jFmp0GeeUdnCXF6
 Up9MasmPo4uZ6EndgLwIPT2urw==
X-Google-Smtp-Source: AK7set/3YOBop3Elq8fdTq/3aXEvc3XA6+caiK+/8lZSXrLrHk3r4WC6sfK021BpJY5Y1vaapO9s3Q==
X-Received: by 2002:a05:600c:b87:b0:3e2:415:f09f with SMTP id
 fl7-20020a05600c0b8700b003e20415f09fmr6148446wmb.3.1676585287109; 
 Thu, 16 Feb 2023 14:08:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 c63-20020a1c3542000000b003df7b40f99fsm6915429wma.11.2023.02.16.14.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 14:08:06 -0800 (PST)
Date: Thu, 16 Feb 2023 23:07:47 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Message-ID: <Y+6pM/HuBuz+eqtA@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 David Airlie <airlied@gmail.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
 <20230127081339.yovxofpboc4gfdgo@sirius.home.kraxel.org>
 <0081b2c3-56c9-3ed8-b419-5ce8a151999e@collabora.com>
 <Y+4eYqdH1Xw2OYX5@phenom.ffwll.local>
 <c6ae4f5f-7fe1-5497-a611-bee57672c289@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c6ae4f5f-7fe1-5497-a611-bee57672c289@collabora.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 kernel@collabora.com, David Airlie <airlied@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Sean Paul <sean@poorly.run>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Qiang Yu <yuq825@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

On Thu, Feb 16, 2023 at 11:43:38PM +0300, Dmitry Osipenko wrote:
> On 2/16/23 15:15, Daniel Vetter wrote:
> > On Mon, Jan 30, 2023 at 03:02:10PM +0300, Dmitry Osipenko wrote:
> >> On 1/27/23 11:13, Gerd Hoffmann wrote:
> >>> On Thu, Jan 26, 2023 at 01:55:09AM +0300, Dmitry Osipenko wrote:
> >>>> Hello Thomas and Gerd,
> >>>>
> >>>> On 1/9/23 00:04, Dmitry Osipenko wrote:
> >>>>> This series:
> >>>>>
> >>>>>   1. Makes minor fixes for drm_gem_lru and Panfrost
> >>>>>   2. Brings refactoring for older code
> >>>>>   3. Adds common drm-shmem memory shrinker
> >>>>>   4. Enables shrinker for VirtIO-GPU driver
> >>>>>   5. Switches Panfrost driver to the common shrinker
> >>>>>
> >>>>> Changelog:
> >>>>>
> >>>>> v10:- Rebased on a recent linux-next.
> >>>>>
> >>>>>     - Added Rob's ack to MSM "Prevent blocking within shrinker loop" patch.
> >>>>>
> >>>>>     - Added Steven's ack/r-b/t-b for the Panfrost patches.
> >>>>>
> >>>>>     - Fixed missing export of the new drm_gem_object_evict() function.
> >>>>>
> >>>>>     - Added fixes tags to the first two patches that are making minor fixes,
> >>>>>       for consistency.
> >>>>
> >>>> Do you have comments on this version? Otherwise ack will be appreciated.
> >>>> Thanks in advance!
> >>>
> >>> Don't feel like signing off on the locking changes, I'm not that
> >>> familiar with the drm locking rules.  So someone else looking at them
> >>> would be good.  Otherwise the series and specifically the virtio changes
> >>> look good to me.
> >>>
> >>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> >>
> >> Thomas was looking at the the DRM core changes. I expect he'll ack them.
> >>
> >> Thank you for reviewing the virtio patches!
> > 
> > I think best-case would be an ack from msm people that this looks good
> > (even better a conversion for msm to start using this).
> 
> The MSM pretty much isn't touched by this patchset, apart from the minor
> common shrinker fix. Moving whole MSM to use drm_shmem should be a big
> change to the driver.
> 
> The Panfrost and VirtIO-GPU drivers already got the acks. I also tested
> the Lima driver, which uses drm-shmem helpers. Other DRM drivers should
> be unaffected by this series.

Ah that sounds good, I somehow thought that etnaviv also uses the helpers,
but there we only had problems with dma-buf. So that's all sorted.

> > Otherwise I think the locking looks reasonable, I think the tricky bits
> > have been moving the dma-buf rules, but if you want I can try to take
> > another in-depth look. But would need to be in 2 weeks since I'm going on
> > vacations, pls ping me on irc if I'm needed.
> 
> The locking conversion is mostly a straightforward replacement of mutex
> with resv lock for drm-shmem. The dma-buf rules were tricky, another
> tricky part was fixing the lockdep warning for the bogus report of
> fs_reclaim vs GEM shrinker at the GEM destroy time where I borrowed the
> drm_gem_shmem_resv_assert_held() solution from the MSM driver where Rob
> had a similar issue.

Ah I missed that detail, if msm solved that the same way then I think very
high chances it all ends up being compatible. Which is really what
matters, not so much whether every last driver actually has converted
over.

> > Otherwise would be great if we can land this soon, so that it can soak the
> > entire linux-next cycle to catch any driver specific issues.
> 
> That will be great. Was waiting for Thomas to ack the shmem patches
> since he reviewed the previous versions, but if you or anyone else could
> ack them, then will be good too. Thanks!

I'm good for an ack, but maybe ping Thomas for a review on irc since I'm
out next week. Also maybe Thomas has some series you can help land for
cross review.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
