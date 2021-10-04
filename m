Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B7C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 09:07:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D162613A4
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 09:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D162613A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7F7F40609;
	Mon,  4 Oct 2021 09:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2gpc9G-4Tah; Mon,  4 Oct 2021 09:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C47E8400B5;
	Mon,  4 Oct 2021 09:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83AA6C000F;
	Mon,  4 Oct 2021 09:07:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86C7BC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6102842735
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZv4TRF71x4i
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:07:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EA3F42734
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633338440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUYZD9Kgpaky1z7hVZXMbU8Alpvzhtxgb9yTTSNBD4U=;
 b=ThkDu6CAsvgmk42af/OQ/iTO14JLR84Gzf0QLuhURuTFMZkB2jEyXjBTHHlLXAwZ1mzOYI
 70LCgclsFWtxCudvIg0e2p60mUdVJeRPYRd/bWI6QRbof28SUkeWbk2lypMqdEa/VGELs0
 pNVqFeeQsdCj8y+mbcMy8dcOYhqB0ME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-4F_Rx0XjN5-lq78q7G0BrQ-1; Mon, 04 Oct 2021 05:07:19 -0400
X-MC-Unique: 4F_Rx0XjN5-lq78q7G0BrQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 s10-20020a1cf20a000000b0030d66991388so2023092wmc.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 02:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KUYZD9Kgpaky1z7hVZXMbU8Alpvzhtxgb9yTTSNBD4U=;
 b=IM1OFNQl6Ws8fxgM9rMyhTI6u8+mPvmbzPd5Yoq3tUH3jaYRKpjM4uGHiGYedDgaOv
 BCTg1sM/ZUZNMYt7SZZmoc2LEmmD8Y3T+eOFJg1X4/9vUbWSO69+hqE/a3VQKdxWZPkd
 tZGgEf4Qeg0QYChuYel7dxbHkpNFOSrAQ52jH6YxHdEl4JFBJDMAYgpyAsTOfb0ussB6
 kdilx4veCeNPsepHYUKlfLB/o/zFKx2wC3QVm3WwAbk7NzvDEOh+WTc5ukzYbPMkXBvm
 tflDfVHuOQUTOwpNNomaSVy4ZkXouY/4EpxG5ertfLVmLszPVQAATs8PS0t2Q5IwpEyp
 QJ7g==
X-Gm-Message-State: AOAM530a2LYesaiF8zV3ivDTMdfBirI1f1Mi7J+YpWP8PPn80pnDiy0d
 2ysI7nVmMheqz7uDBZ8wzhWHSq6+Mi9SrWAJLc5E5wCsxVz1xb09S96zpoUwA8X1jx0VdUTmSLi
 F6rRrvxXADbsNbIlzheD8gEBL+LHU9e5ctkFjJnoDsg==
X-Received: by 2002:adf:e309:: with SMTP id b9mr12638351wrj.81.1633338438601; 
 Mon, 04 Oct 2021 02:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxetp1mwKHklXMBwe56BuI1PQiGNQTpk0T6hYH6FfLDl0lEWTgrKFExLyVwgcM3KL58TXci1w==
X-Received: by 2002:adf:e309:: with SMTP id b9mr12638322wrj.81.1633338438386; 
 Mon, 04 Oct 2021 02:07:18 -0700 (PDT)
Received: from redhat.com ([2.55.134.94])
 by smtp.gmail.com with ESMTPSA id t15sm4510863wru.6.2021.10.04.02.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 02:07:17 -0700 (PDT)
Date: Mon, 4 Oct 2021 05:07:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004040937-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211004042323.730c6a5e.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
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

On Mon, Oct 04, 2021 at 04:23:23AM +0200, Halil Pasic wrote:
> On Sat, 2 Oct 2021 14:13:37 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > Anyone else have an idea? This is a nasty regression; we could revert the
> > > patch, which would remove the symptoms and give us some time, but that
> > > doesn't really feel right, I'd do that only as a last resort.  
> > 
> > Well we have Halil's hack (except I would limit it
> > to only apply to BE, only do devices with validate,
> > and only in modern mode), and we will fix QEMU to be spec compliant.
> > Between these why do we need any conditional compiles?
> 
> We don't. As I stated before, this hack is flawed because it
> effectively breaks fencing features by the driver with QEMU. Some
> features can not be unset after once set, because we tend to try to
> enable the corresponding functionality whenever we see a write
> features operation with the feature bit set, and we don't disable, if a
> subsequent features write operation stores the feature bit as not set.

Something to fix in QEMU too, I think.

> But it looks like VIRTIO_1 is fine to get cleared afterwards.

We'd never clear it though - why would we?

> So my hack
> should actually look like posted below, modulo conditions.


Looking at it some more, I see that vhost-user actually
does not send features to the backend until FEATURES_OK.
However, the code in contrib for vhost-user-blk at least seems
broken wrt endian-ness ATM. What about other backends though?
Hard to be sure right?
Cc Raphael and Stefan so they can take a look.
And I guess it's time we CC'd qemu-devel too.

For now I am beginning to think we should either revert or just limit
validation to LE and think about all this some more. And I am inclining
to do a revert. These are all hypervisors that shipped for a long time.
Do we need a flag for early config space access then?



> 
> Regarding the conditions I guess checking that driver_features has
> F_VERSION_1 already satisfies "only modern mode", or?

Right.

> For now
> I've deliberately omitted the has verify and the is big endian
> conditions so we have a better chance to see if something breaks
> (i.e. the approach does not work). I can add in those extra conditions
> later.

Or maybe if we will go down that road just the verify check (for
performance). I'm a bit unhappy we have the extra exit but consistency
seems more important.

> 
> --------------------------8<---------------------
> 
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Thu, 30 Sep 2021 02:38:47 +0200
> Subject: [PATCH] virtio: write back feature VERSION_1 before verify
> 
> This patch fixes a regression introduced by commit 82e89ea077b9
> ("virtio-blk: Add validation for block size in config space") and
> enables similar checks in verify() on big endian platforms.
> 
> The problem with checking multi-byte config fields in the verify
> callback, on big endian platforms, and with a possibly transitional
> device is the following. The verify() callback is called between
> config->get_features() and virtio_finalize_features(). That we have a
> device that offered F_VERSION_1 then we have the following options
> either the device is transitional, and then it has to present the legacy
> interface, i.e. a big endian config space until F_VERSION_1 is
> negotiated, or we have a non-transitional device, which makes
> F_VERSION_1 mandatory, and only implements the non-legacy interface and
> thus presents a little endian config space. Because at this point we
> can't know if the device is transitional or non-transitional, we can't
> know do we need to byte swap or not.

Well we established that we can know. Here's an alternative explanation:

	The virtio specification virtio-v1.1-cs01 states:

	Transitional devices MUST detect Legacy drivers by detecting that
	VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
	This is exactly what QEMU as of 6.1 has done relying solely
	on VIRTIO_F_VERSION_1 for detecting that.

	However, the specification also says:
	driver MAY read (but MUST NOT write) the device-specific
	configuration fields to check that it can support the device before
	accepting it.

	In that case, any device relying solely on VIRTIO_F_VERSION_1
	for detecting legacy drivers will return data in legacy format.
	In particular, this implies that it is in big endian format
	for big endian guests. This naturally confuses the driver
	which expects little endian in the modern mode.

	It is probably a good idea to amend the spec to clarify that
	VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
	is complete. However, we already have regression so let's
	try to address it.


> 
> The virtio spec explicitly states that the driver MAY read config
> between reading and writing the features so saying that first accessing
> the config before feature negotiation is done is not an option. The
> specification ain't clear about setting the features multiple times
> before FEATURES_OK, so I guess that should be fine to set F_VERSION_1
> since at this point we already know that we are about to negotiate
> F_VERSION_1.
> 
> I don't consider this patch super clean, but frankly I don't think we
> have a ton of options. Another option that may or man not be cleaner,
> but is also IMHO much uglier is to figure out whether the device is
> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> according tho what we have figured out, hoping that the characteristics
> of the device didn't change.

An empty line before tags.

> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Reported-by: markver@us.ibm.com

Let's add more commits that are affected. E.g. virtio-net with MTU
feature bit set is affected too.

So let's add Fixes tag for:
commit 14de9d114a82a564b94388c95af79a701dc93134
Author: Aaron Conole <aconole@redhat.com>
Date:   Fri Jun 3 16:57:12 2016 -0400

    virtio-net: Add initial MTU advice feature
    
I think that's all, but pls double check me.


> ---
>  drivers/virtio/virtio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..2b9358f2e22a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -239,6 +239,12 @@ static int virtio_dev_probe(struct device *_d)
>  		driver_features_legacy = driver_features;
>  	}
>  
> +	/* Write F_VERSION_1 feature to pin down endianness */
> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1) & driver_features) {
> +		dev->features = (1ULL << VIRTIO_F_VERSION_1);
> +		dev->config->finalize_features(dev);
> +	}
> +
>  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>  		dev->features = driver_features & device_features;
>  	else
> -- 
> 2.31.1
> 
> 
> 
> 
> 
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
