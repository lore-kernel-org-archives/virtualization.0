Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B113C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 10:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AAC9401E5;
	Mon, 27 Feb 2023 10:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AAC9401E5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j5c6+i84
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ta9Bc4e3687V; Mon, 27 Feb 2023 10:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2C0AE401DE;
	Mon, 27 Feb 2023 10:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C0AE401DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D69DAC0033;
	Mon, 27 Feb 2023 10:38:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D35C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 10:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26AE3401DB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 10:38:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26AE3401DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ipnOPMXiURr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 10:37:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70D3E401D2
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70D3E401D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677494279; x=1709030279;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=lbriUZ8YDUdLm75pRAQtvLKSIwX7Z6Uxi7I/SUAfONw=;
 b=j5c6+i84osimtTv0GxX/es5kl1HXMUAEErh99hiRTXKSqVo13djj+FjV
 f7hl55d4nLWwzA8OQmy9gOZm6NijeT7UfcNwhT3YvCFhfjfwPEqXZL9W6
 14Zyh+TXnGECsMFSt0i1a0PWrmR8cg9RUCh4WFNdoUf0INllI+JKFI1F0
 4l5Nj3U7C42o//0ASXR0KUUjMNbXWDIBYlJRkWtH4LjBipt5IWF3eKmiP
 wuZ16tyUU88poxBhcZOevCABBH36ZH0Cf88W1FV6aNDoTv1nth8RgY7pM
 2cdLpw74cZQ1htX6ESbHIrEteKsfPn7eSAZzuv+zSWs1djrkAezmNBvgi g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="335310493"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; d="scan'208";a="335310493"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 02:37:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="706136106"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; d="scan'208";a="706136106"
Received: from jkaisrli-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.252.56.158])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 02:37:49 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I
 Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Gustavo Padovan
 <gustavo.padovan@collabora.com>, Daniel Stone <daniel@fooishbar.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Rob Clark <robdclark@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, Alyssa
 Rosenzweig <alyssa.rosenzweig@collabora.com>, Rob Herring
 <robh@kernel.org>, Sean Paul <sean@poorly.run>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
In-Reply-To: <6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <ab018466-1659-d54d-4144-5e0879815de6@suse.de>
 <e9364e10-1ad8-aaaf-3d78-a29b0c1516ef@collabora.com>
 <6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com>
Date: Mon, 27 Feb 2023 12:37:46 +0200
Message-ID: <87a60z2y2t.fsf@intel.com>
MIME-Version: 1.0
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

On Mon, 27 Feb 2023, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> On 2/17/23 16:41, Dmitry Osipenko wrote:
>> On 2/17/23 16:28, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> I looked through the series. Most of the patches should have an r-b or
>>> a-b at this point. I can't say much about patch 2 and had questions
>>> about others.
>>>
>>> Maybe you can already land patches 2, and 4 to 6? They look independent
>>> from the shrinker changes. You could also attempt to land the locking
>>> changes in patch 7. They need to get testing. I'll send you an a-b for
>>> the patch.
>> 
>> Thank you, I'll apply the acked patches and then make v11 with the
>> remaining patches updated.
>> 
>> Not sure if it will be possible to split patch 8, but I'll think on it
>> for v11.
>> 
>
> Applied patches 1-2 to misc-fixes and patches 3-7 to misc-next, with the
> review comments addressed.

Please resolve the drm-tip rebuild conflict [1].

BR,
Jani.


[1] https://paste.debian.net/1272275/


-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
