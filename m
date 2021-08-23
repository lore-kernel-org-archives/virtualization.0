Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F6C4338F
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5BF6137B
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E5BF6137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBE5A80C48;
	Mon, 23 Aug 2021 12:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uKxyvIyds1hc; Mon, 23 Aug 2021 12:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3333A80D3A;
	Mon, 23 Aug 2021 12:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07F9FC0010;
	Mon, 23 Aug 2021 12:13:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4423AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 12:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DF1F60653
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 12:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfMbCyU3zxSd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 12:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 267136005E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629720822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JT+bCKc38JLNC9Va4YKqVGOJW8N9pOWm+qNgeILEytE=;
 b=LyBXvK0ZPnMKNmarg4qNC4C2ief/Aej0VTs8Dsh8jyzx0mbDO7YtxO3FcEJp9Qui8OlMbQ
 C631reEx9/RJ6MUNung6fEk+gTc3RJc7NrdsVhDvTohnFv6wkRQ2+ag06Kxah7sXtvuQob
 daWjmOsjGRchbkEvNwDlwhvtBLaa0Go=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-baQZmc9QN5q34sJC3wcn8Q-1; Mon, 23 Aug 2021 08:13:40 -0400
X-MC-Unique: baQZmc9QN5q34sJC3wcn8Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 di3-20020a056402318300b003bebf0828a2so8707563edb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 05:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JT+bCKc38JLNC9Va4YKqVGOJW8N9pOWm+qNgeILEytE=;
 b=Wpb1tEURHsbiXW0cblVWaocqYmgFCj03/Fxagj3wNXkwI2/m/LNwg4Mpy6QEKw52nA
 qR/gbRO4xjN9J8X75zVuoBi2Mkvwq6Ydvar9GAfWI9VN3iiNgGn6FTgy1onIxTci7b5A
 1hzJrW/+OHaGjSH8Ee3X1rZ40B3M5TKKxzhw+GdX6dwcBVflAQYcLcPXm5nrTpmX6B/R
 W/C4NGtwXwYd0Xo8MnLU4FVwuc4czNbyi4v9ScKfjq7MXGpLc1ZFqIjg9zI0/oXE0av1
 DJVeMnYHMMKQK/MURPdTE1l/x/hgWz1CzhpdN7BQQHbMFAASimiV7pbb7DtLXMRwyLp8
 p+Jg==
X-Gm-Message-State: AOAM533aESUmVbHfdXdftAXBnvwqMM7z6UEIiPeyNubhkjJI4uZ23aHk
 5L1BSJe6N1Q+BxP2e+gKCUpobMZ2SJDFjvb3hAUiHor4LUNIosy99RoTyjjj1sL4s9oFCD8Q1mG
 BfmZ6OlydPrYa8dxsvIINqDr/6kdVbRXQKK4K3CSWgw==
X-Received: by 2002:a17:907:9602:: with SMTP id
 gb2mr36019878ejc.354.1629720818842; 
 Mon, 23 Aug 2021 05:13:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs3MgLnvPcrpYfGFxBWk9K8vF4MlQe2baF1pKyG/R6hpM154XvcXcuHF9RIJJddLpwSfuBWw==
X-Received: by 2002:a17:907:9602:: with SMTP id
 gb2mr36019860ejc.354.1629720818703; 
 Mon, 23 Aug 2021 05:13:38 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
 by smtp.gmail.com with ESMTPSA id y32sm155000ede.22.2021.08.23.05.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 05:13:37 -0700 (PDT)
Date: Mon, 23 Aug 2021 08:13:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210823080952-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
 <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
 <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
 <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> It helpful if there is a justification for this.
> 
> In this case, no such HW device exist and the only device that can cause
> this trouble today is user space VDUSE device that must be validated by the
> emulation VDUSE kernel driver.
> 
> Otherwise, will can create 1000 commit like this in the virtio level (for
> example for each feature for each virtio device).

Yea, it's a lot of work but I don't think it's avoidable.

> > 
> > > > > > And regardless of userspace device, we still need to fix it for other cases.
> > > > > which cases ? Do you know that there is a buggy HW we need to workaround ?
> > > > > 
> > > > No, there isn't now. But this could be a potential attack surface if
> > > > the host doesn't trust the device.
> > > If the host doesn't trust a device, why it continues using it ?
> > > 
> > IIUC this is the case for the encrypted VMs.
> 
> what do you mean encrypted VM ?
> 
> And how this small patch causes a VM to be 100% encryption supported ?
> 
> > > Do you suggest we do these workarounds in all device drivers in the kernel ?
> > > 
> > Isn't it the driver's job to validate some unreasonable configuration?
> 
> The check should be in different layer.
> 
> Virtio blk driver should not cover on some strange VDUSE stuff.

Yes I'm not convinced VDUSE is a valid use-case. I think that for
security and robustness it should validate data it gets from userspace
right there after reading it.
But I think this is useful for the virtio hardening thing.
https://lwn.net/Articles/865216/

Yongji - I think the commit log should be much more explicit that
this is hardening. Otherwise people get confused and think this
needs a CVE or a backport for security.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
