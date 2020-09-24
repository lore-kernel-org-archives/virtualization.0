Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3DC2D0E2
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 07:50:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDCD2395B
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 07:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFZF4p6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDCD2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE9D4856F6;
	Thu, 24 Sep 2020 07:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aSVv4AmoR7cx; Thu, 24 Sep 2020 07:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3B67586B55;
	Thu, 24 Sep 2020 07:50:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B776C0859;
	Thu, 24 Sep 2020 07:50:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 596C6C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B35C2E0DA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SXpNg7ZaQdyz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:50:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B4F412DE2A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600933817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sqHArwthT57JphmHaTiMSE/ABTSL+yhvvPSNJ4OWT20=;
 b=RFZF4p6ulQ0Hfp9QydZh+8u9zYUfDZ7Onk60mVy2gPkNKFcoym8WIoBDNunayCFbllpVSk
 f9xXmaMiFu+GsFKPu05EoVAfLE8+VpTuSYhbaC/AySqL0IDirHVqD8wYI5SiIWtc3TWO/f
 12boFnae1mMiF5+l+IX/QZkq+U3LRt8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-2s8omoXROt6n1q4RhsK4cQ-1; Thu, 24 Sep 2020 03:50:15 -0400
X-MC-Unique: 2s8omoXROt6n1q4RhsK4cQ-1
Received: by mail-wm1-f72.google.com with SMTP id u5so912710wme.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 00:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sqHArwthT57JphmHaTiMSE/ABTSL+yhvvPSNJ4OWT20=;
 b=BOau4E1i+Pxigk1NCbNO4vUSQtjcMIs8/ggZpQ5QeyVbP8ZR6jFD1dJfnqH6aoj9Af
 nwdV5pUWzZBFePUOm1TX/62ekezdWe+uzDUN8gEtEuFQC9n0lp97bceKxVQzXHmatpeA
 fAj2i6BDwAO+eUJZoRPtGsgbEjrlSxCEGdeFnD9gE/UD28stJBjrJmDD1yp4amHI23yt
 imu82xHGhRql5uhee3Yl3kfwCnWS5pjiYvWUIsX1fRrAPx+vTFgLkHY7IgJxaBPnNVp9
 ENg/XoJpIJjX1aqC2MSi9FkgoAX9SPRVlTDU8U6CFL5xTYv33i/96diQRZ8BdPBjQ+wh
 YU0g==
X-Gm-Message-State: AOAM532gJskCY7i2XyYNfASCB6aYcrdBxT3I+0reuwRX67Uryayf7EH8
 XY9+G6zUKwZfC5PnaBm+ax5iVWG7nZqfPCgpNzYZmQRb9xPMQl+ZO92P+IS4yXYoVDTDI7PNCqF
 WkEGIlHQwRgco86cTL0AsDIX3ddN9BEJyV4asAykbeA==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr3444736wme.102.1600933814577; 
 Thu, 24 Sep 2020 00:50:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVfjv26Puupvq5kpzttvd3K18d03z40CEQlYqSb3TWLEs4O9kGbUJXSf4YGSZuLoHBXsvzKg==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr3444708wme.102.1600933814287; 
 Thu, 24 Sep 2020 00:50:14 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id y1sm2301869wma.36.2020.09.24.00.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 00:50:13 -0700 (PDT)
Date: Thu, 24 Sep 2020 03:50:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 01/24] vhost-vdpa: fix backend feature ioctls
Message-ID: <20200924034940-mutt-send-email-mst@kernel.org>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924032125.18619-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com,
 Eli Cohen <elic@nvidia.com>, rob.miller@broadcom.com
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

On Thu, Sep 24, 2020 at 11:21:02AM +0800, Jason Wang wrote:
> Commit 653055b9acd4 ("vhost-vdpa: support get/set backend features")
> introduces two malfunction backend features ioctls:
> 
> 1) the ioctls was blindly added to vring ioctl instead of vdpa device
>    ioctl
> 2) vhost_set_backend_features() was called when dev mutex has already
>    been held which will lead a deadlock
> 
> This patch fixes the above issues.
> 
> Cc: Eli Cohen <elic@nvidia.com>
> Reported-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Fixes: 653055b9acd4 ("vhost-vdpa: support get/set backend features")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Don't we want the fixes queued right now, as opposed to the rest of the
RFC?

> ---
>  drivers/vhost/vdpa.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3fab94f88894..796fe979f997 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -353,8 +353,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  	struct vdpa_callback cb;
>  	struct vhost_virtqueue *vq;
>  	struct vhost_vring_state s;
> -	u64 __user *featurep = argp;
> -	u64 features;
>  	u32 idx;
>  	long r;
>  
> @@ -381,18 +379,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  
>  		vq->last_avail_idx = vq_state.avail_index;
>  		break;
> -	case VHOST_GET_BACKEND_FEATURES:
> -		features = VHOST_VDPA_BACKEND_FEATURES;
> -		if (copy_to_user(featurep, &features, sizeof(features)))
> -			return -EFAULT;
> -		return 0;
> -	case VHOST_SET_BACKEND_FEATURES:
> -		if (copy_from_user(&features, featurep, sizeof(features)))
> -			return -EFAULT;
> -		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
> -			return -EOPNOTSUPP;
> -		vhost_set_backend_features(&v->vdev, features);
> -		return 0;
>  	}
>  
>  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
> @@ -440,8 +426,20 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	struct vhost_vdpa *v = filep->private_data;
>  	struct vhost_dev *d = &v->vdev;
>  	void __user *argp = (void __user *)arg;
> +	u64 __user *featurep = argp;
> +	u64 features;
>  	long r;
>  
> +	if (cmd == VHOST_SET_BACKEND_FEATURES) {
> +		r = copy_from_user(&features, featurep, sizeof(features));
> +		if (r)
> +			return r;
> +		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
> +			return -EOPNOTSUPP;
> +		vhost_set_backend_features(&v->vdev, features);
> +		return 0;
> +	}
> +
>  	mutex_lock(&d->mutex);
>  
>  	switch (cmd) {
> @@ -476,6 +474,10 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	case VHOST_VDPA_SET_CONFIG_CALL:
>  		r = vhost_vdpa_set_config_call(v, argp);
>  		break;
> +	case VHOST_GET_BACKEND_FEATURES:
> +		features = VHOST_VDPA_BACKEND_FEATURES;
> +		r = copy_to_user(featurep, &features, sizeof(features));
> +		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r == -ENOIOCTLCMD)
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
