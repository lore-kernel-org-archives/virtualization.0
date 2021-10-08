Return-Path: <SRS0=03hR=O4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5E2C433F5
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 13:05:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2169F61042
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 13:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2169F61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D378C60AEC;
	Fri,  8 Oct 2021 13:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UxMxKpG4rqBR; Fri,  8 Oct 2021 13:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E3986066B;
	Fri,  8 Oct 2021 13:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44AA4C000F;
	Fri,  8 Oct 2021 13:05:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37DB7C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 13:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18CA460AEC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 13:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rnsx1RrBuLfe
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 13:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52842606A0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633698324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVQFfb3vAI1ijnE0WV4b+1ZIo0UnTqYUbSmbQDcQl2M=;
 b=FUYCXp8hVa7g2rVhBToq6abVu04FuZ44PlRkGb7rL5k79rMhM6+PMTVas3l/k7YmZuEIxm
 EgEH7Ettnr25pl8xRH8J3S2KHp5Sdk9UmgI0kt8YWTsWcPK7T2nD2YkqyDr/fx/za+rbhD
 GrsEZ81pK1PVjZZ+zpsKIUB7jAlhBTs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-dFufM924PeOewMae1Aypjg-1; Fri, 08 Oct 2021 09:05:10 -0400
X-MC-Unique: dFufM924PeOewMae1Aypjg-1
Received: by mail-ed1-f71.google.com with SMTP id
 z6-20020a50cd06000000b003d2c2e38f1fso9165521edi.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Oct 2021 06:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uVQFfb3vAI1ijnE0WV4b+1ZIo0UnTqYUbSmbQDcQl2M=;
 b=5bsQvCM92KmnOT/JaPRxyN2T3/hJBkFfI+oOcIhlitD6r0L+H99nYe11KVRB8Wsye1
 E9b4qhwK1BAgZdGHyDcMTI2q/k4KIvFZ2kbu4as0IR0q4Gz3jVhheCle+8KxDPCgR4gI
 Gl3jQidZBPG1gil7ocR2b46/pNmfdrI3g5L+TjYIsF2VutUIP21pxUhV/820Jdqgtn06
 iLH6AEjOSOC8dIKYbpODLryL/V90pcZ/hxFsaRWSaLtgkKuR8IlnOcSM0kfBulrwboUj
 UNsqSdr4XDEV1mlif334cxQOQy1RpAFTU6hYsdu3hm58imD/XbskoEI666s3PYbmVNdE
 8Zdg==
X-Gm-Message-State: AOAM530E+xblkSIvSW+ci2oIGym3lIoWqW4dzgs/aSt7gnZbRxjGxK6m
 hn1SjUHGbh8ymA2K7jq1aZUzn1kewcVX+yNEjty+saBTAjCy0TT6IBBQ6H9nJFr1vymb4/oIw6q
 sZTwsCu45qAscgjEC0RtCIlB5llA7qhyJBUuRHtdolg==
X-Received: by 2002:a17:906:368c:: with SMTP id
 a12mr4208947ejc.143.1633698308550; 
 Fri, 08 Oct 2021 06:05:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlxA2f9rNxTHQq8IKY2BJh4lL9hMx84StuoKNUlOgnyNlZwYvMbH6zVdMCXYXCN5WHfEx88w==
X-Received: by 2002:a17:906:368c:: with SMTP id
 a12mr4208897ejc.143.1633698308147; 
 Fri, 08 Oct 2021 06:05:08 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
 by smtp.gmail.com with ESMTPSA id c10sm898413eje.37.2021.10.08.06.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Oct 2021 06:05:07 -0700 (PDT)
Date: Fri, 8 Oct 2021 09:05:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211008085839-mutt-send-email-mst@kernel.org>
References: <20211008123422.1415577-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211008123422.1415577-1-pasic@linux.ibm.com>
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

On Fri, Oct 08, 2021 at 02:34:22PM +0200, Halil Pasic wrote:
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
> is complete. However, we already have a regression so let's try to address

actually, regressions. and we can add 
"since originally before validate callback existed
config space was only read after
FEATURES_OK. See Fixes tags for relevant commits"

> it.
> 
> The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and
> the VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when
> virtio 1.0 is used on both sides. The latter renders virtio-blk unusable
> with DASD backing, because things simply don't work with the default.

Let's add a work around description now:


For QEMU, we can work around the issue by writing out the features
register with VIRTIO_F_VERSION_1 bit set.  We (ab) use the
finalize_features config op for this. It's not enough to address vhost
user and vhost block devices since these do not get the features until
FEATURES_OK, however it looks like these two actually never handled the
endian-ness for legacy mode correctly, so at least that's not a
regression.

No devices except virtio net and virtio blk seem to be affected.

Long term the right thing to do is to fix the hypervisors.


> 
> Cc: <stable@vger.kernel.org> #v4.11
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
> Reported-by: markver@us.ibm.com
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
