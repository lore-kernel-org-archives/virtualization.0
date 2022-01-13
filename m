Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545C1C433F5
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 06:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07A2783F58;
	Thu, 13 Jan 2022 06:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrXKm7XgKJhM; Thu, 13 Jan 2022 06:58:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58C6583F69;
	Thu, 13 Jan 2022 06:58:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23473C002F;
	Thu, 13 Jan 2022 06:58:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFEA6C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2473415F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N1tDUKD0BltH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:58:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C48C3415E6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642057086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Zj8WOy0le+dr0Bqm/RHKZTtpJ74d7C5Ki0kfPeyAuw=;
 b=VEFDMIZ9hSonWnQ6O0ujvpojcczmiknx+rlzhVANCaMS8f43EhgXWZTV0R9ATT2zwPddlL
 wJDo8nfCVwfVG0RQDwQAadCQzeKj9JqoMAZJxNgc6qBT02W+qV0KiEC1Nv3JHVLk5AxLiQ
 8aDcdMVfygbkzPOAl5lSDz5I+cHuHhk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-01yzV2aBMZ-ngjbXNOON0Q-1; Thu, 13 Jan 2022 01:58:05 -0500
X-MC-Unique: 01yzV2aBMZ-ngjbXNOON0Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 h11-20020a05640250cb00b003fa024f87c2so4487857edb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 22:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8Zj8WOy0le+dr0Bqm/RHKZTtpJ74d7C5Ki0kfPeyAuw=;
 b=Vq+p9Yrg+BfAa8RPLQjT5buLoeY2wn0nxDjfcbMED/DMqsPk/vw3X1q/H+EE6wCjpp
 oSHasurleT7dOMyn2mW3hrIvjVbAU6jyAe7S26/IOd8i5YmWBnlPCpJYbt6G/W3ijcy7
 xEs0/HUzb6SlDjDp12sAisXrEzw1ewphlCBFrLxmxYyj+p0Cfovm/rSdWGa6ukoCwi72
 UtOAJXGReCWe076KU3Isv5pq5QYTngyTyvQlCRafYPvfSWABDSN5U1grQX3dJPCARLIj
 waUA45QJhHDF6yQhKRpynyJYTpOTwdA40GHsMVkDjGQeBXkuVb5R+5vHyYp+v8By/Ka+
 8HQg==
X-Gm-Message-State: AOAM53203nij1CN3UT/XnVlCLbPo9XjqD2PqgvAmySzsSaRssWw+QGmg
 2Z4KxlnLJGtSQGtXQaJiEccYI+X4lLQOOMVR5CPZrdtxb/X++nEG2xop3Km/ucmdu5OX0siWYn/
 RhIgTVvO/aKp1SfoEU5dez+WM9q4au5NhqLku+UTvkA==
X-Received: by 2002:a50:eb90:: with SMTP id y16mr2899801edr.161.1642057083912; 
 Wed, 12 Jan 2022 22:58:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1FA8CT3FzHT/hQ3QEOrWXs1BvysQzXLBnm91i9jqvYxzAbsExsxR2753/tNiZep7rGPvP9g==
X-Received: by 2002:a50:eb90:: with SMTP id y16mr2899783edr.161.1642057083715; 
 Wed, 12 Jan 2022 22:58:03 -0800 (PST)
Received: from redhat.com ([2.55.6.51])
 by smtp.gmail.com with ESMTPSA id f29sm543256ejj.209.2022.01.12.22.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jan 2022 22:58:03 -0800 (PST)
Date: Thu, 13 Jan 2022 01:57:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 2/3] vdpa/mlx5: set_features should nack MQ if no CTRL_VQ
Message-ID: <20220113014704-mutt-send-email-mst@kernel.org>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <1642050651-16197-3-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1642050651-16197-3-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

On Thu, Jan 13, 2022 at 12:10:50AM -0500, Si-Wei Liu wrote:
> Made corresponding change per spec:


> The device MUST NOT offer a feature which requires another feature
> which was not offered.

Says nothing about the driver though, and you seem to be
doing things to driver features?

pls explain the motivation. which config are you trying to
fix what is current and expected behaviour.

> 
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")


It's all theoretical right? Fixes really means
"if you have commit ABC then you should pick this one up".
not really appropriate for theoretical fixes.

> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b53603d..46d4deb 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1897,11 +1897,21 @@ static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
>  	return ndev->mvdev.mlx_features;
>  }
>  
> -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> +static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 *features)


Good rename actually but document in commit log with an
explanation.

>  {
> -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> +	/* minimum features to expect */
> +	if (!(*features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
>  		return -EOPNOTSUPP;
>  
> +	/* Double check features combination sent down by the driver.
> +	 * NACK invalid feature due to the absence of depended feature.

Pls rewrite this to make it grammatical.  There's no NACK in spec. What
does this do? Fails to set FEATURES_OK?

> +	 * Driver is expected to re-read the negotiated features once
> +	 * return from set_driver_features.

once return is ungrammatical. What to say here depends on what
you mean by this, so I'm not sure.


Here's text from spec:

\item\label{itm:General Initialization And Device Operation /
Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
   understood by the OS and driver to the device.  During this step the
   driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.

\item\label{itm:General Initialization And Device Operation / Device Initialization / Set FEATURES-OK} Set the FEATURES_OK status bit.  The driver MUST NOT accept
   new feature bits after this step.

\item\label{itm:General Initialization And Device Operation / Device Initialization / Re-read FEATURES-OK} Re-read \field{device status} to ensure the FEATURES_OK bit is still
   set: otherwise, the device does not support our subset of features
   and the device is unusable.

\item\label{itm:General Initialization And Device Operation / Device Initialization / Device-specific Setup} Perform device-specific setup, including discovery of virtqueues for the
   device, optional per-bus setup, reading and possibly writing the
   device's virtio configuration space, and population of virtqueues.

does not seem to talk about re-reading features.
What did I miss?


> +	 */


This comment confuses more than it clarifies. I would
- quote the spec
- explain why does code do what it does specifically for these features

> +	if ((*features & (BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) ==
> +            BIT_ULL(VIRTIO_NET_F_MQ))
> +		*features &= ~BIT_ULL(VIRTIO_NET_F_MQ);
> +
>  	return 0;
>  }
>  
> @@ -1977,7 +1987,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  
>  	print_features(mvdev, features, true);
>  
> -	err = verify_min_features(mvdev, features);
> +	err = verify_driver_features(mvdev, &features);
>  	if (err)
>  		return err;
>  
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
