Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA5C61D97
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 08:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8905E81F76;
	Fri, 27 Jan 2023 08:13:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8905E81F76
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a3EcuUiJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRDK4zfCdno5; Fri, 27 Jan 2023 08:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0FB6A81BD4;
	Fri, 27 Jan 2023 08:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FB6A81BD4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5BE9C0032;
	Fri, 27 Jan 2023 08:13:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF8F3416B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF8F3416B7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a3EcuUiJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7MRENJ5bj9w
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:13:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E37674097B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E37674097B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674807227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQyPt/6bZriSvjC5ZXh5l3TKz/N7A4kc1yntO2MilN0=;
 b=a3EcuUiJbgankfsGqdQjUxuYeqpXjm+33ZRDUapjw6HIc8qUwm6zNtTrnTmOfKn2Ot0B7p
 h2ar9hwYb0FBKyPLvBCDgOPMpYytJzvrWb+/0AgE4lV8CgYpq+pRaHPWOO3+YpVtb/lqU3
 T84tU4WJzJR5h1iZz600A3anLoUvjxo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-Z6Nj1TXBPmq0ujnQ2BEItg-1; Fri, 27 Jan 2023 03:13:42 -0500
X-MC-Unique: Z6Nj1TXBPmq0ujnQ2BEItg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39FAA3C0D845;
 Fri, 27 Jan 2023 08:13:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9E5400DE84;
 Fri, 27 Jan 2023 08:13:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B10301800606; Fri, 27 Jan 2023 09:13:39 +0100 (CET)
Date: Fri, 27 Jan 2023 09:13:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Message-ID: <20230127081339.yovxofpboc4gfdgo@sirius.home.kraxel.org>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Jan 26, 2023 at 01:55:09AM +0300, Dmitry Osipenko wrote:
> Hello Thomas and Gerd,
> 
> On 1/9/23 00:04, Dmitry Osipenko wrote:
> > This series:
> > 
> >   1. Makes minor fixes for drm_gem_lru and Panfrost
> >   2. Brings refactoring for older code
> >   3. Adds common drm-shmem memory shrinker
> >   4. Enables shrinker for VirtIO-GPU driver
> >   5. Switches Panfrost driver to the common shrinker
> > 
> > Changelog:
> > 
> > v10:- Rebased on a recent linux-next.
> > 
> >     - Added Rob's ack to MSM "Prevent blocking within shrinker loop" patch.
> > 
> >     - Added Steven's ack/r-b/t-b for the Panfrost patches.
> > 
> >     - Fixed missing export of the new drm_gem_object_evict() function.
> > 
> >     - Added fixes tags to the first two patches that are making minor fixes,
> >       for consistency.
> 
> Do you have comments on this version? Otherwise ack will be appreciated.
> Thanks in advance!

Don't feel like signing off on the locking changes, I'm not that
familiar with the drm locking rules.  So someone else looking at them
would be good.  Otherwise the series and specifically the virtio changes
look good to me.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
