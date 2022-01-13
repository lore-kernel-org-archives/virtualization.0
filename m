Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8843C433EF
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 06:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49A4E84BFD;
	Thu, 13 Jan 2022 06:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZVMXcsOzpoDc; Thu, 13 Jan 2022 06:46:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B114384BF3;
	Thu, 13 Jan 2022 06:46:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86DEAC002F;
	Thu, 13 Jan 2022 06:46:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6FFAC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6DD54098B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XAu5WSuv6mpB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:46:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4BA440984
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642056375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0YlRoQcwz0NdtSJgUI+/HqjBS/ZoPQX1VNxvwNwTOIo=;
 b=eXc6C7En8ybHi9XaB9RmQp3FdEI4r2SyXlrdQ3H/fVvsCe+8uhGghc+JqQyrhbXXv/tae6
 wjmoQJcwicXqMfzrxrZmHe2Sn80anHsDS2gw5426rkcviZYt8jVZfqizbJ7kFtijuGLqee
 Ry2UHXza8rKm9AOpE+0eHckqJ85fAaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-rLlVJ2GaPrOo0kUwpC81nQ-1; Thu, 13 Jan 2022 01:46:13 -0500
X-MC-Unique: rLlVJ2GaPrOo0kUwpC81nQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 az9-20020a05600c600900b0034692565ca8so5277619wmb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 22:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0YlRoQcwz0NdtSJgUI+/HqjBS/ZoPQX1VNxvwNwTOIo=;
 b=g36kFaywTROzaY18bhsIHixP1kfC2GQP/uMP3AopiF8Labs+U0nNV6LR3lMg5Nh5m4
 bKZV+3NqzA0A5cfRi0WPA+RdNt5UIT59DmT0ET4MVbbKkyXQuYeGXGuSVZn4YraLGIxL
 EnBo36F8ULhTP8K4QiUjbJh+sdU59PLABqHtQVdhunxwVUHyVr63eDV98GmRN2c+4O93
 onzEmtvb+Ln8RHhrvf3WVhMFMv5EU+Pv6Ll0kg6da2T40434FguZOi2VaPPUn8CCKJjU
 fCd699o3ypQneVRqFZWySbcEU4MRYnwwpHZZQKaM3F3O2PBs27u9BZq7/ihkRXUo8f++
 SJtQ==
X-Gm-Message-State: AOAM533HWAkG8Wf201kEHMuk3q0IxIU0vWbux4lJ8OhUOznBWtTh8wvt
 Hno1z+8ca9XZOAFoMAM+HrFKev4IwnSp7EbFbvHTkrixjyTNtzWFa+oTVz27JrIGSn6hVJMZJrx
 eG00B574UxrI1zIL+MWyPuERfdcsyYTL9m8FOr/CZ5g==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr2560855wrj.43.1642056372575;
 Wed, 12 Jan 2022 22:46:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxR2PFWYCktTWyxLbSYz8rrD+dXqYiAFqdyXOj1iYFMc+VNDYrKyBtmHPHzerK/+nNW5UNqfA==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr2560844wrj.43.1642056372387;
 Wed, 12 Jan 2022 22:46:12 -0800 (PST)
Received: from redhat.com ([2.55.6.51])
 by smtp.gmail.com with ESMTPSA id z3sm4718005wma.12.2022.01.12.22.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jan 2022 22:46:11 -0800 (PST)
Date: Thu, 13 Jan 2022 01:46:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 1/3] vdpa: factor out vdpa_set_features_unlocked for vdpa
 internal use
Message-ID: <20220113014517-mutt-send-email-mst@kernel.org>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <1642050651-16197-2-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1642050651-16197-2-git-send-email-si-wei.liu@oracle.com>
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

On Thu, Jan 13, 2022 at 12:10:49AM -0500, Si-Wei Liu wrote:
> No functional change introduced. vdpa bus driver such as virtio_vdpa
> or vhost_vdpa is not supposed to take care of the locking for core
> by its own. The locked API vdpa_set_features should suffice the
> bus driver's need.
> 
> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>

Not sure I get the explanation here. But I like separate APIs better
than a flag, so there.


> ---
>  drivers/vdpa/vdpa.c          |  2 +-
>  drivers/vhost/vdpa.c         |  2 +-
>  drivers/virtio/virtio_vdpa.c |  2 +-
>  include/linux/vdpa.h         | 18 ++++++++++++------
>  4 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 9846c9d..1ea5254 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -393,7 +393,7 @@ static void vdpa_get_config_unlocked(struct vdpa_device *vdev,
>  	 * If it does happen we assume a legacy guest.
>  	 */
>  	if (!vdev->features_valid)
> -		vdpa_set_features(vdev, 0, true);
> +		vdpa_set_features_unlocked(vdev, 0);
>  	ops->get_config(vdev, offset, buf, len);
>  }
>  
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8515398..ec5249e 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -286,7 +286,7 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
>  	if (copy_from_user(&features, featurep, sizeof(features)))
>  		return -EFAULT;
>  
> -	if (vdpa_set_features(vdpa, features, false))
> +	if (vdpa_set_features(vdpa, features))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 7767a7f..7650455 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -317,7 +317,7 @@ static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
>  	/* Give virtio_ring a chance to accept features. */
>  	vring_transport_features(vdev);
>  
> -	return vdpa_set_features(vdpa, vdev->features, false);
> +	return vdpa_set_features(vdpa, vdev->features);
>  }
>  
>  static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2de442e..721089b 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -401,18 +401,24 @@ static inline int vdpa_reset(struct vdpa_device *vdev)
>  	return ret;
>  }
>  
> -static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features, bool locked)
> +static inline int vdpa_set_features_unlocked(struct vdpa_device *vdev, u64 features)
>  {
>  	const struct vdpa_config_ops *ops = vdev->config;
>  	int ret;
>  
> -	if (!locked)
> -		mutex_lock(&vdev->cf_mutex);
> -
>  	vdev->features_valid = true;
>  	ret = ops->set_driver_features(vdev, features);
> -	if (!locked)
> -		mutex_unlock(&vdev->cf_mutex);
> +
> +	return ret;
> +}
> +
> +static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> +{
> +	int ret;
> +
> +	mutex_lock(&vdev->cf_mutex);
> +	ret = vdpa_set_features_unlocked(vdev, features);
> +	mutex_unlock(&vdev->cf_mutex);
>  
>  	return ret;
>  }
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
