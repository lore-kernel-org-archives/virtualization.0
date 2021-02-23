Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A7C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:26:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D051064E4B
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D051064E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5CD32865D5;
	Tue, 23 Feb 2021 12:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNwzUntul8kg; Tue, 23 Feb 2021 12:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8258786003;
	Tue, 23 Feb 2021 12:26:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67466C000A;
	Tue, 23 Feb 2021 12:26:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE63C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9886883880
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RDR0qD0bA3JH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37C29835EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614083194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlRBImIxcwNi4rHuXYdMygYUREHsouYdgn7QLrLfVHk=;
 b=Cm7JP0N6Y4V+fPR2CAzm1X8u0BXkQzkxF11gHD6NxQFTiND4oFH3ezFalWAhasPnjnk2ew
 UedT9/DZncHRxoMJeLUFsVym6MecefjjFKyl1qKxF0JC2nf+v9BPbQ9ZJ6hrxhT4WKd5mi
 Mat82PjKEPI5pDo/o3tSDC8UtO35jkc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-hW7JZblTMseXSyQ3pObowQ-1; Tue, 23 Feb 2021 07:26:33 -0500
X-MC-Unique: hW7JZblTMseXSyQ3pObowQ-1
Received: by mail-wr1-f72.google.com with SMTP id v3so790085wro.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dlRBImIxcwNi4rHuXYdMygYUREHsouYdgn7QLrLfVHk=;
 b=iuB027UaDULaeeRkKasFz31nIl8HxXGrzbD8daAohbYjMX5Oet6R2NgAAb9FryDQ8r
 3l7tPGY33nFj7trbYOAIJHH5t3h1nbzdP/yZeASdj5jLDQFLAUrXRAWPzG+928Wt/RBC
 LUAr5A+Tz4+GfvXVQnveFSGdVOfvSxlz6f/YdLNvHnj2cm7B6GAwx+kUd5xImvYPRZxe
 DGFnG0Hb+9ZxPAGXzW0SRYIWKwFh7AhCXyRg033vTh3p4oOK3xrjtGTFlNegAbctU+T9
 eaGgJnHrYnVbKU7l3Ob/edvj7yMvLLnGcTYTUAZCqpfHogARH/Ekm3LQamh1oPfQu8qP
 xg7Q==
X-Gm-Message-State: AOAM533b53I/42sPIOKcY7jpxJYGBjGre75W/NnBfgvRKFYTB+rSp5m3
 wDy6/VmI81TabK1PLv1Pa4f8LCya+PLz1pdl+lGjnvXeXvcHXTsMpae2kjrxZ4JvXFLBuDAYtw0
 hQO7uSYAKGQvgFUtjOKMgZdXA2TCSVDjsIFb3JjwwsA==
X-Received: by 2002:a5d:5109:: with SMTP id s9mr25259276wrt.325.1614083192188; 
 Tue, 23 Feb 2021 04:26:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxocWMZ+yxHbiie9t5x9KGG8c7GcIkLf9fWyaLKqgKNZ40RLp7+9DospqS4cosjlYPsyzL2NQ==
X-Received: by 2002:a5d:5109:: with SMTP id s9mr25259260wrt.325.1614083191996; 
 Tue, 23 Feb 2021 04:26:31 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id e17sm9660537wro.36.2021.02.23.04.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:26:31 -0800 (PST)
Date: Tue, 23 Feb 2021 07:26:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223072047-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

On Fri, Feb 19, 2021 at 06:54:58AM -0500, Si-Wei Liu wrote:
> Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> for legacy") made an exception for legacy guests to reset
> features to 0, when config space is accessed before features
> are set. We should relieve the verify_min_features() check
> and allow features reset to 0 for this case.
> 
> It's worth noting that not just legacy guests could access
> config space before features are set. For instance, when
> feature VIRTIO_NET_F_MTU is advertised some modern driver
> will try to access and validate the MTU present in the config
> space before virtio features are set. Rejecting reset to 0
> prematurely causes correct MTU and link status unable to load
> for the very first config space access, rendering issues like
> guest showing inaccurate MTU value, or failure to reject
> out-of-range MTU.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")

isn't this more

    vdpa: make sure set_features is invoked for legacy


> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

I think we at least need to correct the comment in
include/linux/vdpa.h then

Instead of "we assume a legacy guest" we'd say something like
"call set features in case it's a legacy guest".

Generally it's unfortunate. Need to think about what to do here.
Any idea how else we can cleanly detect a legacy guest?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 7c1f789..540dd67 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1490,14 +1490,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>  	return mvdev->mlx_features;
>  }
>  
> -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> -{
> -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> -		return -EOPNOTSUPP;
> -
> -	return 0;
> -}
> -
>  static int setup_virtqueues(struct mlx5_vdpa_net *ndev)
>  {
>  	int err;

Let's just set VIRTIO_F_ACCESS_PLATFORM in core?
Then we don't need to hack mlx5 ...


> @@ -1558,18 +1550,13 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> -	int err;
>  
>  	print_features(mvdev, features, true);
>  
> -	err = verify_min_features(mvdev, features);
> -	if (err)
> -		return err;
> -
>  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
>  	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
>  	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> -	return err;
> +	return 0;
>  }
>  
>  static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
