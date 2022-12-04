Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263AEC4321E
	for <virtualization@archiver.kernel.org>; Sun,  4 Dec 2022 16:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87538408DF;
	Sun,  4 Dec 2022 16:52:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87538408DF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WyHFw9Lm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UAWJITSncnW2; Sun,  4 Dec 2022 16:52:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8B8E408CA;
	Sun,  4 Dec 2022 16:52:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8B8E408CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE6CC0033;
	Sun,  4 Dec 2022 16:52:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F315AC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 16:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C768440133
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 16:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C768440133
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WyHFw9Lm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C9RKZfYXZ6Fs
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 16:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16BFB40124
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16BFB40124
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 16:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670172722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bd0kbo1nZo+zq6yqZxAOcG/WcZc7sS+E0SxytjtCulA=;
 b=WyHFw9Lm4IISdsMrWAmzTL6aSHd0auKbnvj1TEPL8bvpn8oFwEtL0n4gYMIH69ZiBKKVvd
 w2lFJHJxd6+PtK5virLCMBuTSev6JxNyqZWML4ylf/V8dF1ZPmcjdM/gpMmX4WuwzEhlll
 EYFcaQzwJWQs7AmTHOxKVcjEY5kTBCU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-ZtiKZdQXPYCznP9UnWtbDQ-1; Sun, 04 Dec 2022 11:52:01 -0500
X-MC-Unique: ZtiKZdQXPYCznP9UnWtbDQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 204-20020a1c02d5000000b003d1caf13f32so389420wmc.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Dec 2022 08:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bd0kbo1nZo+zq6yqZxAOcG/WcZc7sS+E0SxytjtCulA=;
 b=Xsj0pbrQVheZ9c58UxHfClWuT3zmQK9+LtaJwxDXwsMY9IX4QCfHSOxQMP5oQmG3Uy
 A4DtU5Rvu76y/co5y84MXeBqf/7TnHCBq47Rl12krD5je9mJKFtlw6aZNa6ql/Mjadfd
 kgnLNOSVafVqglXDzywmv4njn9zvjQy/7+6IdnvpRagUXEccL08bPU7OOzxPJPtjwZG+
 oZjppdAL9iNesjXr3ZnIMxFnSGRI1Kz2WCpl7G7qiLUA8aEGTup5ecm6L6d9qBXNcvMv
 HrGEcu88/2wFWKm6+bQopwUMdDa7ICrzh6S70S8gA9XUu6lmEU6mZLMPJBq5/btrSwt0
 NuOA==
X-Gm-Message-State: ANoB5pnTuW/Lg3cfCudlWMKNXLM1bwhkcun4V5IQg1rQClcsrkegwbmR
 pws2W0MbOq9zftszIplEYKLZb7QtLwZXycGgLMWviuWDHNTR/+qO1A7fdWlAd6+fmzH+COxsky3
 vO2W9Jl1phipQ9eleWy5gPe7Itq3GSQduAz/dMTAtKQ==
X-Received: by 2002:a05:600c:1d12:b0:3cf:8441:4a7c with SMTP id
 l18-20020a05600c1d1200b003cf84414a7cmr62381602wms.0.1670172719928; 
 Sun, 04 Dec 2022 08:51:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7iaPMTNsRe5EqfYxvFhG5bUHPBtXqfO+l28aCGHInboU0lYXnjRgH7IwMDGtMvTXfYoYAzsg==
X-Received: by 2002:a05:600c:1d12:b0:3cf:8441:4a7c with SMTP id
 l18-20020a05600c1d1200b003cf84414a7cmr62381593wms.0.1670172719699; 
 Sun, 04 Dec 2022 08:51:59 -0800 (PST)
Received: from redhat.com ([2.52.16.138]) by smtp.gmail.com with ESMTPSA id
 bg28-20020a05600c3c9c00b003cfa3a12660sm23543000wmb.1.2022.12.04.08.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Dec 2022 08:51:58 -0800 (PST)
Date: Sun, 4 Dec 2022 11:51:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221204112900-mutt-send-email-mst@kernel.org>
References: <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
 <Y4UG6lQXbzxOix1/@fedora>
 <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
 <20221129001239-mutt-send-email-mst@kernel.org>
 <b76ad252-3f6a-8f4b-cb2d-0a4f45860aae@nvidia.com>
 <CAJs=3_Bma3KiOW3Cah2KWiN34TG4c=bdw1bTjB71Fo_QLaKmXw@mail.gmail.com>
 <20221204055044-mutt-send-email-mst@kernel.org>
 <CAJs=3_D1nX3K4=PXiS_CoLHmq1TbYUhecM6CkWT6FCV1JV2PCA@mail.gmail.com>
 <20221204072703-mutt-send-email-mst@kernel.org>
 <CAJs=3_B91G7=ABYOBwZz8nZwNYFQwMLjtLiHHvitYx8uE+HEoA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_B91G7=ABYOBwZz8nZwNYFQwMLjtLiHHvitYx8uE+HEoA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Sun, Dec 04, 2022 at 04:37:28PM +0200, Alvaro Karsz wrote:
> > And now is this generic enough to disconnect from virtio and
> > make it a generic blk thing?
> 
> It could be generic enough if we drop the virtio structs and pass
> single fields as elements.
> The point is, we can easily make it generic enough, do we want to?
> 
> At the moment, there is at least 1 existing device-specific ioctl to
> retrieve lifetime info (that I'm aware of),
> MMC_IOC_CMD for a MMC device with MMC_SEND_EXT_CSD opcode.
> So we will have duplication for MMC devices (for some of the lifetime fields).
> 
> Do you want it to be blk generic?
> 
> Alvaro

I don't really know enough about this. I think you should CC some storage
mailing lists and relevant maintainers, to understand whether it's
likely other drivers will reuse a generic IOCTL.

My point is this, virtio will need to be implemented on top of a
physical device. If that device has a lifetime ioctl then it's easy to
run it on host and forward the data without poking at device specific
detail. But, that requires agreement from at least some host
device maintainers. If that's not agreed upon, I'd say let's
just get the current version in, LE endian, no padding, just
reflect virtio command to userspace as is.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
