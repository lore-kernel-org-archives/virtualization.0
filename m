Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85D1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAD8610C8
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BAD8610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23AD66084A;
	Wed, 13 Oct 2021 10:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IhlZRr2U6i-4; Wed, 13 Oct 2021 10:10:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9768D605DA;
	Wed, 13 Oct 2021 10:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEE6C000F;
	Wed, 13 Oct 2021 10:10:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F322C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8AC4B4047C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RHclqwRwDcj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:10:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A824402D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634119816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIV6EWlf8IYh7mOxA5NB+uuQJyLxn6kGVxkuMI5GYog=;
 b=bsGly8ZB84YYvX2eeaAnMpAK+4QdXYnJ6Yq9s9K8I2nvyQBa5fu16RHLd4OGAEAfmEaFAF
 cVHVBEQBwijOqKjvlTd51weOsrFi8T3rBWl5JuXAjF8pMV+n3cYcQPFcnDQF96xjKow792
 B/J+A7JltqQ2C2qwxBVVxOvjYpqdrGs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-AVpwt87VMvy8HpatjDrZXg-1; Wed, 13 Oct 2021 06:10:15 -0400
X-MC-Unique: AVpwt87VMvy8HpatjDrZXg-1
Received: by mail-wr1-f69.google.com with SMTP id
 p12-20020adfc38c000000b00160d6a7e293so1542821wrf.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XIV6EWlf8IYh7mOxA5NB+uuQJyLxn6kGVxkuMI5GYog=;
 b=6kDZbKaMrBVAKA9F2eRpI1O61KGZW66j5qvDE8HfMNtmLtEEeL2GvERHm2ugggBnn6
 W2LG4UHgYEEA2n2nqtF4E5yZj0EZg8ijfPdHnpTJT1UuAAdJ74QlW5cyZL2oJYStU2r/
 2igKREcN7M3skBOC4BB3XwTSV7+tQhYswWeSO7DDZJf2+Bp+S+t3qmOHkk332bDTSl1N
 l/jCIpuPA5LYNyarSjCMriCpC3iwdbaonQG8bMIzOXxNx76Yib7iO3xxrgzyEPcvDUGJ
 v+3BjZ7W4CJb62RFpX4gIjmGGpxXT2xCbqN27L5PNv9NX+415Ucxdh0KOTpUxKKXGHp2
 HJVQ==
X-Gm-Message-State: AOAM532nMHBVVq3bZTih8Wrk1hyy/t6sQTnPCLwOzuOP+J7yuCOCC5eL
 breS99pxmTAsPa+xagVH+2RdwLxdHug89+in7MuA0mQcVXtDoBWIf66izDfEIOha6c0VWtvbwvM
 M6ijGxKbuaxcUhB/MBDc7Qt9Ge9RrEcdz3JNtVxBf6Q==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr38598485wrz.26.1634119814019; 
 Wed, 13 Oct 2021 03:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdzEUsRMSd5Z6w3cXq4dmtWNY5MNbht2wMdWdZK2XnSLKoIDFYiOilvxVG3omeTmm8H874VQ==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr38598465wrz.26.1634119813789; 
 Wed, 13 Oct 2021 03:10:13 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id p25sm4782688wma.2.2021.10.13.03.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 03:10:13 -0700 (PDT)
Date: Wed, 13 Oct 2021 06:10:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211013060923-mutt-send-email-mst@kernel.org>
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211011053921.1198936-1-pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

On Mon, Oct 11, 2021 at 07:39:21AM +0200, Halil Pasic wrote:
> The virtio specification virtio-v1.1-cs01 states: "Transitional devices
> MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
> been acknowledged by the driver."  This is exactly what QEMU as of 6.1
> has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
> 
> However, the specification also says: "... the driver MAY read (but MUST
> NOT write) the device-specific configuration fields to check that it can
> support the device ..." before setting FEATURES_OK.
> 
> In that case, any transitional device relying solely on
> VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
> legacy format.  In particular, this implies that it is in big endian
> format for big endian guests. This naturally confuses the driver which
> expects little endian in the modern mode.
> 
> It is probably a good idea to amend the spec to clarify that
> VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> is complete. Before validate callback existed, config space was only
> read after FEATURES_OK. However, we already have two regressions, so
> let's address this here as well.
> 
> The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and
> the VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when
> virtio 1.0 is used on both sides. The latter renders virtio-blk unusable
> with DASD backing, because things simply don't work with the default.
> See Fixes tags for relevant commits.
> 
> For QEMU, we can work around the issue by writing out the feature bits
> with VIRTIO_F_VERSION_1 bit set.  We (ab)use the finalize_features
> config op for this. This isn't enough to address all vhost devices since
> these do not get the features until FEATURES_OK, however it looks like
> the affected devices actually never handled the endianness for legacy
> mode correctly, so at least that's not a regression.
> 
> No devices except virtio net and virtio blk seem to be affected.
> 
> Long term the right thing to do is to fix the hypervisors.
> 
> Cc: <stable@vger.kernel.org> #v4.11
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
> Reported-by: markver@us.ibm.com
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

OK this looks good! How about a QEMU patch to make it spec compliant on
BE?

> ---
> 
> @Connie: I made some more commit message changes to accommodate Michael's
> requests. I just assumed these will work or you as well and kept your
> r-b. Please shout at me if it needs to be dropped :)
> ---
>  drivers/virtio/virtio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..236081afe9a2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -239,6 +239,17 @@ static int virtio_dev_probe(struct device *_d)
>  		driver_features_legacy = driver_features;
>  	}
>  
> +	/*
> +	 * Some devices detect legacy solely via F_VERSION_1. Write
> +	 * F_VERSION_1 to force LE config space accesses before FEATURES_OK for
> +	 * these when needed.
> +	 */
> +	if (drv->validate && !virtio_legacy_is_little_endian()
> +			  && device_features & BIT_ULL(VIRTIO_F_VERSION_1)) {
> +		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> +		dev->config->finalize_features(dev);
> +	}
> +
>  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>  		dev->features = driver_features & device_features;
>  	else
> 
> base-commit: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
