Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A07EC61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 12:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D755C6119C;
	Thu, 16 Feb 2023 12:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D755C6119C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=ZwmW+/ts
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0EKLbMw-Rpi; Thu, 16 Feb 2023 12:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5381260A6B;
	Thu, 16 Feb 2023 12:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5381260A6B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39B7DC0032;
	Thu, 16 Feb 2023 12:15:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A160C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27C9081FD3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:15:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27C9081FD3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=ZwmW+/ts
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cALqivYTKZG1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:15:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E46FB81F84
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E46FB81F84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:15:40 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id m10so1655653wrn.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=piaqzgCKFZLQmY10k4IjC7MluutMq0LDizDNTJemOVE=;
 b=ZwmW+/tsxiqhy4Fe8h8o+D+0Y3rKgPhqnPVd3h2SXXjq9GFWsGM/IYJuSGdI/VS12v
 ONNkkDZVd0AjsYVwEKCHys6pJs4ZVXw9sDzzrSQZ72h1ZFRYSu92lypNMVcYe8A7bQeU
 Emw+iqP0l5YYH99k1kkz89QUaXRVbiZ7JWnEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=piaqzgCKFZLQmY10k4IjC7MluutMq0LDizDNTJemOVE=;
 b=0szHwnO6HIGbAX3Mky8aPR7/PjUnbKB91ISk64v6T0QrQlfp8ZLnHgYrMv/CEIAN+L
 Ip8sk3FtIK5huEAhGFEUsgyyZvXPI1seVm2UTrMeard5G2Rhf9bj6WCdEWP8/904Dbyn
 EfM6ZGGCv6f3hdXz0ngcNFb5fwdqyfJ9NrkAnxiiCDO7MwizgSn4eWmnzT3vu4Iv+GC/
 cEu2eSF98dFZ6u1DAT0DKbaMkhDiO302imdc3JMUpJA5yL81Xu04Tmi8R77QzjmB2N2X
 9niTHWGCNTQkqsWVe8Iq39vGyVk6vtwDIB6/b+IJGGub8QYu4GFS7ukUu9AF5TdxpmHw
 CNLA==
X-Gm-Message-State: AO0yUKUAzLKTYAQ0bajw76XZjFIaQpFWjl/+ao9kguZ4M1m5lMX0QEuQ
 97QWMOanYUMU6xfP9qQGrVwvOQ==
X-Google-Smtp-Source: AK7set8htScoYo9KcDutSph1npWSqUrZBvhCgkZbtOlJws9UnAqhqfODu6C0HWh4XJFXcCSIORzQUA==
X-Received: by 2002:a5d:46d1:0:b0:2bf:de9c:4595 with SMTP id
 g17-20020a5d46d1000000b002bfde9c4595mr3616218wrs.5.1676549739053; 
 Thu, 16 Feb 2023 04:15:39 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 u11-20020a5d514b000000b002425be3c9e2sm1364716wrt.60.2023.02.16.04.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 04:15:38 -0800 (PST)
Date: Thu, 16 Feb 2023 13:15:30 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Message-ID: <Y+4eYqdH1Xw2OYX5@phenom.ffwll.local>
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
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0081b2c3-56c9-3ed8-b419-5ce8a151999e@collabora.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 kernel@collabora.com, David Airlie <airlied@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Sean Paul <sean@poorly.run>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Qiang Yu <yuq825@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
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

On Mon, Jan 30, 2023 at 03:02:10PM +0300, Dmitry Osipenko wrote:
> On 1/27/23 11:13, Gerd Hoffmann wrote:
> > On Thu, Jan 26, 2023 at 01:55:09AM +0300, Dmitry Osipenko wrote:
> >> Hello Thomas and Gerd,
> >>
> >> On 1/9/23 00:04, Dmitry Osipenko wrote:
> >>> This series:
> >>>
> >>>   1. Makes minor fixes for drm_gem_lru and Panfrost
> >>>   2. Brings refactoring for older code
> >>>   3. Adds common drm-shmem memory shrinker
> >>>   4. Enables shrinker for VirtIO-GPU driver
> >>>   5. Switches Panfrost driver to the common shrinker
> >>>
> >>> Changelog:
> >>>
> >>> v10:- Rebased on a recent linux-next.
> >>>
> >>>     - Added Rob's ack to MSM "Prevent blocking within shrinker loop" patch.
> >>>
> >>>     - Added Steven's ack/r-b/t-b for the Panfrost patches.
> >>>
> >>>     - Fixed missing export of the new drm_gem_object_evict() function.
> >>>
> >>>     - Added fixes tags to the first two patches that are making minor fixes,
> >>>       for consistency.
> >>
> >> Do you have comments on this version? Otherwise ack will be appreciated.
> >> Thanks in advance!
> > 
> > Don't feel like signing off on the locking changes, I'm not that
> > familiar with the drm locking rules.  So someone else looking at them
> > would be good.  Otherwise the series and specifically the virtio changes
> > look good to me.
> > 
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Thomas was looking at the the DRM core changes. I expect he'll ack them.
> 
> Thank you for reviewing the virtio patches!

I think best-case would be an ack from msm people that this looks good
(even better a conversion for msm to start using this).

Otherwise I think the locking looks reasonable, I think the tricky bits
have been moving the dma-buf rules, but if you want I can try to take
another in-depth look. But would need to be in 2 weeks since I'm going on
vacations, pls ping me on irc if I'm needed.

Otherwise would be great if we can land this soon, so that it can soak the
entire linux-next cycle to catch any driver specific issues.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
